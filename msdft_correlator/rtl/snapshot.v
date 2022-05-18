//`default_nettype none
//`include "s_axil_ram_rd.v"

module snapshot #(
    parameter WORD_SIZE = 32,
    parameter ADDR_SIZE = 11
) (
    input wire fpga_clk,
    input wire [WORD_SIZE-1:0] din,
    input wire valid,
    input wire rst,
    input wire trigger,

    //axil signals
    input wire axi_clock,
    input wire [ADDR_SIZE+1:0] S_AXI_AWADDR,
    input wire [2:0] S_AXI_AWPROT,
    input wire S_AXI_AWVALID,
    output wire S_AXI_AWREADY,
    //write data channel
    input wire [WORD_SIZE-1:0] S_AXI_WDATA,
    input wire [WORD_SIZE/8-1:0] S_AXI_WSTRB,
    input wire S_AXI_WVALID,
    output wire S_AXI_WREADY,
    //write response channel
    output wire [1:0] S_AXI_BRESP,
    output wire S_AXI_BVALID,
    input wire S_AXI_BREADY,
    //read address channel 
    input wire [ADDR_SIZE+1:0] S_AXI_ARADDR,
    input wire S_AXI_ARVALID,
    output wire S_AXI_ARREADY,
    input wire [2:0] S_AXI_ARPROT,
    //read data channel
    output wire [WORD_SIZE-1:0] S_AXI_RDATA,
    output wire [1:0] S_AXI_RRESP,
    output wire S_AXI_RVALID,
    input wire S_AXI_RREADY,

    //configuration signals 
    input wire [31:0] configuration,
    input wire [31:0] offset
);

/*configuration: 
    bit0: rising edge enable new capture
    bit1: ignore external trigger
    bit2: ignore external we
    bit3: capture data continously
*/
reg [31:0] config_reg=0, offset_reg;
always@(posedge axi_clock)begin
    config_reg <= configuration;
    offset_reg <= offset;
end

//syncronize configuration
reg [31:0] config_reg_r=0, config_reg_rr=0, config_reg_rrr=0;
reg [31:0] offset_r=0, offset_rr=0;
always@(posedge fpga_clk)begin
    config_reg_r <= config_reg;
    config_reg_rr <= config_reg_r;
    config_reg_rrr <= config_reg_rr;
    offset_r <= offset_reg;
    offset_rr <= offset_r;
end


reg trigger_r=0, trig_valid=0;
always@(posedge fpga_clk)begin
    trigger_r <= trigger;
end



reg [ADDR_SIZE-1:0] addr_fpga=0;
reg en_save=0, we=0, arm=0;
reg [31:0] data=0;

always@(posedge fpga_clk)begin
    data <= din;
    if(config_reg_rrr[3])begin
        addr_fpga <= addr_fpga+1;
        en_save <= 1;
        we <= 1;
    end
    else begin
        if(en_save & (valid| config_reg_rr[2]))begin
            if(&addr_fpga)begin
                addr_fpga <=0;
                en_save <=0;
                we <=0;
                arm <=0;
            end
            else begin
                addr_fpga <=addr_fpga+1;
                we <=1;
                arm<=0;
            end
        end
        if((config_reg_rr[0] & ~config_reg_rrr[0]))begin
            //arm the snapshot 
            en_save <=0;
            addr_fpga <=0;
            we <=0;
            arm <=1;
        end
        else if(((~trigger_r &trigger)| config_reg_rr[1])&arm)begin
            en_save <=1;
            we <=1;
            addr_fpga <=0;
            arm <=0;
        end
    end
end






s_axil_ram_rd #(
    .DATA_WIDTH(WORD_SIZE),
    .ADDR_WIDTH(ADDR_SIZE)
) axil_ram_inst  (
    .axi_clock(axi_clock),
    .rst(1'b0),
    .s_axil_araddr(S_AXI_ARADDR),
    .s_axil_arvalid(S_AXI_ARVALID),
    .s_axil_arready(S_AXI_ARREADY),
    .s_axil_arprot(S_AXI_ARPROT),
    .s_axil_rdata(S_AXI_RDATA),
    .s_axil_rresp(S_AXI_RRESP),
    .s_axil_rvalid(S_AXI_RVALID),
    .s_axil_rready(S_AXI_RREADY),
    .fpga_clk(fpga_clk),
    .bram_addr(addr_fpga),
    .we(we),
    .din(data),
    .dout()
);

// take care if some one try to write into the module
assign S_AXI_WREADY = 0;
assign S_AXI_AWREADY = 0;
assign S_AXI_BVALID = 1;


endmodule
