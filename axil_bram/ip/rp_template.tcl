set cur_dir [pwd]
set bd_dir $cur_dir/fpga.srcs/sources_1/bd/system

create_bd_design system

#instantiate ps
startgroup
    create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_0
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {0}] [get_bd_cells processing_system7_0]
    set_property -dict [list CONFIG.PCW_IMPORT_BOARD_PRESET ../ip/red_pitaya.xml] [get_bd_cells processing_system7_0]
endgroup

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]



#create adc clock (for the redpitaya with clock driven by fpga pins)
#startgroup
#	set_property -dict [list CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {125} CONFIG.PCW_EN_CLK1_PORT {1}] [get_bd_cells processing_system7_0]
#	make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_CLK1]
#endgroup
#set_property name adc_clk_out [get_bd_ports FCLK_CLK1_0]

#axi clock
create_bd_port -dir O -type clk axi_clock
startgroup
connect_bd_net [get_bd_ports axi_clock] [get_bd_pins processing_system7_0/FCLK_CLK0]
endgroup

#create adc clock (for the redpitaya with clock driven by fpga pins)
startgroup
	set_property -dict [list CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {125} CONFIG.PCW_EN_CLK1_PORT {1}] [get_bd_cells processing_system7_0]
	make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_CLK1]
endgroup
set_property name adc_clk_out [get_bd_ports FCLK_CLK1_0]



startgroup
    create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 intercon0 
    set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {2}] [get_bd_cells intercon0]
endgroup

#connect ps clock to interconnect
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (125 MHz)" }  [get_bd_pins intercon0/ACLK]

#connect ps as master of the interconnect
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins intercon0/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (125 MHz)" }  [get_bd_pins intercon0/S00_ACLK]

startgroup
    make_bd_intf_pins_external -name "M00_AXI" [get_bd_intf_pins intercon0/M00_AXI]
    set_property CONFIG.PROTOCOL AXI4LITE [get_bd_intf_ports /M00_AXI]
    #reg
    assign_bd_address [get_bd_addr_segs {M00_AXI/Reg }]
    set_property range 8K [get_bd_addr_segs {processing_system7_0/Data/SEG_M00_AXI_Reg}];
    set_property offset 0x41c00000 [get_bd_addr_segs {processing_system7_0/Data/SEG_M00_AXI_Reg}] ;
    
    apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (125 MHz)" }  [get_bd_pins intercon0/M00_ACLK]

    make_bd_intf_pins_external -name "M01_AXI" [get_bd_intf_pins intercon0/M01_AXI]
    set_property CONFIG.PROTOCOL AXI4LITE [get_bd_intf_ports /M01_AXI]
    #bram
    assign_bd_address [get_bd_addr_segs {M01_AXI/Reg }]
    set_property range 8K [get_bd_addr_segs {processing_system7_0/Data/SEG_M01_AXI_Reg}];
    set_property offset 0x41100000 [get_bd_addr_segs {processing_system7_0/Data/SEG_M01_AXI_Reg}] ;
    
    apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (125 MHz)" }  [get_bd_pins intercon0/M01_ACLK]

endgroup

set_property CONFIG.ASSOCIATED_BUSIF {M00_AXI:M01_AXI} [get_bd_ports /axi_clock]




 

##create hdl wrapper
make_wrapper -files [get_files $bd_dir/system.bd] -top
import_files -force -norecurse $bd_dir/hdl/system_wrapper.v
