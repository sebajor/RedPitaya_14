//`default_nettype none
//`include "s_axil_reg.v"
//`include "axil_bram.v"
//`include "system_wrapper.v"

module fpga (
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
    inout wire FIXED_IO_ps_srstb

);

wire [31:0]M00_AXI_araddr;
wire [2:0]M00_AXI_arprot;
wire [0:0]M00_AXI_arready;
wire [0:0]M00_AXI_arvalid;
wire [31:0]M00_AXI_awaddr;
wire [2:0]M00_AXI_awprot;
wire [0:0]M00_AXI_awready;
wire [0:0]M00_AXI_awvalid;
wire [0:0]M00_AXI_bready;
wire [1:0]M00_AXI_bresp;
wire [0:0]M00_AXI_bvalid;
wire [31:0]M00_AXI_rdata;
wire [0:0]M00_AXI_rready;
wire [1:0]M00_AXI_rresp;
wire [0:0]M00_AXI_rvalid;
wire [31:0]M00_AXI_wdata;
wire [0:0]M00_AXI_wready;
wire [3:0]M00_AXI_wstrb;
wire [0:0]M00_AXI_wvalid;

wire [31:0]M01_AXI_araddr;
wire [2:0]M01_AXI_arprot;
wire [0:0]M01_AXI_arready;
wire [0:0]M01_AXI_arvalid;
wire [31:0]M01_AXI_awaddr;
wire [2:0]M01_AXI_awprot;
wire [0:0]M01_AXI_awready;
wire [0:0]M01_AXI_awvalid;
wire [0:0]M01_AXI_bready;
wire [1:0]M01_AXI_bresp;
wire [0:0]M01_AXI_bvalid;
wire [31:0]M01_AXI_rdata;
wire [0:0]M01_AXI_rready;
wire [1:0]M01_AXI_rresp;
wire [0:0]M01_AXI_rvalid;
wire [31:0]M01_AXI_wdata;
wire [0:0]M01_AXI_wready;
wire [3:0]M01_AXI_wstrb;
wire [0:0]M01_AXI_wvalid;


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
    .axi_clock(axi_clock),
    .adc_clk_out(adc_clk_out)
);

//axil register
wire [31:0] bram_write, bram_read;
wire bram_we;
wire [31:0] bram_addr;

s_axil_reg #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(3)
) axil_reg_inst (
    .bram_write(bram_write),
    .bram_addr(bram_addr),
    .bram_we(bram_we),
    .bram_read(bram_read),
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
    .s_axil_rready(M00_AXI_rready)
);

//axil bram

axil_bram #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(10)
) axil_bram_inst (
    .axi_clock(axi_clock), 
    .rst(1'b0), 
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
    .fpga_clk(axi_clock),
    .bram_din(bram_write),
    .bram_addr(bram_addr[9:0]),
    .bram_we(bram_we),
    .bram_dout(bram_read)
);

endmodule
