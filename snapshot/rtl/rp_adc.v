//`default_nettype none


module rp_adc #(
    parameter ADC_BITWIDTH = 14
) (
    input wire adc_clk,
    input wire [ADC_BITWIDTH-1:0] adc0_in,
    input wire [ADC_BITWIDTH-1:0] adc1_in,

    output wire [ADC_BITWIDTH-1:0] adc0_out,
    output wire [ADC_BITWIDTH-1:0] adc1_out,
    
    output wire adc_csn
);
reg [ADC_BITWIDTH-1:0] adc0_r=0, adc1_r=0;

assign adc0_out = adc0_r;
assign adc1_out = adc1_r;

always@(posedge adc_clk)begin
    adc0_r <= adc0_in;
    adc1_r <= adc1_in;
end

assign adc_csn = 1'b1;
endmodule
