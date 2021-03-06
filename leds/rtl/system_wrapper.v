module system_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    M00_AXI_0_araddr,
    M00_AXI_0_arprot,
    M00_AXI_0_arready,
    M00_AXI_0_arvalid,
    M00_AXI_0_awaddr,
    M00_AXI_0_awprot,
    M00_AXI_0_awready,
    M00_AXI_0_awvalid,
    M00_AXI_0_bready,
    M00_AXI_0_bresp,
    M00_AXI_0_bvalid,
    M00_AXI_0_rdata,
    M00_AXI_0_rready,
    M00_AXI_0_rresp,
    M00_AXI_0_rvalid,
    M00_AXI_0_wdata,
    M00_AXI_0_wready,
    M00_AXI_0_wstrb,
    M00_AXI_0_wvalid,
    M01_AXI_0_araddr,
    M01_AXI_0_arprot,
    M01_AXI_0_arready,
    M01_AXI_0_arvalid,
    M01_AXI_0_awaddr,
    M01_AXI_0_awprot,
    M01_AXI_0_awready,
    M01_AXI_0_awvalid,
    M01_AXI_0_bready,
    M01_AXI_0_bresp,
    M01_AXI_0_bvalid,
    M01_AXI_0_rdata,
    M01_AXI_0_rready,
    M01_AXI_0_rresp,
    M01_AXI_0_rvalid,
    M01_AXI_0_wdata,
    M01_AXI_0_wready,
    M01_AXI_0_wstrb,
    M01_AXI_0_wvalid,
    adc_clk_out,
    axi_clock);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output [31:0]M00_AXI_0_araddr;
  output [2:0]M00_AXI_0_arprot;
  input [0:0]M00_AXI_0_arready;
  output [0:0]M00_AXI_0_arvalid;
  output [31:0]M00_AXI_0_awaddr;
  output [2:0]M00_AXI_0_awprot;
  input [0:0]M00_AXI_0_awready;
  output [0:0]M00_AXI_0_awvalid;
  output [0:0]M00_AXI_0_bready;
  input [1:0]M00_AXI_0_bresp;
  input [0:0]M00_AXI_0_bvalid;
  input [31:0]M00_AXI_0_rdata;
  output [0:0]M00_AXI_0_rready;
  input [1:0]M00_AXI_0_rresp;
  input [0:0]M00_AXI_0_rvalid;
  output [31:0]M00_AXI_0_wdata;
  input [0:0]M00_AXI_0_wready;
  output [3:0]M00_AXI_0_wstrb;
  output [0:0]M00_AXI_0_wvalid;
  output [31:0]M01_AXI_0_araddr;
  output [2:0]M01_AXI_0_arprot;
  input [0:0]M01_AXI_0_arready;
  output [0:0]M01_AXI_0_arvalid;
  output [31:0]M01_AXI_0_awaddr;
  output [2:0]M01_AXI_0_awprot;
  input [0:0]M01_AXI_0_awready;
  output [0:0]M01_AXI_0_awvalid;
  output [0:0]M01_AXI_0_bready;
  input [1:0]M01_AXI_0_bresp;
  input [0:0]M01_AXI_0_bvalid;
  input [31:0]M01_AXI_0_rdata;
  output [0:0]M01_AXI_0_rready;
  input [1:0]M01_AXI_0_rresp;
  input [0:0]M01_AXI_0_rvalid;
  output [31:0]M01_AXI_0_wdata;
  input [0:0]M01_AXI_0_wready;
  output [3:0]M01_AXI_0_wstrb;
  output [0:0]M01_AXI_0_wvalid;
  output adc_clk_out;
  output axi_clock;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
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
  wire adc_clk_out;
  wire axi_clock;

  system system_i
       (.DDR_addr(DDR_addr),
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
        .axi_clock(axi_clock));
endmodule

