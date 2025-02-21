`timescale 1ns/1ps
module Reg_eoc#(parameter data_in_width = 1)(
    input clk, 
    input rst,
    input clear_eoc,
    input preset_eoc,
    output eoc_out
);
reg temp_eoc;
always@(posedge clk or posedge rst)
begin
    if (rst)
        temp_eoc <= 0;
    else 
        if(clear_eoc) 
            temp_eoc <=0;
        else if(preset_eoc)
            temp_eoc <= 1;

end
assign eoc_out= temp_eoc;
endmodule