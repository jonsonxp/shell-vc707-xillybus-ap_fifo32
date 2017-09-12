`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/09/2015 10:19:35 AM
// Design Name:
// Module Name: xillybus_interface
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module xillybus_interface
  (
   /*AUTOARG*/
   // Outputs
   GPIO_LED, PCIE_TX_N, PCIE_TX_P, in_r_dout, in_r_empty_n, bus_clk,
   ip_rst_n, memarray_out,
   // Inputs
   PCIE_PERST_B_LS, PCIE_REFCLK_N, PCIE_REFCLK_P, PCIE_RX_N,
   PCIE_RX_P, ip_clk, in_r_read, out_r_din, out_r_full, out_r_write
   );

   input  PCIE_PERST_B_LS;
   input  PCIE_REFCLK_N;
   input  PCIE_REFCLK_P;
   input [7:0] PCIE_RX_N;
   input [7:0] PCIE_RX_P;
   input       ip_clk;
   input       in_r_read;
   input [31:0] out_r_din;
   input        out_r_full;
   input        out_r_write;
   output [3:0] GPIO_LED;
   output [7:0] PCIE_TX_N;
   output [7:0] PCIE_TX_P;
   output [31:0] in_r_dout;
   output 	 in_r_empty_n;
   output        bus_clk;
   output 	 ip_rst_n;
   output [8*32-1:0] memarray_out;

   wire 	 hls_fifo_rd_en;
   reg 		 in_r_empty_n;

   wire 	 bus_clk;
   wire 	 quiesce;
   reg [7:0] 	 memarray[0:31];
   wire [8*32-1:0] memarray_out;
   wire 	 user_r_mem_8_rden;
   wire 	 user_r_mem_8_empty;
   reg [7:0] 	 user_r_mem_8_data;
   wire 	 user_r_mem_8_eof;
   wire 	 user_r_mem_8_open;
   wire 	 user_w_mem_8_wren;
   wire 	 user_w_mem_8_full;
   wire [7:0] 	 user_w_mem_8_data;
   wire 	 user_w_mem_8_open;
   wire [4:0] 	 user_mem_8_addr;
   wire 	 user_mem_8_addr_update;
   wire 	 user_r_read_32_rden;
   wire 	 user_r_read_32_empty;
   wire [31:0] 	 user_r_read_32_data;
   wire 	 user_r_read_32_eof;
   wire 	 user_r_read_32_open;
   wire 	 user_r_read_8_rden;
   wire 	 user_r_read_8_empty;
   wire [7:0] 	 user_r_read_8_data;
   wire 	 user_r_read_8_eof;
   wire 	 user_r_read_8_open;
   wire 	 user_w_write_32_wren;
   wire 	 user_w_write_32_full;
   wire [31:0] 	 user_w_write_32_data;
   wire 	 user_w_write_32_open;
   wire 	 user_w_write_8_wren;
   wire 	 user_w_write_8_full;
   wire [7:0] 	 user_w_write_8_data;
   wire 	 user_w_write_8_open;
   
   genvar i;
   for (i=0; i<8; i=i+1) assign memarray_out[32*i+31:32*i] = memarray[i];

   assign ip_rst_n = ~(!user_w_write_32_open && !user_r_read_32_open);
   assign  hls_fifo_rd_en = !hls_fifo_empty && (in_r_read || !in_r_empty_n);
   
   assign  user_r_read_32_eof = 0;
   always @(posedge ip_clk)
     if (!user_w_write_32_open)
       in_r_empty_n <= 0;
     else if (hls_fifo_rd_en)
       in_r_empty_n <= 1;
     else if (in_r_read)
       in_r_empty_n <= 0;

   fifo_32x512 fifo_to_function
     (
      .rst(!user_w_write_32_open && !user_r_read_32_open),
      .rd_clk(ip_clk),
      .wr_clk(bus_clk),
      .din(user_w_write_32_data),
      .wr_en(user_w_write_32_wren),
      .rd_en(hls_fifo_rd_en),
      .dout(in_r_dout),
      .full(user_w_write_32_full),
      .empty(hls_fifo_empty)
      );

   fifo_32x512 fifo_from_function
     (
      .rst(!user_w_write_32_open && !user_r_read_32_open),
      .wr_clk(ip_clk),
      .rd_clk(bus_clk),
      .din(out_r_din),
      .wr_en(out_r_write),
      .rd_en(user_r_read_32_rden),
      .dout(user_r_read_32_data),
      .full(out_r_full),
      .empty(user_r_read_32_empty)
      );

   // A simple inferred RAM
   always @(posedge bus_clk)
   begin
       if (user_w_mem_8_wren)
            memarray[user_mem_8_addr] <= user_w_mem_8_data;
    
       if (user_r_mem_8_rden)
            user_r_mem_8_data <= memarray[user_mem_8_addr];
   end
   assign  user_r_mem_8_empty = 0;
   assign  user_r_mem_8_eof = 0;
   assign  user_w_mem_8_full = 0;

   fifo_8x2048 fifo_8
     (
      .clk(bus_clk),
      .srst(!user_r_read_8_open),
      .din(user_w_write_8_data),
      .wr_en(user_w_write_8_wren),
      .rd_en(user_r_read_8_rden),
      .dout(user_r_read_8_data),
      .full(user_w_write_8_full),
      .empty(user_r_read_8_empty)
      );
   assign  user_r_read_8_eof = 0;

   xillybus xillybus_ins
     (
      .user_r_mem_8_rden(user_r_mem_8_rden),
      .user_r_mem_8_empty(user_r_mem_8_empty),
      .user_r_mem_8_data(user_r_mem_8_data),
      .user_r_mem_8_eof(user_r_mem_8_eof),
      .user_r_mem_8_open(user_r_mem_8_open),
      .user_w_mem_8_wren(user_w_mem_8_wren),
      .user_w_mem_8_full(user_w_mem_8_full),
      .user_w_mem_8_data(user_w_mem_8_data),
      .user_w_mem_8_open(user_w_mem_8_open),
      .user_mem_8_addr(user_mem_8_addr),
      .user_mem_8_addr_update(user_mem_8_addr_update),
      .user_r_read_32_rden(user_r_read_32_rden),
      .user_r_read_32_empty(user_r_read_32_empty),
      .user_r_read_32_data(user_r_read_32_data),
      .user_r_read_32_eof(user_r_read_32_eof),
      .user_r_read_32_open(user_r_read_32_open),
      .user_w_write_32_wren(user_w_write_32_wren),
      .user_w_write_32_full(user_w_write_32_full),
      .user_w_write_32_data(user_w_write_32_data),
      .user_w_write_32_open(user_w_write_32_open),
      .user_r_read_8_rden(user_r_read_8_rden),
      .user_r_read_8_empty(user_r_read_8_empty),
      .user_r_read_8_data(user_r_read_8_data),
      .user_r_read_8_eof(user_r_read_8_eof),
      .user_r_read_8_open(user_r_read_8_open),
      .user_w_write_8_wren(user_w_write_8_wren),
      .user_w_write_8_full(user_w_write_8_full),
      .user_w_write_8_data(user_w_write_8_data),
      .user_w_write_8_open(user_w_write_8_open),
      .PCIE_PERST_B_LS(PCIE_PERST_B_LS),
      .PCIE_REFCLK_N(PCIE_REFCLK_N),
      .PCIE_REFCLK_P(PCIE_REFCLK_P),
      .PCIE_RX_N(PCIE_RX_N),
      .PCIE_RX_P(PCIE_RX_P),
      .GPIO_LED(GPIO_LED),
      .PCIE_TX_N(PCIE_TX_N),
      .PCIE_TX_P(PCIE_TX_P),
      .bus_clk(bus_clk),
      .quiesce(quiesce)
      );

endmodule
