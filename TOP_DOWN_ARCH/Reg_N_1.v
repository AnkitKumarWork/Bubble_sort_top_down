`timescale 1ns/1ps
module Reg_n_1#(parameter data_in_width = 16, N=16)(
    input clk, 
    input rst,
    input [N-1:0] n_1,
    input ld_n_1,
    output [N-1:0] tout_n_1
);
reg [data_in_width-1:0] temp_n_1;
//localparam n_1 = N-1;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_n_1 <= 0;
    else 
        if(ld_n_1)
        temp_n_1 <= n_1;

end
assign tout_n_1 = temp_n_1;
endmodule