module fpga 
(  
    //typical zynq signals 
    inout wire [14:0]DDR_addr,
    inout wire[2:0]DDR_ba,
    inout wire DDR_cas_n,
    inout wire DDR_ck_n,
    inout wire DDR_ck_p,
    inout wire DDR_cke,
    inout wire DDR_cs_n,
    inout wire [3:0]DDR_dm,
    inout wire [31:0]DDR_dq,
    inout wire [3:0]DDR_dqs_n,
    inout wire [3:0]DDR_dqs_p,
    inout wire DDR_odt,
    inout wire DDR_ras_n,
    inout wire DDR_reset_n,
    inout wire DDR_we_n,
    inout wire FIXED_IO_ddr_vrn,
    inout wire FIXED_IO_ddr_vrp,
    inout wire [53:0]FIXED_IO_mio,
    inout wire FIXED_IO_ps_clk,
    inout wire FIXED_IO_ps_porb,
    inout wire FIXED_IO_ps_srstb,
    
    //red pitaya typical signals        
    //out adc clock
    output wire adc_enc_p_o,
    output wire adc_enc_n_o,
    
    //input adc clock
    input wire adc_clk_p_i,
    input wire adc_clk_n_i,

    //adc data
    input wire [13:0] adc_dat_a_i,
    input wire [13:0] adc_dat_b_i,
    
    output wire adc_csn_o, 
    //sata signals
    input wire [1:0] daisy_p_i,
    input wire [1:0] daisy_n_i,
    output wire [1:0] daisy_p_o,
    output wire [1:0] daisy_n_o
    //leds
    //output wire [7:0] led_o

);

{% if axilite.nslaves>0 %}
//axilite signals
{% for axi_port in axilite.axi_ports %}
wire [31:0] {{axi_port.port}}_araddr;
wire [2:0] {{axi_port.port}}_arprot;
wire [0:0] {{axi_port.port}}_arready;
wire [0:0] {{axi_port.port}}_arvalid;
wire [31:0] {{axi_port.port}}_awaddr;
wire [2:0] {{axi_port.port}}_awprot;
wire [0:0] {{axi_port.port}}_awready;
wire [0:0] {{axi_port.port}}_awvalid;
wire [0:0] {{axi_port.port}}_bready;
wire [1:0] {{axi_port.port}}_bresp;
wire [0:0] {{axi_port.port}}_bvalid;
wire [31:0] {{axi_port.port}}_rdata;
wire [0:0] {{axi_port.port}}_rready;
wire [1:0] {{axi_port.port}}_rresp;
wire [0:0] {{axi_port.port}}_rvalid;
wire [31:0] {{axi_port.port}}_wdata;
wire [0:0] {{axi_port.port}}_wready;
wire [3:0] {{axi_port.port}}_wstrb;
wire [0:0] {{axi_port.port}}_wvalid;

{% endfor %}
{% endif %}


{% if axilite.n_hp_ports>0 %}
//HP ports
{% for hp_port in axilite.hp_ports %}

wire [31:0]S_AXI_HP{{loop.index-1}}_0_araddr;
wire [1:0]S_AXI_HP{{loop.index-1}}_0_arburst;
wire [3:0]S_AXI_HP{{loop.index-1}}_0_arcache;
wire [5:0]S_AXI_HP{{loop.index-1}}_0_arid;
wire [3:0]S_AXI_HP{{loop.index-1}}_0_arlen;
wire [1:0]S_AXI_HP{{loop.index-1}}_0_arlock;
wire [2:0]S_AXI_HP{{loop.index-1}}_0_arprot;
wire [3:0]S_AXI_HP{{loop.index-1}}_0_arqos;
wire S_AXI_HP{{loop.index-1}}_0_arready;
wire [2:0]S_AXI_HP{{loop.index-1}}_0_arsize;
wire S_AXI_HP{{loop.index-1}}_0_arvalid;
wire [31:0]S_AXI_HP{{loop.index-1}}_0_awaddr;
wire [1:0]S_AXI_HP{{loop.index-1}}_0_awburst;
wire [3:0]S_AXI_HP{{loop.index-1}}_0_awcache;
wire [5:0]S_AXI_HP{{loop.index-1}}_0_awid;
wire [3:0]S_AXI_HP{{loop.index-1}}_0_awlen;
wire [1:0]S_AXI_HP{{loop.index-1}}_0_awlock;
wire [2:0]S_AXI_HP{{loop.index-1}}_0_awprot;
wire [3:0]S_AXI_HP{{loop.index-1}}_0_awqos;
wire S_AXI_HP{{loop.index-1}}_0_awready;
wire [2:0]S_AXI_HP{{loop.index-1}}_0_awsize;
wire S_AXI_HP{{loop.index-1}}_0_awvalid;
wire [5:0]S_AXI_HP{{loop.index-1}}_0_bid;
wire S_AXI_HP{{loop.index-1}}_0_bready;
wire [1:0]S_AXI_HP{{loop.index-1}}_0_bresp;
wire S_AXI_HP{{loop.index-1}}_0_bvalid;
wire [ {{axilite.hp_size-1}} :0]S_AXI_HP{{loop.index-1}}_0_rdata;
wire [5:0]S_AXI_HP{{loop.index-1}}_0_rid;
wire S_AXI_HP{{loop.index-1}}_0_rlast;
wire S_AXI_HP{{loop.index-1}}_0_rready;
wire [1:0]S_AXI_HP{{loop.index-1}}_0_rresp;
wire S_AXI_HP{{loop.index-1}}_0_rvalid;
wire [ {{axilite.hp_size-1}} :0]S_AXI_HP{{loop.index-1}}_0_wdata;
wire [5:0]S_AXI_HP{{loop.index-1}}_0_wid;
wire S_AXI_HP{{loop.index-1}}_0_wlast;
wire S_AXI_HP{{loop.index-1}}_0_wready;
wire [7:0]S_AXI_HP{{loop.index-1}}_0_wstrb;
wire S_AXI_HP{{loop.index-1}}_0_wvalid;
wire S_AXI_HP{{loop.index-1}}_ACLK_0;

{% endfor %}
{% endif %}



{% if axilite.ipi_dma_num >0 %}
{% if axilite.ipi_dma_write >0 %}
wire [31:0]S_AXIS_S2MM_0_tdata;
wire [3:0]S_AXIS_S2MM_0_tkeep;
wire S_AXIS_S2MM_0_tlast;
wire S_AXIS_S2MM_0_tready;
wire S_AXIS_S2MM_0_tvalid;

{% endif %}
{% endif %}



wire adc_clk_out;
wire axi_clock;

system_wrapper system_wrapper_inst(
    .DDR_addr(DDR_addr),
    .DDR_ba(DDR_ba),
    .DDR_cas_n(DDR_cas_n),
    .DDR_ck_n(DDR_ck_n),
    .DDR_ck_p(DDR_ck_p),
    .DDR_cke(DDR_cke),
    .DDR_cs_n(DDR_cs_n),
    .DDR_dm(DDR_dm),
    .DDR_dq(DDR_dq),
    .DDR_dqs_n(DDR_dqs_n),
    .DDR_dqs_p(DDR_dqs_p),
    .DDR_odt(DDR_odt),
    .DDR_ras_n(DDR_ras_n),
    .DDR_reset_n(DDR_reset_n),
    .DDR_we_n(DDR_we_n),
    .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
    .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
    .FIXED_IO_mio(FIXED_IO_mio),
    .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
    .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
    .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),    
{% if axilite.nslaves>0 %}
{% for axi_port in axilite.axi_ports %}
    .{{axi_port.port}}_araddr({{axi_port.port}}_araddr),
    .{{axi_port.port}}_arprot({{axi_port.port}}_arprot),
    .{{axi_port.port}}_arready({{axi_port.port}}_arready),
    .{{axi_port.port}}_arvalid({{axi_port.port}}_arvalid),
    .{{axi_port.port}}_awaddr({{axi_port.port}}_awaddr),
    .{{axi_port.port}}_awprot({{axi_port.port}}_awprot),
    .{{axi_port.port}}_awready({{axi_port.port}}_awready),
    .{{axi_port.port}}_awvalid({{axi_port.port}}_awvalid),
    .{{axi_port.port}}_bready({{axi_port.port}}_bready),
    .{{axi_port.port}}_bresp({{axi_port.port}}_bresp),
    .{{axi_port.port}}_bvalid({{axi_port.port}}_bvalid),
    .{{axi_port.port}}_rdata({{axi_port.port}}_rdata),
    .{{axi_port.port}}_rready({{axi_port.port}}_rready),
    .{{axi_port.port}}_rresp({{axi_port.port}}_rresp),
    .{{axi_port.port}}_rvalid({{axi_port.port}}_rvalid),
    .{{axi_port.port}}_wdata({{axi_port.port}}_wdata),
    .{{axi_port.port}}_wready({{axi_port.port}}_wready),
    .{{axi_port.port}}_wstrb({{axi_port.port}}_wstrb),
    .{{axi_port.port}}_wvalid({{axi_port.port}}_wvalid),
{% endfor %}
{% endif %}
{% if axilite.n_hp_ports>0 %}
{% for hp_port in axilite.hp_ports %}
    .S_AXI_HP{{loop.index-1}}_0_araddr(S_AXI_HP{{loop.index-1}}_0_araddr),
    .S_AXI_HP{{loop.index-1}}_0_arburst(S_AXI_HP{{loop.index-1}}_0_arburst),
    .S_AXI_HP{{loop.index-1}}_0_arcache(S_AXI_HP{{loop.index-1}}_0_arcache),
    .S_AXI_HP{{loop.index-1}}_0_arid(S_AXI_HP{{loop.index-1}}_0_arid),
    .S_AXI_HP{{loop.index-1}}_0_arlen(S_AXI_HP{{loop.index-1}}_0_arlen),
    .S_AXI_HP{{loop.index-1}}_0_arlock(S_AXI_HP{{loop.index-1}}_0_arlock),
    .S_AXI_HP{{loop.index-1}}_0_arprot(S_AXI_HP{{loop.index-1}}_0_arprot),
    .S_AXI_HP{{loop.index-1}}_0_arqos(S_AXI_HP{{loop.index-1}}_0_arqos),
    .S_AXI_HP{{loop.index-1}}_0_arready(S_AXI_HP{{loop.index-1}}_0_arready),
    .S_AXI_HP{{loop.index-1}}_0_arsize(S_AXI_HP{{loop.index-1}}_0_arsize),
    .S_AXI_HP{{loop.index-1}}_0_arvalid(S_AXI_HP{{loop.index-1}}_0_arvalid),
    .S_AXI_HP{{loop.index-1}}_0_awaddr(S_AXI_HP{{loop.index-1}}_0_awaddr),
    .S_AXI_HP{{loop.index-1}}_0_awburst(S_AXI_HP{{loop.index-1}}_0_awburst),
    .S_AXI_HP{{loop.index-1}}_0_awcache(S_AXI_HP{{loop.index-1}}_0_awcache),
    .S_AXI_HP{{loop.index-1}}_0_awid(S_AXI_HP{{loop.index-1}}_0_awid),
    .S_AXI_HP{{loop.index-1}}_0_awlen(S_AXI_HP{{loop.index-1}}_0_awlen),
    .S_AXI_HP{{loop.index-1}}_0_awlock(S_AXI_HP{{loop.index-1}}_0_awlock),
    .S_AXI_HP{{loop.index-1}}_0_awprot(S_AXI_HP{{loop.index-1}}_0_awprot),
    .S_AXI_HP{{loop.index-1}}_0_awqos(S_AXI_HP{{loop.index-1}}_0_awqos),
    .S_AXI_HP{{loop.index-1}}_0_awready(S_AXI_HP{{loop.index-1}}_0_awready),
    .S_AXI_HP{{loop.index-1}}_0_awsize(S_AXI_HP{{loop.index-1}}_0_awsize),
    .S_AXI_HP{{loop.index-1}}_0_awvalid(S_AXI_HP{{loop.index-1}}_0_awvalid),
    .S_AXI_HP{{loop.index-1}}_0_bid(S_AXI_HP{{loop.index-1}}_0_bid),
    .S_AXI_HP{{loop.index-1}}_0_bready(S_AXI_HP{{loop.index-1}}_0_bready),
    .S_AXI_HP{{loop.index-1}}_0_bresp(S_AXI_HP{{loop.index-1}}_0_bresp),
    .S_AXI_HP{{loop.index-1}}_0_bvalid(S_AXI_HP{{loop.index-1}}_0_bvalid),
    .S_AXI_HP{{loop.index-1}}_0_rdata(S_AXI_HP{{loop.index-1}}_0_rdata),
    .S_AXI_HP{{loop.index-1}}_0_rid(S_AXI_HP{{loop.index-1}}_0_rid),
    .S_AXI_HP{{loop.index-1}}_0_rlast(S_AXI_HP{{loop.index-1}}_0_rlast),
    .S_AXI_HP{{loop.index-1}}_0_rready(S_AXI_HP{{loop.index-1}}_0_rready),
    .S_AXI_HP{{loop.index-1}}_0_rresp(S_AXI_HP{{loop.index-1}}_0_rresp),
    .S_AXI_HP{{loop.index-1}}_0_rvalid(S_AXI_HP{{loop.index-1}}_0_rvalid),
    .S_AXI_HP{{loop.index-1}}_0_wdata(S_AXI_HP{{loop.index-1}}_0_wdata),
    .S_AXI_HP{{loop.index-1}}_0_wid(S_AXI_HP{{loop.index-1}}_0_wid),
    .S_AXI_HP{{loop.index-1}}_0_wlast(S_AXI_HP{{loop.index-1}}_0_wlast),
    .S_AXI_HP{{loop.index-1}}_0_wready(S_AXI_HP{{loop.index-1}}_0_wready),
    .S_AXI_HP{{loop.index-1}}_0_wstrb(S_AXI_HP{{loop.index-1}}_0_wstrb),
    .S_AXI_HP{{loop.index-1}}_0_wvalid(S_AXI_HP{{loop.index-1}}_0_wvalid),
    .S_AXI_HP{{loop.index-1}}_ACLK_0(S_AXI_HP{{loop.index-1}}_ACLK_0),
{% endfor %}
{% endif %}
{% if axilite.ipi_dma_num>0 %}
    .adc_clock(adc_clock),
{% if axilite.ipi_dma_write >0 %}
    .S_AXIS_S2MM_0_tdata(S_AXIS_S2MM_0_tdata),
    .S_AXIS_S2MM_0_tkeep(S_AXIS_S2MM_0_tkeep),
    .S_AXIS_S2MM_0_tlast(S_AXIS_S2MM_0_tlast),
    .S_AXIS_S2MM_0_tready(S_AXIS_S2MM_0_tready),
    .S_AXIS_S2MM_0_tvalid(S_AXIS_S2MM_0_tvalid),
{% endif %}
{% endif %}
    .adc_clk_out(adc_clk_out),
    .axi_clock(axi_clock)
);

//  convert the adc_clock in differential and set the oddr to the output
//  just when the clock is generated on the ps
ODDR i_adc_clk_p (.Q(adc_enc_p_o), .D1(1'b1), .D2(1'b0), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR i_adc_clk_n ( .Q(adc_enc_n_o), .D1(1'b0), .D2(1'b1), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));

//adc clock differential buffer
wire adc_clk_in_0, adc_clk_in;
IBUFGDS adc_clk_inst_in (.I(adc_clk_p_i), .IB(adc_clk_n_i), .O(adc_clk_in_0));
BUFG adc_clk_inst (.I(adc_clk_in_0), .O(adc_clk_in));

//SATA signals(), here its just a bypass;  DIFF_HSTL_I_18
wire daisy_p, daisy_n;
IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE"
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_daisy_p (
      .O(daisy_p),  // Buffer output
      .I(daisy_p_i[1]),  // Diff_p buffer input (connect directly to top-level port)
      .IB(daisy_p_i[0]) // Diff_n buffer input (connect directly to top-level port)
);
IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE"
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_daisy_n (
      .O(daisy_n),  // Buffer output
      .I(daisy_n_i[1]),  // Diff_p buffer input (connect directly to top-level port)
      .IB(daisy_n_i[0]) // Diff_n buffer input (connect directly to top-level port)
);
OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_daisy_p (
      .O(daisy_p_o[1]),     // Diff_p output (connect directly to top-level port)
      .OB(daisy_p_o[0]),   // Diff_n output (connect directly to top-level port)
      .I(daisy_p)      // Buffer input
);
OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_daisy_n (
      .O(daisy_n_o[1]),     // Diff_p output (connect directly to top-level port)
      .OB(daisy_n_o[0]),   // Diff_n output (connect directly to top-level port)
      .I(daisy_n)      // Buffer input
);


endmodule
