module fpga #(
    parameter BRAM_ADDR = 10,
    parameter INIT_TWIDD = "../rtl/twidd_init.hex"
)
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

wire [31:0] M02_AXI_araddr;
wire [2:0] M02_AXI_arprot;
wire [0:0] M02_AXI_arready;
wire [0:0] M02_AXI_arvalid;
wire [31:0] M02_AXI_awaddr;
wire [2:0] M02_AXI_awprot;
wire [0:0] M02_AXI_awready;
wire [0:0] M02_AXI_awvalid;
wire [0:0] M02_AXI_bready;
wire [1:0] M02_AXI_bresp;
wire [0:0] M02_AXI_bvalid;
wire [31:0] M02_AXI_rdata;
wire [0:0] M02_AXI_rready;
wire [1:0] M02_AXI_rresp;
wire [0:0] M02_AXI_rvalid;
wire [31:0] M02_AXI_wdata;
wire [0:0] M02_AXI_wready;
wire [3:0] M02_AXI_wstrb;
wire [0:0] M02_AXI_wvalid;

wire [31:0] M03_AXI_araddr;
wire [2:0] M03_AXI_arprot;
wire [0:0] M03_AXI_arready;
wire [0:0] M03_AXI_arvalid;
wire [31:0] M03_AXI_awaddr;
wire [2:0] M03_AXI_awprot;
wire [0:0] M03_AXI_awready;
wire [0:0] M03_AXI_awvalid;
wire [0:0] M03_AXI_bready;
wire [1:0] M03_AXI_bresp;
wire [0:0] M03_AXI_bvalid;
wire [31:0] M03_AXI_rdata;
wire [0:0] M03_AXI_rready;
wire [1:0] M03_AXI_rresp;
wire [0:0] M03_AXI_rvalid;
wire [31:0] M03_AXI_wdata;
wire [0:0] M03_AXI_wready;
wire [3:0] M03_AXI_wstrb;
wire [0:0] M03_AXI_wvalid;

wire [31:0] M04_AXI_araddr;
wire [2:0] M04_AXI_arprot;
wire [0:0] M04_AXI_arready;
wire [0:0] M04_AXI_arvalid;
wire [31:0] M04_AXI_awaddr;
wire [2:0] M04_AXI_awprot;
wire [0:0] M04_AXI_awready;
wire [0:0] M04_AXI_awvalid;
wire [0:0] M04_AXI_bready;
wire [1:0] M04_AXI_bresp;
wire [0:0] M04_AXI_bvalid;
wire [31:0] M04_AXI_rdata;
wire [0:0] M04_AXI_rready;
wire [1:0] M04_AXI_rresp;
wire [0:0] M04_AXI_rvalid;
wire [31:0] M04_AXI_wdata;
wire [0:0] M04_AXI_wready;
wire [3:0] M04_AXI_wstrb;
wire [0:0] M04_AXI_wvalid;

wire [31:0] M05_AXI_araddr;
wire [2:0] M05_AXI_arprot;
wire [0:0] M05_AXI_arready;
wire [0:0] M05_AXI_arvalid;
wire [31:0] M05_AXI_awaddr;
wire [2:0] M05_AXI_awprot;
wire [0:0] M05_AXI_awready;
wire [0:0] M05_AXI_awvalid;
wire [0:0] M05_AXI_bready;
wire [1:0] M05_AXI_bresp;
wire [0:0] M05_AXI_bvalid;
wire [31:0] M05_AXI_rdata;
wire [0:0] M05_AXI_rready;
wire [1:0] M05_AXI_rresp;
wire [0:0] M05_AXI_rvalid;
wire [31:0] M05_AXI_wdata;
wire [0:0] M05_AXI_wready;
wire [3:0] M05_AXI_wstrb;
wire [0:0] M05_AXI_wvalid;

wire [31:0] M06_AXI_araddr;
wire [2:0] M06_AXI_arprot;
wire [0:0] M06_AXI_arready;
wire [0:0] M06_AXI_arvalid;
wire [31:0] M06_AXI_awaddr;
wire [2:0] M06_AXI_awprot;
wire [0:0] M06_AXI_awready;
wire [0:0] M06_AXI_awvalid;
wire [0:0] M06_AXI_bready;
wire [1:0] M06_AXI_bresp;
wire [0:0] M06_AXI_bvalid;
wire [31:0] M06_AXI_rdata;
wire [0:0] M06_AXI_rready;
wire [1:0] M06_AXI_rresp;
wire [0:0] M06_AXI_rvalid;
wire [31:0] M06_AXI_wdata;
wire [0:0] M06_AXI_wready;
wire [3:0] M06_AXI_wstrb;
wire [0:0] M06_AXI_wvalid;


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
    .M02_AXI_araddr(M02_AXI_araddr),
    .M02_AXI_arprot(M02_AXI_arprot),
    .M02_AXI_arready(M02_AXI_arready),
    .M02_AXI_arvalid(M02_AXI_arvalid),
    .M02_AXI_awaddr(M02_AXI_awaddr),
    .M02_AXI_awprot(M02_AXI_awprot),
    .M02_AXI_awready(M02_AXI_awready),
    .M02_AXI_awvalid(M02_AXI_awvalid),
    .M02_AXI_bready(M02_AXI_bready),
    .M02_AXI_bresp(M02_AXI_bresp),
    .M02_AXI_bvalid(M02_AXI_bvalid),
    .M02_AXI_rdata(M02_AXI_rdata),
    .M02_AXI_rready(M02_AXI_rready),
    .M02_AXI_rresp(M02_AXI_rresp),
    .M02_AXI_rvalid(M02_AXI_rvalid),
    .M02_AXI_wdata(M02_AXI_wdata),
    .M02_AXI_wready(M02_AXI_wready),
    .M02_AXI_wstrb(M02_AXI_wstrb),
    .M02_AXI_wvalid(M02_AXI_wvalid),
    .M03_AXI_araddr(M03_AXI_araddr),
    .M03_AXI_arprot(M03_AXI_arprot),
    .M03_AXI_arready(M03_AXI_arready),
    .M03_AXI_arvalid(M03_AXI_arvalid),
    .M03_AXI_awaddr(M03_AXI_awaddr),
    .M03_AXI_awprot(M03_AXI_awprot),
    .M03_AXI_awready(M03_AXI_awready),
    .M03_AXI_awvalid(M03_AXI_awvalid),
    .M03_AXI_bready(M03_AXI_bready),
    .M03_AXI_bresp(M03_AXI_bresp),
    .M03_AXI_bvalid(M03_AXI_bvalid),
    .M03_AXI_rdata(M03_AXI_rdata),
    .M03_AXI_rready(M03_AXI_rready),
    .M03_AXI_rresp(M03_AXI_rresp),
    .M03_AXI_rvalid(M03_AXI_rvalid),
    .M03_AXI_wdata(M03_AXI_wdata),
    .M03_AXI_wready(M03_AXI_wready),
    .M03_AXI_wstrb(M03_AXI_wstrb),
    .M03_AXI_wvalid(M03_AXI_wvalid),
    .M04_AXI_araddr(M04_AXI_araddr),
    .M04_AXI_arprot(M04_AXI_arprot),
    .M04_AXI_arready(M04_AXI_arready),
    .M04_AXI_arvalid(M04_AXI_arvalid),
    .M04_AXI_awaddr(M04_AXI_awaddr),
    .M04_AXI_awprot(M04_AXI_awprot),
    .M04_AXI_awready(M04_AXI_awready),
    .M04_AXI_awvalid(M04_AXI_awvalid),
    .M04_AXI_bready(M04_AXI_bready),
    .M04_AXI_bresp(M04_AXI_bresp),
    .M04_AXI_bvalid(M04_AXI_bvalid),
    .M04_AXI_rdata(M04_AXI_rdata),
    .M04_AXI_rready(M04_AXI_rready),
    .M04_AXI_rresp(M04_AXI_rresp),
    .M04_AXI_rvalid(M04_AXI_rvalid),
    .M04_AXI_wdata(M04_AXI_wdata),
    .M04_AXI_wready(M04_AXI_wready),
    .M04_AXI_wstrb(M04_AXI_wstrb),
    .M04_AXI_wvalid(M04_AXI_wvalid),
    .M05_AXI_araddr(M05_AXI_araddr),
    .M05_AXI_arprot(M05_AXI_arprot),
    .M05_AXI_arready(M05_AXI_arready),
    .M05_AXI_arvalid(M05_AXI_arvalid),
    .M05_AXI_awaddr(M05_AXI_awaddr),
    .M05_AXI_awprot(M05_AXI_awprot),
    .M05_AXI_awready(M05_AXI_awready),
    .M05_AXI_awvalid(M05_AXI_awvalid),
    .M05_AXI_bready(M05_AXI_bready),
    .M05_AXI_bresp(M05_AXI_bresp),
    .M05_AXI_bvalid(M05_AXI_bvalid),
    .M05_AXI_rdata(M05_AXI_rdata),
    .M05_AXI_rready(M05_AXI_rready),
    .M05_AXI_rresp(M05_AXI_rresp),
    .M05_AXI_rvalid(M05_AXI_rvalid),
    .M05_AXI_wdata(M05_AXI_wdata),
    .M05_AXI_wready(M05_AXI_wready),
    .M05_AXI_wstrb(M05_AXI_wstrb),
    .M05_AXI_wvalid(M05_AXI_wvalid),
    .M06_AXI_araddr(M06_AXI_araddr),
    .M06_AXI_arprot(M06_AXI_arprot),
    .M06_AXI_arready(M06_AXI_arready),
    .M06_AXI_arvalid(M06_AXI_arvalid),
    .M06_AXI_awaddr(M06_AXI_awaddr),
    .M06_AXI_awprot(M06_AXI_awprot),
    .M06_AXI_awready(M06_AXI_awready),
    .M06_AXI_awvalid(M06_AXI_awvalid),
    .M06_AXI_bready(M06_AXI_bready),
    .M06_AXI_bresp(M06_AXI_bresp),
    .M06_AXI_bvalid(M06_AXI_bvalid),
    .M06_AXI_rdata(M06_AXI_rdata),
    .M06_AXI_rready(M06_AXI_rready),
    .M06_AXI_rresp(M06_AXI_rresp),
    .M06_AXI_rvalid(M06_AXI_rvalid),
    .M06_AXI_wdata(M06_AXI_wdata),
    .M06_AXI_wready(M06_AXI_wready),
    .M06_AXI_wstrb(M06_AXI_wstrb),
    .M06_AXI_wvalid(M06_AXI_wvalid),
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


//control signals
wire correlator_en;
wire correlator_rst;
wire [31:0] delay_line;
wire [31:0] acc_len;
wire corr_new_frame;
wire corr_continuous;
wire [31:0] snap_config;
wire [31:0] snap_offset;
wire snap_trigger;

s_axil_reg #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(6)
) s_axil_reg_inst (
    .axi_clock(axi_clock), 
    .rst(1'b0), 
    .s_axil_awaddr(M06_AXI_awaddr),
    .s_axil_awprot(M06_AXI_awprot),
    .s_axil_awvalid(M06_AXI_awvalid),
    .s_axil_awready(M06_AXI_awready),
    .s_axil_wdata(M06_AXI_wdata),
    .s_axil_wstrb(M06_AXI_wstrb),
    .s_axil_wvalid(M06_AXI_wvalid),
    .s_axil_wready(M06_AXI_wready),
    .s_axil_bresp(M06_AXI_bresp),
    .s_axil_bvalid(M06_AXI_bvalid),
    .s_axil_bready(M06_AXI_bready),
    .s_axil_araddr(M06_AXI_araddr),
    .s_axil_arvalid(M06_AXI_arvalid),
    .s_axil_arready(M06_AXI_arready),
    .s_axil_arprot(M06_AXI_arprot),
    .s_axil_rdata(M06_AXI_rdata),
    .s_axil_rresp(M06_AXI_rresp),
    .s_axil_rvalid(M06_AXI_rvalid),
    .s_axil_rready(M06_AXI_rready),
    .correlator_en(correlator_en),
    .correlator_rst(correlator_rst),
    .delay_line(delay_line),
    .acc_len(acc_len),
    .snap_config(snap_config),
    .snap_offset(snap_offset),
    .snap_trigger(snap_trigger),
    .corr_new_frame(corr_new_frame),
    .corr_continuous(corr_continuous)
);

// synchronize signals
reg [1:0] correlator_en_r;
reg [1:0] correlator_rst_r;
reg [63:0] delay_line_r;
reg [63:0] acc_len_r;
reg [63:0] snap_config_r;
reg [63:0] snap_offset_r;
reg [1:0] snap_trigger_r;
reg [1:0] corr_new_frame_r;
reg [1:0] corr_continuous_r;

always@(posedge adc_clk_in)begin
    correlator_en_r <= {correlator_en_r[0], correlator_en};
    correlator_rst_r <= {correlator_rst_r[0], correlator_rst};
    delay_line_r <= {delay_line_r[31:0], delay_line};
    acc_len_r <= {acc_len_r[31:0], acc_len};
    snap_config_r <= {snap_config_r[31:0], snap_config};
    snap_offset_r <= {snap_offset_r[31:0], snap_offset};
    snap_trigger_r <= {snap_trigger_r[0], snap_trigger};
    corr_new_frame_r <= {corr_new_frame_r[0], corr_new_frame};
    corr_continuous_r <= {corr_continuous_r[0], corr_continuous};
end

wire correlator_en_sync= correlator_en_r[1];
wire correlator_rst_sync= correlator_rst_r[1];
wire [31:0] delay_line_sync = delay_line_r[63:32];
wire [31:0] acc_len_sync = acc_len_r[63:32];
wire [31:0] snap_config_sync = snap_config_r[63:32];
wire [31:0] snap_offset_sync = snap_offset_r[63:32];
wire snap_trigger_sync = snap_trigger_r[1];
wire corr_new_frame_sync = corr_new_frame_r[1];
wire corr_continuous_sync = corr_continuous_r[1];


//adc instantiation
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

//convert data to signed 
wire [13:0] adc0,adc1;
assign adc0 = {adc_dat0[13], ~adc_dat0[12:0]};
assign adc1 = {adc_dat1[13], ~adc_dat1[13:0]};

//msdft correalator
wire signed [31:0] corr_re, corr_im;
wire [31:0] pow0, pow1;
wire corr_valid;

axil_msdft_correlator #(
    .DIN_WIDTH(14),//8,
    .DIN_POINT(13),//7,
    .TWIDD_WIDTH(16), //this is limited by the axi intf... check how to change it
    .TWIDD_POINT(14),
    .TWIDD_FILE(INIT_TWIDD),
    .DFT_LEN(8192),
    .MSDFT_WIDTH(32),
    .MSDFT_POINT(16),
    .ACC_WIDTH(32),   //acumulator input (after the correlation mults)   
    .ACC_POINT(12),
    .DOUT_WIDTH(32)
) axil_msdft_correlator_inst (
    .clk(adc_clk_in), 
    .rst(correlator_rst_sync),
    .din1_re(adc0), 
    .din1_im(14'b0), 
    .din2_re(adc1),
    .din2_im(14'b0),
    .din_valid(correlator_en_sync),
    .r12_re(corr_re),
    .r12_im(corr_im),
    .r11(pow0),
    .r22(pow1),
    .dout_valid(corr_valid),
    //delay line configuration
    .delay_line(delay_line_sync),
    .acc_len(acc_len_sync),
    //axil signals
    .axi_clock(axi_clock),
    .axil_rst(1'b0),
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

//correlator brams
reg [BRAM_ADDR:0] bram_addr=0;
reg corr_new_frame_sync_r=0;

reg [31:0] pow0_data, pow1_data;
reg signed [31:0] corr_re_data, corr_im_data;
reg corr_data_valid;

always@(posedge adc_clk_in)begin
    corr_new_frame_sync_r <= corr_new_frame_sync;
    if(~corr_new_frame_r & corr_new_frame_sync)begin
        //detect rising edge to reset the counter
        bram_addr <={(BRAM_ADDR+1){1'b1}};
    end
    else if(corr_valid)begin
        pow0_data <= pow0;
        pow1_data <= pow1;
        corr_re_data <= corr_re;
        corr_im_data <= corr_im;
        if(corr_continuous_sync)begin
            bram_addr <= bram_addr+1;
            corr_data_valid <= 1;
        end 
        else if(!(~bram_addr[BRAM_ADDR] & (&bram_addr[BRAM_ADDR-1:0])))begin
            bram_addr <= bram_addr+1;
            corr_data_valid <=1;
        end
        else
            corr_data_valid <= 0;
    end
    else 
        corr_data_valid <=0;
end

axil_bram #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(BRAM_ADDR)
)pow0_bram (
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
    //fpga side
    .fpga_clk(adc_clk_in),
    .bram_din(pow0_data),
    .bram_addr(bram_addr[BRAM_ADDR-1:0]),
    .bram_we(corr_data_valid),
    .bram_dout()
);

axil_bram #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(BRAM_ADDR)
)pow1_bram (
    .axi_clock(axi_clock), 
    .rst(1'b0), 
    .s_axil_awaddr(M02_AXI_awaddr),
    .s_axil_awprot(M02_AXI_awprot),
    .s_axil_awvalid(M02_AXI_awvalid),
    .s_axil_awready(M02_AXI_awready),
    .s_axil_wdata(M02_AXI_wdata),
    .s_axil_wstrb(M02_AXI_wstrb),
    .s_axil_wvalid(M02_AXI_wvalid),
    .s_axil_wready(M02_AXI_wready),
    .s_axil_bresp(M02_AXI_bresp),
    .s_axil_bvalid(M02_AXI_bvalid),
    .s_axil_bready(M02_AXI_bready),
    .s_axil_araddr(M02_AXI_araddr),
    .s_axil_arvalid(M02_AXI_arvalid),
    .s_axil_arready(M02_AXI_arready),
    .s_axil_arprot(M02_AXI_arprot),
    .s_axil_rdata(M02_AXI_rdata),
    .s_axil_rresp(M02_AXI_rresp),
    .s_axil_rvalid(M02_AXI_rvalid),
    .s_axil_rready(M02_AXI_rready),
    //fpga side
    .fpga_clk(adc_clk_in),
    .bram_din(pow1_data),
    .bram_addr(bram_addr[BRAM_ADDR-1:0]),
    .bram_we(corr_data_valid),
    .bram_dout()
);

axil_bram #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(BRAM_ADDR)
) corr_re_bram (
    .axi_clock(axi_clock), 
    .rst(1'b0), 
    .s_axil_awaddr(M03_AXI_awaddr),
    .s_axil_awprot(M03_AXI_awprot),
    .s_axil_awvalid(M03_AXI_awvalid),
    .s_axil_awready(M03_AXI_awready),
    .s_axil_wdata(M03_AXI_wdata),
    .s_axil_wstrb(M03_AXI_wstrb),
    .s_axil_wvalid(M03_AXI_wvalid),
    .s_axil_wready(M03_AXI_wready),
    .s_axil_bresp(M03_AXI_bresp),
    .s_axil_bvalid(M03_AXI_bvalid),
    .s_axil_bready(M03_AXI_bready),
    .s_axil_araddr(M03_AXI_araddr),
    .s_axil_arvalid(M03_AXI_arvalid),
    .s_axil_arready(M03_AXI_arready),
    .s_axil_arprot(M03_AXI_arprot),
    .s_axil_rdata(M03_AXI_rdata),
    .s_axil_rresp(M03_AXI_rresp),
    .s_axil_rvalid(M03_AXI_rvalid),
    .s_axil_rready(M03_AXI_rready),
    //fpga side
    .fpga_clk(adc_clk_in),
    .bram_din(corr_re_data),
    .bram_addr(bram_addr[BRAM_ADDR-1:0]),
    .bram_we(corr_data_valid),
    .bram_dout()
);


axil_bram #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(BRAM_ADDR)
) corr_im_bram (
    .axi_clock(axi_clock), 
    .rst(1'b0), 
    .s_axil_awaddr(M04_AXI_awaddr),
    .s_axil_awprot(M04_AXI_awprot),
    .s_axil_awvalid(M04_AXI_awvalid),
    .s_axil_awready(M04_AXI_awready),
    .s_axil_wdata(M04_AXI_wdata),
    .s_axil_wstrb(M04_AXI_wstrb),
    .s_axil_wvalid(M04_AXI_wvalid),
    .s_axil_wready(M04_AXI_wready),
    .s_axil_bresp(M04_AXI_bresp),
    .s_axil_bvalid(M04_AXI_bvalid),
    .s_axil_bready(M04_AXI_bready),
    .s_axil_araddr(M04_AXI_araddr),
    .s_axil_arvalid(M04_AXI_arvalid),
    .s_axil_arready(M04_AXI_arready),
    .s_axil_arprot(M04_AXI_arprot),
    .s_axil_rdata(M04_AXI_rdata),
    .s_axil_rresp(M04_AXI_rresp),
    .s_axil_rvalid(M04_AXI_rvalid),
    .s_axil_rready(M04_AXI_rready),
    //fpga side
    .fpga_clk(adc_clk_in),
    .bram_din(corr_im_data),
    .bram_addr(bram_addr[BRAM_ADDR-1:0]),
    .bram_we(corr_data_valid),
    .bram_dout()
);

//snapshot
//TODO!!

wire [31:0] adc_data;
assign adc_data = {{3{adc_dat1[13]}}, ~adc_dat1[12:0], {3{adc_dat0[13]}}, ~adc_dat0[12:0]};

snapshot #(
    .WORD_SIZE(32),
    .ADDR_SIZE(BRAM_ADDR)
) snapshot_inst (
    .fpga_clk(adc_clk_in),
    .din(adc_data),
    .valid(snap_trigger_sync),
    .rst(1'b0),
    .trigger(1'b1),
    .axi_clock(axi_clock),
    .S_AXI_AWADDR(M05_AXI_awaddr),
    .S_AXI_AWPROT(M05_AXI_awprot),
    .S_AXI_AWVALID(M05_AXI_awvalid),
    .S_AXI_AWREADY(M05_AXI_awready),
    .S_AXI_WDATA(M05_AXI_wdata),
    .S_AXI_WSTRB(M05_AXI_wstrb),
    .S_AXI_WVALID(M05_AXI_wvalid),
    .S_AXI_WREADY(M05_AXI_wready),
    .S_AXI_BRESP(M05_AXI_bresp),
    .S_AXI_BVALID(M05_AXI_bvalid),
    .S_AXI_BREADY(M05_AXI_bready),
    .S_AXI_ARADDR(M05_AXI_araddr),
    .S_AXI_ARVALID(M05_AXI_arvalid),
    .S_AXI_ARREADY(M05_AXI_arready),
    .S_AXI_ARPROT(M05_AXI_arprot),
    .S_AXI_RDATA(M05_AXI_rdata),
    .S_AXI_RRESP(M05_AXI_rresp),
    .S_AXI_RVALID(M05_AXI_rvalid),
    .S_AXI_RREADY(M05_AXI_rready),
    .configuration(snap_config_sync),
    .offset(snap_offset_sync)
);

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
