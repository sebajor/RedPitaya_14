`default_nettype none

module read_bram #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,
    
    //configure the read data rate
    input wire [31:0] dec_rate,
    output wire finish,
    input wire continous,
    input wire en,      //detects only at rising edge
    //default value when the system is not reading
    input wire [31:0] default_value,
    //
    output wire [ADDR_WIDTH-1:0] bram_addr,
    output wire bram_we,
    input wire [DATA_WIDTH-1:0] bram_data_i,    //comes from the bram
    output wire [DATA_WIDTH-1:0] bram_data_o    //
);

reg en_r =0;
wire start = en & ~en_r;    //rising edge 
reg finish_r = 0;

reg reading=0;
always@(posedge clk)begin
    en_r <= en;
    if(start)
        reading <=1;
    else if(rst | finish)
        reading <= 0;
end


reg [31:0] dec_count=0;
reg [ADDR_WIDTH-1:0] bram_count=0;
always@(posedge clk)begin
    if(start | rst)begin
        dec_count <= 0;
        bram_count <=0;
    end
    else if((reading & ~finish) | continous)begin
        if(dec_count == dec_rate)begin
            dec_count <=0;
            bram_count <= bram_count+1;
        end
        else
            dec_count <= dec_count+1;
    end
end

assign finish = &bram_count;

assign bram_we =0;
assign bram_addr = bram_count;

reg [DATA_WIDTH-1:0] dat_o=0;
always@(posedge clk)begin
    if(reading | continous)
        dat_o <= bram_data_i;
    else
        dat_o <= default_value; 
end

assign bram_data_o = dat_o;

endmodule
