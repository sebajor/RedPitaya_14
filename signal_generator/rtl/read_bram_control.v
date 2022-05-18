


module read_bram_control #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32,
    parameter INIT_FILE = ""
) (
    //axi lite signals
    input wire axi_clock, 
    input wire rst, 
    //write address channel
    input wire [ADDR_WIDTH+1:0] s_axil_awaddr,
    input wire [2:0] s_axil_awprot,
    input wire s_axil_awvalid,
    output wire s_axil_awready,
    //write data channel
    input wire [DATA_WIDTH-1:0] s_axil_wdata,
    input wire [DATA_WIDTH/8-1:0] s_axil_wstrb,
    input wire s_axil_wvalid,
    output wire s_axil_wready,
    //write response channel 
    output wire [1:0] s_axil_bresp,
    output wire s_axil_bvalid,
    input wire s_axil_bready,
    //read address channel
    input wire [ADDR_WIDTH+1:0] s_axil_araddr,
    input wire s_axil_arvalid,
    output wire s_axil_arready,
    input wire [2:0] s_axil_arprot,
    //read data channel
    output wire [DATA_WIDTH-1:0] s_axil_rdata,
    output wire [1:0] s_axil_rresp,
    output wire s_axil_rvalid,
    input wire s_axil_rready,

    //fpga clk
    output wire fpga_clk,

    //some configuration
    input wire rst_read, en_read, continous,    //cont=0-> single beat
    input wire [31:0] dec_rate,
    input wire [31:0] default_value,
    
    output wire finish_read,
    output wire [DATA_WIDTH-1:0] dout
);


wire [DATA_WIDTH-1:0] bram_data;
wire [ADDR_WIDTH-1:0] bram_addr;
wire bram_we;

axil_bram #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .INIT_FILE(INIT_FILE)
) axil_bram_inst (
    .axi_clock(axi_clock), 
    .rst(rst), 
    .s_axil_awaddr(s_axil_awaddr),
    .s_axil_awprot(s_axil_awprot),
    .s_axil_awvalid(s_axil_awvalid),
    .s_axil_awready(s_axil_awready),
    .s_axil_wdata(s_axil_wdata),
    .s_axil_wstrb(s_axil_wstrb),
    .s_axil_wvalid(s_axil_wvalid),
    .s_axil_wready(s_axil_wready),
    .s_axil_bresp(s_axil_bresp),
    .s_axil_bvalid(s_axil_bvalid),
    .s_axil_bready(s_axil_bready),
    .s_axil_araddr(s_axil_araddr),
    .s_axil_arvalid(s_axil_arvalid),
    .s_axil_arready(s_axil_arready),
    .s_axil_arprot(s_axil_arprot),
    .s_axil_rdata(s_axil_rdata),
    .s_axil_rresp(s_axil_rresp),
    .s_axil_rvalid(s_axil_rvalid),
    .s_axil_rready(s_axil_rready),
    //bram output
    .fpga_clk(axi_clock),
    .bram_din(),
    .bram_addr(bram_addr),
    .bram_we(bram_we),
    .bram_dout(bram_data)
);



read_bram #(
    .ADDR_WIDTH(ADDR_WIDTH), 
    .DATA_WIDTH(DATA_WIDTH)
) read_bram_inst (
    .clk(axi_clock),
    .rst(rst_read),
    //configure the read data rate
    .dec_rate(dec_rate),
    .finish(finish_read),
    .en(en_read),      //detects only at rising edge
    .continous(continous),
    //default value when the system is not reading
    .default_value(default_value),
    //
    .bram_addr(bram_addr),
    .bram_we(bram_we),
    .bram_data_i(bram_data),    //comes from the bram
    .bram_data_o(dout)    //
);



endmodule
