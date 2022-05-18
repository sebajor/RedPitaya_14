//`include "rp_adc.v"
//`include "system_wrapper.v"
//`include "snapshot.v"
//`include "s_axil_reg.v"
//`include "s_axil_ram_rd.v"
//`include "xil_primitives.v"

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
    inout wire FIXED_IO_ps_srstb,

    //out adc clock
    output wire adc_enc_p_o,
    output wire adc_enc_n_o,

    //input adc clock
    input wire adc_clk_p_i,
    input wire adc_clk_n_i,

    //adc data
    input wire [13:0] adc_dat_a_i,
    input wire [13:0] adc_dat_b_i,
        
    output wire adc_csn_o 
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




//  convert the adc_clock in differential and set the oddr to the output
//  just when the clock is generated on the ps
ODDR i_adc_clk_p (.Q(adc_enc_p_o), .D1(1'b1), .D2(1'b0), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR i_adc_clk_n ( .Q(adc_enc_n_o), .D1(1'b0), .D2(1'b1), .C(adc_clk_out), .CE(1'b1), .R(1'b0), .S(1'b0));

//adc clock differential buffer
wire adc_clk_in_0, adc_clk_in;
IBUFGDS adc_clk_inst_in (.I(adc_clk_p_i), .IB(adc_clk_n_i), .O(adc_clk_in_0));
BUFG adc_clk_inst (.I(adc_clk_in_0), .O(adc_clk_in));

wire [13:0] adc_dat0, adc_dat1;

rp_adc #(
    .ADC_BITWIDTH(14)
)rp_adc_inst (
    .adc_clk(adc_clk_in),
    .adc0_in(adc_dat_a_i),
    .adc1_in(adc_dat_b_i),
    .adc0_out(adc_dat0),
    .adc1_out(adc_dat1),
    .adc_csn()
);

assign adc_csn_o = 1'b1;
wire [31:0] adc_data;
//convert to signed and pad the sign bits
assign adc_data = {{3{adc_dat1[13]}}, ~adc_dat1[12:0], {3{adc_dat0[13]}}, ~adc_dat0[12:0]};
//assign adc_data = {{2'b0}, adc_dat1, 2'b0, adc_dat0};

//axi lite modules
wire [31:0] config_snapshot, offset_snapshot; 

s_axil_reg #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(2)
) s_axil_reg_inst (
    .config_snapshot(config_snapshot),
    .offset_snapshot(offset_snapshot),
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

snapshot #(
    .WORD_SIZE(32),
    .ADDR_SIZE(11)
) snapshot_inst (
    .fpga_clk(adc_clk_in),
    .din(adc_data),
    .valid(1'b1),
    .rst(1'b0),
    .trigger(1'b1),
    //axil signals
    .axi_clock(axi_clock),
    .S_AXI_AWADDR(M01_AXI_awaddr),
    .S_AXI_AWPROT(M01_AXI_awprot),
    .S_AXI_AWVALID(M01_AXI_awvalid),
    .S_AXI_AWREADY(M01_AXI_awready),
    .S_AXI_WDATA(M01_AXI_wdata),
    .S_AXI_WSTRB(M01_AXI_wstrb),
    .S_AXI_WVALID(M01_AXI_wvalid),
    .S_AXI_WREADY(M01_AXI_wready),
    .S_AXI_BRESP(M01_AXI_bresp),
    .S_AXI_BVALID(M01_AXI_bvalid),
    .S_AXI_BREADY(M01_AXI_bready),
    .S_AXI_ARADDR(M01_AXI_araddr),
    .S_AXI_ARVALID(M01_AXI_arvalid),
    .S_AXI_ARREADY(M01_AXI_arready),
    .S_AXI_ARPROT(M01_AXI_arprot),
    .S_AXI_RDATA(M01_AXI_rdata),
    .S_AXI_RRESP(M01_AXI_rresp),
    .S_AXI_RVALID(M01_AXI_rvalid),
    .S_AXI_RREADY(M01_AXI_rready),
    .configuration(config_snapshot),
    .offset(offset_snapshot)
);





endmodule
