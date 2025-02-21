`timescale 1ns/1ps
module Reg_i#(parameter data_in_width = 16)(
    input clk, 
    input rst,
    input [data_in_width-1:0]i,
    input ld_i,
    output [data_in_width-1:0] tout_i
);
reg [data_in_width-1:0] temp_i;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_i <= 0;
    else 
        if(ld_i)
        temp_i <= i;

end
assign tout_i = temp_i;
endmodule