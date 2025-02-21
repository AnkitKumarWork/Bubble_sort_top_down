`timescale 1ns / 1ps

module MUX4X1#(parameter data_in_width = 16)(
  input wire [data_in_width-1:0] d0, 
  input wire [data_in_width-1:0] d1,  
  input wire [data_in_width-1:0]d2,  
  input wire [data_in_width-1:0] d3,        // 4 data inputs (d[3:0])
  input wire [1:0] sel,     // 2-bit select line
  output reg [data_in_width-1:0] mux4x1_out              // Output of the multiplexer
);

  always @(*) begin
    case (sel)
      2'b00: mux4x1_out = d0;      // Select input d[0]
      2'b01: mux4x1_out = d1;      // Select input d[1]
      2'b10: mux4x1_out = d2;      // Select input d[2]
      2'b11: mux4x1_out = d3;      // Select input d[3]
      default: mux4x1_out = 1'b0;    // Default case (optional, tmux4x1_outpicallmux4x1_out for safetmux4x1_out)
    endcase
  end

endmodule
