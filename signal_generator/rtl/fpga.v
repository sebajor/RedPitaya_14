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
    output wire [1:0] daisy_n_o,
    //leds
    output wire [7:0] led_o,
    output wire [13:0] dac_dat_o,
    output wire dac_rst_o, dac_sel_o, dac_wrt_o,
    output wire dac_clk_o
);

//axilite signals

wire [31:0] M00_AXI_araddr;
wire [2:0] M00_AXI_arprot;
wire [0:0] M00_AXI_arready;
wire [0:0] M00_AXI_arvalid;
wire [31:0] M00_AXI_awaddr;
wire [2:0] M00_AXI_awprot;
wire [0:0] M00_AXI_awready;
wire [0:0] M00_AXI_awvalid;
wire [0:0] M00_AXI_bready;
wire [1:0] M00_AXI_bresp;
wire [0:0] M00_AXI_bvalid;
wire [31:0] M00_AXI_rdata;
wire [0:0] M00_AXI_rready;
wire [1:0] M00_AXI_rresp;
wire [0:0] M00_AXI_rvalid;
wire [31:0] M00_AXI_wdata;
wire [0:0] M00_AXI_wready;
wire [3:0] M00_AXI_wstrb;
wire [0:0] M00_AXI_wvalid;

wire [31:0] M01_AXI_araddr;
wire [2:0] M01_AXI_arprot;
wire [0:0] M01_AXI_arready;
wire [0:0] M01_AXI_arvalid;
wire [31:0] M01_AXI_awaddr;
wire [2:0] M01_AXI_awprot;
wire [0:0] M01_AXI_awready;
wire [0:0] M01_AXI_awvalid;
wire [0:0] M01_AXI_bready;
wire [1:0] M01_AXI_bresp;
wire [0:0] M01_AXI_bvalid;
wire [31:0] M01_AXI_rdata;
wire [0:0] M01_AXI_rready;
wire [1:0] M01_AXI_rresp;
wire [0:0] M01_AXI_rvalid;
wire [31:0] M01_AXI_wdata;
wire [0:0] M01_AXI_wready;
wire [3:0] M01_AXI_wstrb;
wire [0:0] M01_AXI_wvalid;


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
    .M00_AXI_araddr(M00_AXI_araddr),
    .M00_AXI_arprot(M00_AXI_arprot),
    .M00_AXI_arready(M00_AXI_arready),
    .M00_AXI_arvalid(M00_AXI_arvalid),
    .M00_AXI_awaddr(M00_AXI_awaddr),
    .M00_AXI_awprot(M00_AXI_awprot),
    .M00_AXI_awready(M00_AXI_awready),
    .M00_AXI_awvalid(M00_AXI_awvalid),
    .M00_AXI_bready(M00_AXI_bready),
    .M00_AXI_bresp(M00_AXI_bresp),
    .M00_AXI_bvalid(M00_AXI_bvalid),
    .M00_AXI_rdata(M00_AXI_rdata),
    .M00_AXI_rready(M00_AXI_rready),
    .M00_AXI_rresp(M00_AXI_rresp),
    .M00_AXI_rvalid(M00_AXI_rvalid),
    .M00_AXI_wdata(M00_AXI_wdata),
    .M00_AXI_wready(M00_AXI_wready),
    .M00_AXI_wstrb(M00_AXI_wstrb),
    .M00_AXI_wvalid(M00_AXI_wvalid),
    .M01_AXI_araddr(M01_AXI_araddr),
    .M01_AXI_arprot(M01_AXI_arprot),
    .M01_AXI_arready(M01_AXI_arready),
    .M01_AXI_arvalid(M01_AXI_arvalid),
    .M01_AXI_awaddr(M01_AXI_awaddr),
    .M01_AXI_awprot(M01_AXI_awprot),
    .M01_AXI_awready(M01_AXI_awready),
    .M01_AXI_awvalid(M01_AXI_awvalid),
    .M01_AXI_bready(M01_AXI_bready),
    .M01_AXI_bresp(M01_AXI_bresp),
    .M01_AXI_bvalid(M01_AXI_bvalid),
    .M01_AXI_rdata(M01_AXI_rdata),
    .M01_AXI_rready(M01_AXI_rready),
    .M01_AXI_rresp(M01_AXI_rresp),
    .M01_AXI_rvalid(M01_AXI_rvalid),
    .M01_AXI_wdata(M01_AXI_wdata),
    .M01_AXI_wready(M01_AXI_wready),
    .M01_AXI_wstrb(M01_AXI_wstrb),
    .M01_AXI_wvalid(M01_AXI_wvalid),
    .adc_clk_out(adc_clk_out),
    .axi_clock(axi_clock)
);

//  convert the adc_clock in differential and set the oddr to the output
//  just when the clock is generated on the ps
ODDR i_adc_clk_p (.Q(adc_enc_p_o), .D1(1'b1), .D2(1'b0), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR i_adc_clk_n ( .Q(adc_enc_n_o), .D1(1'b0), .D2(1'b1), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));

//adc clock differential buffer
wire adc_clk_in;
IBUFGDS adc_clk_inst (.I(adc_clk_p_i), .IB(adc_clk_n_i), .O(adc_clk_in));

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


//axi lite reg
//this one configure the read of the bram
wire [31:0] dec_rate, dac_default;
wire continous, rst_read, en_read;
s_axil_reg #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(3)
) s_axil_reg_inst (
    .axi_clock(axi_clock), 
    .rst(1'b0), 
    .s_axil_awaddr(M00_AXI_awaddr),
    .s_axil_awprot(M00_AXI_awprot),
    .s_axil_awvalid(M00_AXI_awvalid),
    .s_axil_awready(M00_AXI_awready),
    .s_axil_wdata(M00_AXI_wdata),
    .s_axil_wstrb(M00_AXI_wstrb),
    .s_axil_wvalid(M00_AXI_wvalid),
    .s_axil_wready(M00_AXI_wready),
    .s_axil_bresp(M00_AXI_bresp),
    .s_axil_bvalid(M00_AXI_bvalid),
    .s_axil_bready(M00_AXI_bready),
    .s_axil_araddr(M00_AXI_araddr),
    .s_axil_arvalid(M00_AXI_arvalid),
    .s_axil_arready(M00_AXI_arready),
    .s_axil_arprot(M00_AXI_arprot),
    .s_axil_rdata(M00_AXI_rdata),
    .s_axil_rresp(M00_AXI_rresp),
    .s_axil_rvalid(M00_AXI_rvalid),
    .s_axil_rready(M00_AXI_rready),
    .dec_rate(dec_rate),
    .dac_default(dac_default),
    .continous(continous),
    .rst_read(rst_read),
    .en_read(en_read)
);

//axi lite bram 
wire [31:0] dac_data;
wire finish_read;
read_bram_control #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(32),
    .INIT_FILE("")
) read_bram_controller (
    .axi_clock(axi_clock), 
    .rst(rst), 
    .s_axil_awaddr(M01_AXI_awaddr),
    .s_axil_awprot(M01_AXI_awprot),
    .s_axil_awvalid(M01_AXI_awvalid),
    .s_axil_awready(M01_AXI_awready),
    .s_axil_wdata(M01_AXI_wdata),
    .s_axil_wstrb(M01_AXI_wstrb),
    .s_axil_wvalid(M01_AXI_wvalid),
    .s_axil_wready(M01_AXI_wready),
    .s_axil_bresp(M01_AXI_bresp),
    .s_axil_bvalid(M01_AXI_bvalid),
    .s_axil_bready(M01_AXI_bready),
    .s_axil_araddr(M01_AXI_araddr),
    .s_axil_arvalid(M01_AXI_arvalid),
    .s_axil_arready(M01_AXI_arready),
    .s_axil_arprot(M01_AXI_arprot),
    .s_axil_rdata(M01_AXI_rdata),
    .s_axil_rresp(M01_AXI_rresp),
    .s_axil_rvalid(M01_AXI_rvalid),
    .s_axil_rready(M01_AXI_rready),
    .rst_read(rst_read), 
    .en_read(en_read), 
    .continous(continous),
    .dec_rate(dec_rate),
    .default_value(dac_default),
    .finish_read(finish_read),
    .dout(dac_data)
);


//dac 
dac_rp #(
    .DATA_WIDTH(14),
    .CLKIN1_PERIOD(8),
    .CLKFBOUT_MULT(8),
    .DIVCLK_DIVIDE(1),
    .CLKOUT0_DIVIDE(4)
) dac_inst (
    .clk(axi_clock),
    .dac0(dac_data[13:0]),
    .dac1(dac_data[16+:14]),    
    .ce(1'b1),
    .pll_rst(1'b0),
    //DAC signals
    // the mode is hardcoded to interleaved
    .dac_clk(dac_clk_o),    //iqclk --> clka/qclk
    .dac_rst(dac_rst_o),    //iqrst --> clkb/iqrst
    .dac_sel(dac_sel_o),    //iqsel --> wrtb/iqsel
    .dac_wrt(dac_wrt_o),    //iqwrt --> wrta/iqwrt
    .dac_dat(dac_dat_o)
);

assign led_o[0] = finish_read;

endmodule
