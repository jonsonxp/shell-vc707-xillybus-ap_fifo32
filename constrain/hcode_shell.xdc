create_clock -name sys_clk -period 10 [get_pins -match_style ucf */pcieclk_ibuf/O]
# create_clock -period 6.667 -name ip_clk [get_pins -match_style ucf clk_wiz/clk_out3]
# clk_out-frequency: 1-100MHz, 2-150MHz, 3-200MHz, 4-250MHz
set_false_path -from [get_clocks userclk1] -to [get_clocks clk_out?_clk_wiz_0*]
set_false_path -from [get_clocks clk_out?_clk_wiz_0*] -to [get_clocks userclk1]


set_false_path -to [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]
set_false_path -to [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S1]
set_case_analysis 1 [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]
set_case_analysis 0 [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S1]

set_property DONT_TOUCH true [get_cells -of [get_nets -of [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]]]
set_property DONT_TOUCH true [get_cells -hier -filter {name=~*/pipe_clock/pclk_sel*}]

set_false_path -from [get_ports PCIE_PERST_B_LS]

set_property LOC IBUFDS_GTE2_X1Y5 [get_cells -match_style ucf */pcieclk_ibuf]

set_property -dict "PACKAGE_PIN AV35 IOSTANDARD LVCMOS18 PULLUP true" [get_ports PCIE_PERST_B_LS]

set_property -dict "PACKAGE_PIN AM39 IOSTANDARD LVCMOS18" [get_ports "GPIO_LED[0]"]
set_property -dict "PACKAGE_PIN AN39 IOSTANDARD LVCMOS18" [get_ports "GPIO_LED[1]"]
set_property -dict "PACKAGE_PIN AR37 IOSTANDARD LVCMOS18" [get_ports "GPIO_LED[2]"]
set_property -dict "PACKAGE_PIN AT37 IOSTANDARD LVCMOS18" [get_ports "GPIO_LED[3]"]

#set_property IOSTANDARD LVDS [get_ports sys_clk_p]
#set_property PACKAGE_PIN E19 [get_ports sys_clk_p]
#set_property PACKAGE_PIN E18 [get_ports sys_clk_n]
#set_property IOSTANDARD LVDS [get_ports sys_clk_n]
