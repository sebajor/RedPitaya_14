{% extends "templates/rp_base.tcl" %}

{% block axilite_block %}

{% if axilite.nslaves>0 %}

startgroup
    create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 {{axilite.incon_name}} 
    set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI { {{- axilite.nslaves -}} }] [get_bd_cells {{axilite.incon_name}}]
endgroup

#connect ps clock to interconnect
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (125 MHz)" }  [get_bd_pins {{axilite.incon_name}}/ACLK]

#connect ps as master of the interconnect
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins {{axilite.incon_name}}/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (125 MHz)" }  [get_bd_pins {{axilite.incon_name}}/S00_ACLK]

startgroup
{% for axi_port in axilite.axi_ports %}
    make_bd_intf_pins_external -name "{{axi_port.port}}" [get_bd_intf_pins {{axilite.incon_name}}/{{axi_port.port}}]
    set_property CONFIG.PROTOCOL AXI4LITE [get_bd_intf_ports /{{axi_port.port}}]
    
    assign_bd_address [get_bd_addr_segs { {{- axi_port.port -}}/Reg }]
    set_property range {{axi_port.size}} [get_bd_addr_segs {processing_system7_0/Data/SEG_{{axi_port.port}}_Reg}];
    set_property offset {{axi_port.offset}} [get_bd_addr_segs {processing_system7_0/Data/SEG_{{axi_port.port}}_Reg}] ;
    
    apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (125 MHz)" }  [get_bd_pins {{axilite.incon_name}}/{{axi_port.mclk}}]

{% endfor %}
endgroup

set_property CONFIG.ASSOCIATED_BUSIF { {{- axilite.clk_group -}} } [get_bd_ports /axi_clock]
{% endif %}

{% if axilite.n_hp_ports>0 %}
startgroup
{% for hp_port in axilite.hp_ports %}
    
    ##Dont need to set the clock domain??
    
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP{{loop.index-1}} {1} CONFIG.PCW_S_AXI_HP0_DATA_WIDTH { {{- axilite.hp_size -}} }] [get_bd_cells processing_system7_0]
    make_bd_intf_pins_external  [get_bd_intf_pins processing_system7_0/S_AXI_HP{{loop.index-1}}]
    make_bd_pins_external  [get_bd_pins processing_system7_0/S_AXI_HP{{loop.index-1}}_ACLK]
    
    #assign address to the port !
    assign_bd_address [get_bd_addr_segs S_AXI_HP0_{{loop.index}}]
    #set offset
    set_property offset {{hp_port.offset}} [get_bd_addr_segs {S_AXI_HP0_0/SEG_processing_system7_0_HP{{loop.index-1}}_DDR_LOWOCM}]
    #set size
    set_property range {{hp_port.size}} [get_bd_addr_segs {S_AXI_HP0_0/SEG_processing_system7_0_HP{{loop.index-1}}_DDR_LOWOCM}]
{% endfor %}
endgroup

{% endif %}


{% if axilite.ipi_dma_num>0 %}
startgroup

    #put the dma in the diagram
    create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0

    ##connect the axi clock to the dma and the reset
    connect_bd_net [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
    connect_bd_net [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins rst_ps7_0_125M/peripheral_aresetn]

    #create the adc clock just if we want to interface it
    create_bd_port -dir I -type clk adc_clock
    set_property CONFIG.FREQ_HZ 125000000 [get_bd_ports adc_clock]

    {% if axilite.ipi_dma_write>0 %}
    #configure hp0 port
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64}] [get_bd_cells processing_system7_0]
    #configure the DMA IP
    set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_length_width {26} CONFIG.c_sg_include_stscntrl_strm {0} CONFIG.c_include_mm2s {0} CONFIG.c_m_axi_mm2s_data_width {64} CONFIG.c_mm2s_burst_size {8} CONFIG.c_include_s2mm {1} CONFIG.c_m_axi_s2mm_data_width {64}] [get_bd_cells axi_dma_0]
    #connect the axilite interface
    apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (125 MHz)} Clk_slave {/processing_system7_0/FCLK_CLK0 (125 MHz)} Clk_xbar {/processing_system7_0/FCLK_CLK0 (125 MHz)} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_dma_0/S_AXI_LITE} intc_ip {/{{axilite.incon_name -}} } master_apm {0}}  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]         
    #connect the axi full 
    apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/axi_dma_0/M_AXI_S2MM} Slave {/processing_system7_0/S_AXI_HP0} intc_ip {Auto} master_apm {0}}  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
    #make external the DMA input
    make_bd_intf_pins_external  [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]
    #set the clock of the interface
    set_property CONFIG.ASSOCIATED_BUSIF {M00_AXI:S_AXIS_S2MM_0} [get_bd_ports /{{axilite.dma_write_clk}}]
    {% endif %}
    {% if axilite.ipi_dma_read>0 %}
    set_property -dict [list CONFIG.PCW_USE_S_AXI_HP2 {1} CONFIG.PCW_S_AXI_HP2_DATA_WIDTH {64}] [get_bd_cells processing_system7_0]
    set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0} CONFIG.c_m_axi_mm2s_data_width {64} CONFIG.c_m_axis_mm2s_tdata_width {32} CONFIG.c_mm2s_burst_size {8} CONFIG.c_include_s2mm {0}] [get_bd_cells axi_dma_0]
    {% endif %}

endgroup
{% endif %}


{% endblock %}
