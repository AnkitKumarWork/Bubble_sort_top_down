
`timescale 1 ns / 1 ps
module testbench;
reg clk;

reg [15:0]current_floor;
  reg [15:0] in1, in2, in3, in4, in5;
 wire [15:0] out1, out2, out3, out4, out5;
 wire [15:0] up_out1,up_out2, up_out3, up_out4, up_out5;
 wire [15:0] down_out1, down_out2, down_out3, down_out4, down_out5;
 wire  empthy_upward_reg;
  wire empthy_downward_reg;
  wire [15:0] nextfloor;
  wire up, down;
  sort my_sort (
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .in4(in4),
    .in5(in5),
    .out1(out1),
    .out2(out2),
    .out3(out3),
    .out4(out4),
    .out5(out5),
    .clk(clk),
    .up_out1(up_out1),
    .up_out2(up_out2),
    .up_out3(up_out3),
    .up_out4(up_out4),
    .up_out5(up_out5),
    .down_out1(down_out1),
    .down_out2(down_out2),
    .down_out3(down_out3),
    .down_out4(down_out4),
    .down_out5(down_out5),
    .current_floor(current_floor),
    .empthy_upward_reg(empthy_upward_reg),
    .empthy_downward_reg(empthy_downward_reg),
    .nextfloor(nextfloor),
    .up(up),
    .down(down)
    );
always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  always @(negedge clk)
  begin
    current_floor <= 5;
    in1 <= 2;
    in2 <= 1;
    in3 <= 0;
    in4 <= 4;
    in5 <= 3;
   current_floor <= #100 4;
end
  initial
  begin

$display("If simulation ends before the testbench"); $display("completes, use the menu option to run all."); #400; // allow it to run
$display("Simulation is over, check the waveforms."); $stop;
end
 
    endmodule