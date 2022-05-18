set cur_dir [pwd]
set bd_dir $cur_dir/fpga.srcs/sources_1/bd/system
exec mkdir -p $cur_dir/rev

create_bd_design system

#instantiate ps
startgroup
    create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_0
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {0}] [get_bd_cells processing_system7_0]
    set_property -dict [list CONFIG.PCW_IMPORT_BOARD_PRESET ../ip/red_pitaya.xml] [get_bd_cells processing_system7_0]
endgroup

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]



#create adc clock (for the redpitaya with clock driven by fpga pins)
startgroup
	set_property -dict [list CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {125} CONFIG.PCW_EN_CLK1_PORT {1}] [get_bd_cells processing_system7_0]
	make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_CLK1]
endgroup
set_property name adc_clk_out [get_bd_ports FCLK_CLK1_0]

#axi clock
create_bd_port -dir O -type clk axi_clock
startgroup
connect_bd_net [get_bd_ports axi_clock] [get_bd_pins processing_system7_0/FCLK_CLK0]
endgroup

{% block axilite_block %} {% endblock %}



{% block axifull_block %} {% endblock %}

##create hdl wrapper
make_wrapper -files [get_files $bd_dir/system.bd] -top
import_files -force -norecurse $bd_dir/hdl/system_wrapper.v

write_bd_tcl -force $cur_dir/rev/system.tcl

