`timescale 1ns/1ps
module Reg_k#(parameter data_in_width = 16)(
    input clk, 
    input rst,
    input [data_in_width-1:0]k,
    input ld_k,
    output [data_in_width-1:0] tout_k
);
reg [data_in_width-1:0] temp_k;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_k <= 0;
    else 
        if(ld_k)
        temp_k <= k;

end
assign tout_k = temp_k;
endmodule