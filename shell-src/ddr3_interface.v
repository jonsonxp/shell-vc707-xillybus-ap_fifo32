`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/09/2015 09:56:08 AM
// Design Name:
// Module Name: ddr3_interface
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


module ddr3_interface
  (
/*AUTOARG*/
   // Outputs
   ddr3_addr, ddr3_ba, ddr3_ras_n, ddr3_cas_n, ddr3_we_n,
   ddr3_reset_n, ddr3_ck_p, ddr3_ck_n, ddr3_cke, ddr3_cs_n, ddr3_dm,
   ddr3_odt, S00_AXI_ARESET_OUT_N, S00_AXI_AWREADY, S00_AXI_WREADY,
   S00_AXI_BID, S00_AXI_BRESP, S00_AXI_BVALID, S00_AXI_ARREADY,
   S00_AXI_RID, S00_AXI_RDATA, S00_AXI_RRESP, S00_AXI_RLAST,
   S00_AXI_RVALID,
   // Inouts
   ddr3_dq, ddr3_dqs_n, ddr3_dqs_p,
   // Inputs
   SYS_CLK_P, SYS_CLK_N, SYS_RST, USER_CLK, USER_RST_N, S00_AXI_ACLK,
   S00_AXI_AWID, S00_AXI_AWADDR, S00_AXI_AWLEN, S00_AXI_AWSIZE,
   S00_AXI_AWBURST, S00_AXI_AWLOCK, S00_AXI_AWCACHE, S00_AXI_AWPROT,
   S00_AXI_AWQOS, S00_AXI_AWVALID, S00_AXI_WDATA, S00_AXI_WSTRB,
   S00_AXI_WLAST, S00_AXI_WVALID, S00_AXI_BREADY, S00_AXI_ARID,
   S00_AXI_ARADDR, S00_AXI_ARLEN, S00_AXI_ARSIZE, S00_AXI_ARBURST,
   S00_AXI_ARLOCK, S00_AXI_ARCACHE, S00_AXI_ARPROT, S00_AXI_ARQOS,
   S00_AXI_ARVALID, S00_AXI_RREADY
   );

   input SYS_CLK_P;
   input SYS_CLK_N;
   input SYS_RST;
   input USER_CLK;
   input USER_RST_N;

   inout [63:0] ddr3_dq;
   inout [7:0] 	ddr3_dqs_n;
   inout [7:0] 	ddr3_dqs_p;
   output [13:0] ddr3_addr;
   output [2:0]  ddr3_ba;
   output 	 ddr3_ras_n;
   output 	 ddr3_cas_n;
   output 	 ddr3_we_n;
   output 	 ddr3_reset_n;
   output [0:0]  ddr3_ck_p;
   output [0:0]  ddr3_ck_n;
   output [0:0]  ddr3_cke;
   output [0:0]  ddr3_cs_n;
   output [7:0]  ddr3_dm;
   output [0:0]  ddr3_odt;

   output 	 S00_AXI_ARESET_OUT_N;
   input 	 S00_AXI_ACLK;
   input [0 : 0] S00_AXI_AWID;
   input [29 : 0] S00_AXI_AWADDR;
   input [7 : 0]  S00_AXI_AWLEN;
   input [2 : 0]  S00_AXI_AWSIZE;
   input [1 : 0]  S00_AXI_AWBURST;
   input 	  S00_AXI_AWLOCK;
   input [3 : 0]  S00_AXI_AWCACHE;
   input [2 : 0]  S00_AXI_AWPROT;
   input [3 : 0]  S00_AXI_AWQOS;
   input 	  S00_AXI_AWVALID;
   output 	  S00_AXI_AWREADY;
   input [31 : 0] S00_AXI_WDATA;
   input [3 : 0]  S00_AXI_WSTRB;
   input 	  S00_AXI_WLAST;
   input 	  S00_AXI_WVALID;
   output 	  S00_AXI_WREADY;
   output [0 : 0] S00_AXI_BID;
   output [1 : 0] S00_AXI_BRESP;
   output 	  S00_AXI_BVALID;
   input 	  S00_AXI_BREADY;
   input [0 : 0]  S00_AXI_ARID;
   input [29 : 0] S00_AXI_ARADDR;
   input [7 : 0]  S00_AXI_ARLEN;
   input [2 : 0]  S00_AXI_ARSIZE;
   input [1 : 0]  S00_AXI_ARBURST;
   input 	  S00_AXI_ARLOCK;
   input [3 : 0]  S00_AXI_ARCACHE;
   input [2 : 0]  S00_AXI_ARPROT;
   input [3 : 0]  S00_AXI_ARQOS;
   input 	  S00_AXI_ARVALID;
   output 	  S00_AXI_ARREADY;
   output [0 : 0] S00_AXI_RID;

   output [31 : 0] S00_AXI_RDATA;
   output [1 : 0]  S00_AXI_RRESP;
   output 	   S00_AXI_RLAST;
   output 	   S00_AXI_RVALID;
   input 	   S00_AXI_RREADY;

   wire 	   m_axi_reset_n;
   wire [3:0] 	   m_axi_awid;
   wire [29:0] 	   m_axi_awaddr;
   wire [7:0] 	   m_axi_awlen;
   wire [2:0] 	   m_axi_awsize;
   wire [1:0] 	   m_axi_awburst;
   wire [0:0] 	   m_axi_awlock;
   wire [3:0] 	   m_axi_awcache;
   wire [2:0] 	   m_axi_awprot;
   wire 	   m_axi_awvalid;
   wire 	   m_axi_awready;
   wire [511:0]    m_axi_wdata;
   wire [63:0] 	   m_axi_wstrb;
   wire 	   m_axi_wlast;
   wire 	   m_axi_wvalid;
   wire 	   m_axi_wready;
   wire 	   m_axi_bready;
   wire [3:0] 	   m_axi_bid;
   wire [1:0] 	   m_axi_bresp;
   wire 	   m_axi_bvalid;
   wire [3:0] 	   m_axi_arid;
   wire [29:0] 	   m_axi_araddr;
   wire [7:0] 	   m_axi_arlen;
   wire [2:0] 	   m_axi_arsize;
   wire [1:0] 	   m_axi_arburst;
   wire [0:0] 	   m_axi_arlock;
   wire [3:0] 	   m_axi_arcache;
   wire [2:0] 	   m_axi_arprot;
   wire 	   m_axi_arvalid;
   wire 	   m_axi_arready;
   wire 	   m_axi_rready;
   wire [3:0] 	   m_axi_rid;
   wire [511:0]    m_axi_rdata;
   wire [1:0] 	   m_axi_rresp;
   wire 	   m_axi_rlast;
   wire 	   m_axi_rvalid;

   wire 	   cmp_data_valid;
   wire [511:0]    cmp_data;     // Compare data
   wire [511:0]    rdata_cmp;      // Read data
   wire 	   dbg_wr_sts_vld;
   wire [39:0] 	   dbg_wr_sts;
   wire 	   dbg_rd_sts_vld;
   wire [39:0] 	   dbg_rd_sts;
   wire 	   mig_ui_clk;
   wire 	   mig_ui_rst;

   wire 	   mmcm_locked;
   reg 		   aresetn;
   wire 	   app_sr_active;
   wire 	   app_ref_ack;
   wire 	   app_zq_ack;
   wire 	   app_rd_data_valid;
   wire [511:0]    app_rd_data;

   axi_interconnect_0 axi_interconnect
     (
      .INTERCONNECT_ACLK(USER_CLK),
      .INTERCONNECT_ARESETN(USER_RST_N),
      
      .S00_AXI_ARESET_OUT_N(s_axi_reset_n),
      .S00_AXI_ACLK(USER_CLK),
      .S00_AXI_AWID(S00_AXI_AWID),
      .S00_AXI_AWADDR(S00_AXI_AWADDR),
      .S00_AXI_AWLEN(S00_AXI_AWLEN),
      .S00_AXI_AWSIZE(S00_AXI_AWSIZE),
      .S00_AXI_AWBURST(S00_AXI_AWBURST),
      .S00_AXI_AWLOCK(S00_AXI_AWLOCK),
      .S00_AXI_AWCACHE(S00_AXI_AWCACHE),
      .S00_AXI_AWPROT(S00_AXI_AWPROT),
      .S00_AXI_AWQOS(S00_AXI_AWQOS),
      .S00_AXI_AWVALID(S00_AXI_AWVALID),
      .S00_AXI_AWREADY(S00_AXI_AWREADY),
      .S00_AXI_WDATA(S00_AXI_WDATA),
      .S00_AXI_WSTRB(S00_AXI_WSTRB),
      .S00_AXI_WLAST(S00_AXI_WLAST),
      .S00_AXI_WVALID(S00_AXI_WVALID),
      .S00_AXI_WREADY(S00_AXI_WREADY),
      .S00_AXI_BID(S00_AXI_BID),
      .S00_AXI_BRESP(S00_AXI_BRESP),
      .S00_AXI_BVALID(S00_AXI_BVALID),
      .S00_AXI_BREADY(S00_AXI_BREADY),
      .S00_AXI_ARID(S00_AXI_ARID),
      .S00_AXI_ARADDR(S00_AXI_ARADDR),
      .S00_AXI_ARLEN(S00_AXI_ARLEN),
      .S00_AXI_ARSIZE(S00_AXI_ARSIZE),
      .S00_AXI_ARBURST(S00_AXI_ARBURST),
      .S00_AXI_ARLOCK(S00_AXI_ARLOCK),
      .S00_AXI_ARCACHE(S00_AXI_ARCACHE),
      .S00_AXI_ARPROT(S00_AXI_ARPROT),
      .S00_AXI_ARQOS(S00_AXI_ARQOS),
      .S00_AXI_ARVALID(S00_AXI_ARVALID),
      .S00_AXI_ARREADY(S00_AXI_ARREADY),
      .S00_AXI_RID(S00_AXI_RID),
      .S00_AXI_RDATA(S00_AXI_RDATA),
      .S00_AXI_RRESP(S00_AXI_RRESP),
      .S00_AXI_RLAST(S00_AXI_RLAST),
      .S00_AXI_RVALID(S00_AXI_RVALID),
      .S00_AXI_RREADY(S00_AXI_RREADY),

      .M00_AXI_ARESET_OUT_N(m_axi_reset_n),
      .M00_AXI_ACLK(mig_ui_clk),
      .M00_AXI_AWID(m_axi_awid),
      .M00_AXI_AWADDR(m_axi_awaddr),
      .M00_AXI_AWLEN(m_axi_awlen),
      .M00_AXI_AWSIZE(m_axi_awsize),
      .M00_AXI_AWBURST(m_axi_awburst),
      .M00_AXI_AWLOCK(m_axi_awlock),
      .M00_AXI_AWCACHE(m_axi_awcache),
      .M00_AXI_AWPROT(m_axi_awprot),
      .M00_AXI_AWQOS(4'h0),
      .M00_AXI_AWVALID(m_axi_awvalid),
      .M00_AXI_AWREADY(m_axi_awready),
      .M00_AXI_WDATA(m_axi_wdata),
      .M00_AXI_WSTRB(m_axi_wstrb),
      .M00_AXI_WLAST(m_axi_wlast),
      .M00_AXI_WVALID(m_axi_wvalid),
      .M00_AXI_WREADY(m_axi_wready),
      .M00_AXI_BID(m_axi_bid),
      .M00_AXI_BRESP(m_axi_bresp),
      .M00_AXI_BVALID(m_axi_bvalid),
      .M00_AXI_BREADY(m_axi_bready),
      .M00_AXI_ARID(m_axi_arid),
      .M00_AXI_ARADDR(m_axi_araddr),
      .M00_AXI_ARLEN(m_axi_arlen),
      .M00_AXI_ARSIZE(m_axi_arsize),
      .M00_AXI_ARBURST(m_axi_arburst),
      .M00_AXI_ARLOCK(m_axi_arlock),
      .M00_AXI_ARCACHE(m_axi_arcache),
      .M00_AXI_ARPROT(m_axi_arprot),
      .M00_AXI_ARQOS(4'h0),
      .M00_AXI_ARVALID(m_axi_arvalid),
      .M00_AXI_ARREADY(m_axi_arready),
      .M00_AXI_RID(m_axi_rid),
      .M00_AXI_RDATA(m_axi_rdata),
      .M00_AXI_RRESP(m_axi_rresp),
      .M00_AXI_RLAST(m_axi_rlast),
      .M00_AXI_RVALID(m_axi_rvalid),
      .M00_AXI_RREADY(m_axi_rready)
      );

   mig_7series_0 u_mig_7series_0
     (
      // Memory interface ports
      .ddr3_addr                      (ddr3_addr),
      .ddr3_ba                        (ddr3_ba),
      .ddr3_cas_n                     (ddr3_cas_n),
      .ddr3_ck_n                      (ddr3_ck_n),
      .ddr3_ck_p                      (ddr3_ck_p),
      .ddr3_cke                       (ddr3_cke),
      .ddr3_ras_n                     (ddr3_ras_n),
      .ddr3_reset_n                   (ddr3_reset_n),
      .ddr3_we_n                      (ddr3_we_n),
      .ddr3_dq                        (ddr3_dq),
      .ddr3_dqs_n                     (ddr3_dqs_n),
      .ddr3_dqs_p                     (ddr3_dqs_p),
      .init_calib_complete            (init_calib_complete),
      .ddr3_cs_n                      (ddr3_cs_n),
      .ddr3_dm                        (ddr3_dm),
      .ddr3_odt                       (ddr3_odt),
      // Application interface ports
      .ui_clk                         (mig_ui_clk),
      .ui_clk_sync_rst                (mig_ui_rst),
      .mmcm_locked                    (mmcm_locked),
      .aresetn                        (aresetn),
      .app_sr_req                     (1'b0),
      .app_ref_req                    (1'b0),
      .app_zq_req                     (1'b0),
      .app_sr_active                  (app_sr_active),
      .app_ref_ack                    (app_ref_ack),
      .app_zq_ack                     (app_zq_ack),
      // Slave Interface Write Address Ports
      .s_axi_awid                     (m_axi_awid),
      .s_axi_awaddr                   (m_axi_awaddr),
      .s_axi_awlen                    (m_axi_awlen),
      .s_axi_awsize                   (m_axi_awsize),
      .s_axi_awburst                  (m_axi_awburst),
      .s_axi_awlock                   (m_axi_awlock),
      .s_axi_awcache                  (m_axi_awcache),
      .s_axi_awprot                   (m_axi_awprot),
      .s_axi_awqos                    (4'h0),
      .s_axi_awvalid                  (m_axi_awvalid),
      .s_axi_awready                  (m_axi_awready),
      // Slave Interface Write Data Ports
      .s_axi_wdata                    (m_axi_wdata),
      .s_axi_wstrb                    (m_axi_wstrb),
      .s_axi_wlast                    (m_axi_wlast),
      .s_axi_wvalid                   (m_axi_wvalid),
      .s_axi_wready                   (m_axi_wready),
      // Slave Interface Write Response Ports
      .s_axi_bid                      (m_axi_bid),
      .s_axi_bresp                    (m_axi_bresp),
      .s_axi_bvalid                   (m_axi_bvalid),
      .s_axi_bready                   (m_axi_bready),
      // Slave Interface Read Address Ports
      .s_axi_arid                     (m_axi_arid),
      .s_axi_araddr                   (m_axi_araddr),
      .s_axi_arlen                    (m_axi_arlen),
      .s_axi_arsize                   (m_axi_arsize),
      .s_axi_arburst                  (m_axi_arburst),
      .s_axi_arlock                   (m_axi_arlock),
      .s_axi_arcache                  (m_axi_arcache),
      .s_axi_arprot                   (m_axi_arprot),
      .s_axi_arqos                    (4'h0),
      .s_axi_arvalid                  (m_axi_arvalid),
      .s_axi_arready                  (m_axi_arready),
      // Slave Interface Read Data Ports
      .s_axi_rid                      (m_axi_rid),
      .s_axi_rdata                    (m_axi_rdata),
      .s_axi_rresp                    (m_axi_rresp),
      .s_axi_rlast                    (m_axi_rlast),
      .s_axi_rvalid                   (m_axi_rvalid),
      .s_axi_rready                   (m_axi_rready),
      // System Clock Ports
      .sys_clk_p                       (SYS_CLK_P),
      .sys_clk_n                       (SYS_CLK_N),
      .sys_rst                        (SYS_RST)
      );

   always @(posedge mig_ui_clk) begin
      aresetn <= m_axi_reset_n;
   end

   //*****************************************************************
   // Default values are assigned to the debug inputs
   //*****************************************************************
   assign dbg_sel_pi_incdec       = 'b0;
   assign dbg_sel_po_incdec       = 'b0;
   assign dbg_pi_f_inc            = 'b0;
   assign dbg_pi_f_dec            = 'b0;
   assign dbg_po_f_inc            = 'b0;
   assign dbg_po_f_dec            = 'b0;
   assign dbg_po_f_stg23_sel      = 'b0;
   assign po_win_tg_rst           = 'b0;
   assign vio_tg_rst              = 'b0;
endmodule
