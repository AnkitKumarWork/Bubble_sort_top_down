`timescale 1ns/1ps
module Reg_b#(parameter data_in_width = 16)(
    input clk, 
    input rst,
    input [data_in_width-1:0]b,
    input ld_b,
    output [data_in_width-1:0] tout_b
);
reg [data_in_width-1:0] temp_b;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_b <= 0;
    else 
        if(ld_b)
        temp_b <= b;

end
assign tout_b = temp_b;
endmodule