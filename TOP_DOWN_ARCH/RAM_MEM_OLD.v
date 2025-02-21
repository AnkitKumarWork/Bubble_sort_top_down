`timescale 1ns / 1ps

module RAM_MEM #(parameter data_in_width = 16, N = 16)(
    input clk,          // Clock input
    input rst,        // Asynchronous active-low reset
    input [data_in_width-1:0] data_in_mem, // Data input
    input [N-1:0] addr_ptr, // Address input
    input en,           // Enable signal
    input RW_MEM,           // Read/Write control: 1 for write, 0 for read
    output reg [data_in_width-1:0] data_out // Data output
);
 localparam mem_address = 2**(4);
    reg [data_in_width-1:0] mem [mem_address-1:0]; // Memory array with 64 locations of 8 bits each
    integer i;
    
    always @(posedge clk ) begin //
       if (rst) begin
            // Reset all memory locations to 0 on asynchronous reset
         
            for (i = 0; i < mem_address; i = i + 1) begin
                mem[i] <= 0;
            end
            data_out <= 0; // Reset data output
        end else if (en) begin
            if (RW_MEM) begin
                mem[addr_ptr] <= data_in_mem; // Write operation
            end else begin
                data_out <= mem[addr_ptr]; // Read operation
            end
        end
    end

endmodule

