`default_nettype none
`include "read_bram_control.v"


module read_bram_control_tb #(
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

    //some configuration
    input wire rst_read, en_read,
    input wire continous,
    input wire [31:0] dec_rate,
    input wire [31:0] default_value,
    
    output wire finish_read,
    output wire [DATA_WIDTH-1:0] dout
);



read_bram_control #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .INIT_FILE(INIT_FILE)
) read_bram_control_inst (
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
    .rst_read(rst_read),
    .en_read(en_read),
    .continous(continous),
    .dec_rate(dec_rate),
    .default_value(default_value),
    .finish_read(finish_read),
    .dout(dout)
);

endmodule
