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
    
    
    //sata signals
    input wire [1:0] daisy_p_i,
    input wire [1:0] daisy_n_i,
    output wire [1:0] daisy_p_o,
    output wire [1:0] daisy_n_o,
    //leds
    output wire [7:0] led_o,
    //pin signals
    input wire [7:0] exp_p_tri_io,
    output wire [7:0] exp_n_tri_io
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
wire [31:0] debounce;
wire [31:0] zero_count, one_count, id_count;
wire calibrate, rst_irig;
wire [31:0] time_data, actual_time;
wire bcd_valid;
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
    .calibrate(calibrate),
    .rst_irig(rst_irig),
    .one_count(one_count),
    .zero_count(zero_count),
    .id_count(id_count),
    .debounce(debounce),
    .time_data(time_data),
    .bcd_valid(bcd_valid),
    .actual_time(actual_time)
);


wire [5:0] sec, min;
wire [4:0] hr;
wire [8:0] day;

wire pps;
irig_bcd irig_bcd_inst
(
    .clk(axi_clock),
    .rst(rst_irig),
    .calibrate(calibrate),
    .cont(1'b0),
    .one_count(one_count),
    .zero_count(zero_count),
    .id_count(id_count),
    .debounce(debounce),
    .din(exp_p_tri_io[1]),
    .sec(sec),
    .min(min),
    .hr(hr),
    .day(day),
    .bcd_valid(bcd_valid),
    .pps(pps)
);

assign time_data = {day, hr, min, sec};

//we got to extend the pps to see it in the led
reg pps_r=0, flag=0;
reg [24:0] count =0;
always@(posedge axi_clock)begin
    pps_r <= pps;
    if((pps & ~pps_r))
        flag <=1;
    else if(flag)begin
        if(&count) begin
            flag <=0;
            count <=0;
        end
        else
            count <=count+1;
    end
end


assign led_o[0] = flag;

//Here we change a the seconds field with each pps
//

reg [5:0] sec_r=0, min_r=0;
reg [4:0] hr_r=0;
reg [8:0] day_r=0;
reg bcd_valid_r =0;

always@(posedge axi_clock)begin
    bcd_valid_r <= bcd_valid;
    if(bcd_valid & ~bcd_valid_r)begin
        sec_r <= sec;
        min_r <= min;
        hr_r <= hr;
        day_r <= day;
    end
    else if(bcd_valid & pps)begin
        if(sec_r == 59)begin
            sec_r <=0;
            if(min_r ==59)begin
                min_r <=0;
                if(hr_r==23)begin
                    hr_r<=0;
                    if(day_r==364)
                        day_r <=0;
                    else
                        day_r <= day_r+1;
                end
                else
                    hr_r <=hr_r+1;
            end
            else
                min_r <= min_r+1;

        end
        else
            sec_r <= sec_r+1;
    end
end


assign actual_time = {day_r, hr_r, min_r, sec_r};

assign exp_n_tri_io[7] = flag;


endmodule
