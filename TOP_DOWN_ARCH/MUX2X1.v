`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Project: Bubble Sort
// Module Name:2x1 Multiplexer
//////////////////////////////////////////////////////////////////////////////////
module MUX2X1#(parameter data_in_width = 16)(a,b,sel,mux2x1_out);
input [data_in_width-1:0] a,b;
input sel;
output reg [data_in_width-1:0] mux2x1_out;

always@(a or b or sel) begin
	if (sel == 1)
		mux2x1_out <= a;
	else
		mux2x1_out <= b;
end

endmodule
