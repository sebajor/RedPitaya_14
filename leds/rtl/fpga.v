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
    
    //sata signals
    input wire [1:0] daisy_p_i,
    input wire [1:0] daisy_n_i,
    output wire [1:0] daisy_p_o,
    output wire [1:0] daisy_n_o,
    //leds
    output wire [7:0] led_o

);

wire [31:0]M00_AXI_0_araddr;
  wire [2:0]M00_AXI_0_arprot;
  wire [0:0]M00_AXI_0_arready;
  wire [0:0]M00_AXI_0_arvalid;
  wire [31:0]M00_AXI_0_awaddr;
  wire [2:0]M00_AXI_0_awprot;
  wire [0:0]M00_AXI_0_awready;
  wire [0:0]M00_AXI_0_awvalid;
  wire [0:0]M00_AXI_0_bready;
  wire [1:0]M00_AXI_0_bresp;
  wire [0:0]M00_AXI_0_bvalid;
  wire [31:0]M00_AXI_0_rdata;
  wire [0:0]M00_AXI_0_rready;
  wire [1:0]M00_AXI_0_rresp;
  wire [0:0]M00_AXI_0_rvalid;
  wire [31:0]M00_AXI_0_wdata;
  wire [0:0]M00_AXI_0_wready;
  wire [3:0]M00_AXI_0_wstrb;
  wire [0:0]M00_AXI_0_wvalid;
  wire [31:0]M01_AXI_0_araddr;
  wire [2:0]M01_AXI_0_arprot;
  wire [0:0]M01_AXI_0_arready;
  wire [0:0]M01_AXI_0_arvalid;
  wire [31:0]M01_AXI_0_awaddr;
  wire [2:0]M01_AXI_0_awprot;
  wire [0:0]M01_AXI_0_awready;
  wire [0:0]M01_AXI_0_awvalid;
  wire [0:0]M01_AXI_0_bready;
  wire [1:0]M01_AXI_0_bresp;
  wire [0:0]M01_AXI_0_bvalid;
  wire [31:0]M01_AXI_0_rdata;
  wire [0:0]M01_AXI_0_rready;
  wire [1:0]M01_AXI_0_rresp;
  wire [0:0]M01_AXI_0_rvalid;
  wire [31:0]M01_AXI_0_wdata;
  wire [0:0]M01_AXI_0_wready;
  wire [3:0]M01_AXI_0_wstrb;
  wire [0:0]M01_AXI_0_wvalid;

//clock wires
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
    .M00_AXI_0_araddr(M00_AXI_0_araddr),
    .M00_AXI_0_arprot(M00_AXI_0_arprot),
    .M00_AXI_0_arready(M00_AXI_0_arready),
    .M00_AXI_0_arvalid(M00_AXI_0_arvalid),
    .M00_AXI_0_awaddr(M00_AXI_0_awaddr),
    .M00_AXI_0_awprot(M00_AXI_0_awprot),
    .M00_AXI_0_awready(M00_AXI_0_awready),
    .M00_AXI_0_awvalid(M00_AXI_0_awvalid),
    .M00_AXI_0_bready(M00_AXI_0_bready),
    .M00_AXI_0_bresp(M00_AXI_0_bresp),
    .M00_AXI_0_bvalid(M00_AXI_0_bvalid),
    .M00_AXI_0_rdata(M00_AXI_0_rdata),
    .M00_AXI_0_rready(M00_AXI_0_rready),
    .M00_AXI_0_rresp(M00_AXI_0_rresp),
    .M00_AXI_0_rvalid(M00_AXI_0_rvalid),
    .M00_AXI_0_wdata(M00_AXI_0_wdata),
    .M00_AXI_0_wready(M00_AXI_0_wready),
    .M00_AXI_0_wstrb(M00_AXI_0_wstrb),
    .M00_AXI_0_wvalid(M00_AXI_0_wvalid),
    .M01_AXI_0_araddr(M01_AXI_0_araddr),
    .M01_AXI_0_arprot(M01_AXI_0_arprot),
    .M01_AXI_0_arready(M01_AXI_0_arready),
    .M01_AXI_0_arvalid(M01_AXI_0_arvalid),
    .M01_AXI_0_awaddr(M01_AXI_0_awaddr),
    .M01_AXI_0_awprot(M01_AXI_0_awprot),
    .M01_AXI_0_awready(M01_AXI_0_awready),
    .M01_AXI_0_awvalid(M01_AXI_0_awvalid),
    .M01_AXI_0_bready(M01_AXI_0_bready),
    .M01_AXI_0_bresp(M01_AXI_0_bresp),
    .M01_AXI_0_bvalid(M01_AXI_0_bvalid),
    .M01_AXI_0_rdata(M01_AXI_0_rdata),
    .M01_AXI_0_rready(M01_AXI_0_rready),
    .M01_AXI_0_rresp(M01_AXI_0_rresp),
    .M01_AXI_0_rvalid(M01_AXI_0_rvalid),
    .M01_AXI_0_wdata(M01_AXI_0_wdata),
    .M01_AXI_0_wready(M01_AXI_0_wready),
    .M01_AXI_0_wstrb(M01_AXI_0_wstrb),
    .M01_AXI_0_wvalid(M01_AXI_0_wvalid),
    .adc_clk_out(adc_clk_out),
    .axi_clock(axi_clock)
);


//  convert the adc_clock in differential and set the oddr to the output
//  just when the clock is generated on the ps
ODDR i_adc_clk_p (.Q(adc_enc_p_o), .D1(1'b1), .D2(1'b0), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR i_adc_clk_n ( .Q(adc_enc_n_o), .D1(1'b0), .D2(1'b1), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));



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




//axi register
wire [7:0] led_out;
s_axi_lite_reg s_axi_lite_inst (
    .S_AXI_ACLK(axi_clock),
    .S_AXI_ARESETn(1'b1), //?
    .S_AXI_AWADDR(M00_AXI_0_awaddr),
    .S_AXI_AWPROT(M00_AXI_0_awprot),
    .S_AXI_AWVALID(M00_AXI_0_awvalid),
    .S_AXI_AWREADY(M00_AXI_0_awready),
    .S_AXI_WDATA(M00_AXI_0_wdata),
    .S_AXI_WSTRB(M00_AXI_0_wstrb),
    .S_AXI_WVALID(M00_AXI_0_wvalid),
    .S_AXI_WREADY(M00_AXI_0_wready),
    .S_AXI_BRESP(M00_AXI_0_bresp),
    .S_AXI_BVALID(M00_AXI_0_bvalid),
    .S_AXI_BREADY(M00_AXI_0_bready),
    .S_AXI_ARADDR(M00_AXI_0_araddr),
    .S_AXI_ARVALID(M00_AXI_0_arvalid),
    .S_AXI_ARREADY(M00_AXI_0_arready),
    .S_AXI_ARPROT(M00_AXI_0_arprot),
    .S_AXI_RDATA(M00_AXI_0_rdata),
    .S_AXI_RRESP(M00_AXI_0_rresp),
    .S_AXI_RVALID(M00_AXI_0_rvalid),
    .S_AXI_RREADY(M00_AXI_0_rready),
    .led_out(led_out)
);

assign led_o = led_out;

//axi lite memory

s_axi_lite_mem #(
    .C_S_AXI_DATA_WIDTH(32),
    .C_S_AXI_ADDR_WIDTH(8)  //i think its always 64..
) s_axi_lite_mem_inst(
    .S_AXI_ACLK(axi_clock),
    .S_AXI_ARESETn(1'b1),
    .S_AXI_AWADDR(M01_AXI_0_awaddr),
    .S_AXI_AWPROT(M01_AXI_0_awprot),
    .S_AXI_AWVALID(M01_AXI_0_awvalid),
    .S_AXI_AWREADY(M01_AXI_0_awready),
    .S_AXI_WDATA(M01_AXI_0_wdata),
    .S_AXI_WSTRB(M01_AXI_0_wstrb),
    .S_AXI_WVALID(M01_AXI_0_wvalid),
    .S_AXI_WREADY(M01_AXI_0_wready),
    .S_AXI_BRESP(M01_AXI_0_bresp),
    .S_AXI_BVALID(M01_AXI_0_bvalid),
    .S_AXI_BREADY(M01_AXI_0_bready),
    .S_AXI_ARADDR(M01_AXI_0_araddr),
    .S_AXI_ARVALID(M01_AXI_0_arvalid),
    .S_AXI_ARREADY(M01_AXI_0_arready),
    .S_AXI_ARPROT(M01_AXI_0_arprot),
    .S_AXI_RDATA(M01_AXI_0_rdata),
    .S_AXI_RRESP(M01_AXI_0_rresp),
    .S_AXI_RVALID(M01_AXI_0_rvalid),
    .S_AXI_RREADY(M01_AXI_0_rready)
);


endmodule 
