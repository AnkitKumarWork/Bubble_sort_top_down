`timescale 1ns/1ps
module Reg_j#(parameter data_in_width = 16)(
    input clk, 
    input rst,
    input [data_in_width-1:0]j,
    input ld_j,
    output [data_in_width-1:0] tout_j
);
reg [data_in_width-1:0] temp_j;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_j <= 0;
    else 
        if(ld_j)
        temp_j <= j;

end
assign tout_j = temp_j;
endmodule