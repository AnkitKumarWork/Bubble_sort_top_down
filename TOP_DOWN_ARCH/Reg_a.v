`timescale 1ns/1ps
module Reg_a#(parameter data_in_width = 16)(
    input clk, 
    input rst,
    input [data_in_width-1:0]a,
    input ld_a,
    output [data_in_width-1:0] tout_a
);
reg [data_in_width-1:0] temp_a;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_a <= 0;
    else 
        if(ld_a)
        temp_a <= a;
    
end
assign tout_a = temp_a;
endmodule