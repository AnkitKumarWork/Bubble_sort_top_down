`timescale 1ns / 1ps

module DATAPATH #(parameter data_in_width = 16, N = 16)(
    input clk, rst,
    input [data_in_width-1:0] data_in,
    input [N-1:0] addr_ptr,
    input RW_MEM, clear_eoc, preset_eoc, mem_en,
    input ld_a, ld_b, ld_i, ld_j, ld_k, ld_n_1, 
    input sel_m3, sel_m6, sel_m5, sel_m7, sel_m8,
    input [1:0] sel_m1, sel_m2, sel_m4,
    input [1:0] ALU_sel, 
    output wire eoc_out, in_1_eq_in_2, in_1_gt_in_2, in_1_lt_in_2,
    output wire [data_in_width-1:0] data_out,
    output wire [N-1:0] tout_n_1,
    output wire [N-1:0] mux2x1_out_m8,
    output wire [data_in_width-1:0] tout_a,
    output wire [N-1:0] tout_j,
    output wire [N-1:0] tout_i,
       output wire [data_in_width-1:0] tout_b,
    output wire [data_in_width-1:0] ALU_out,
       output wire [data_in_width-1:0]  tout_k, //tout_n_1;tout_a, ALU_out, tout_b,  tout_i, tout_j,
    output wire [data_in_width-1:0] mux2x1_out_m5, mux2x1_out_m6, mux2x1_out_m3,
    output wire [data_in_width-1:0] mux4x1_out_m1, mux4x1_out_m2, mux4x1_out_m4,
    output wire [data_in_width-1:0] mux2x1_out_m7
  
);
localparam n_1 = 16'b0000000000001111;
    // Internal wires for interconnections


    // Registers
    Reg_a ra (.clk(clk), .rst(rst), .a(data_out), .ld_a(ld_a), .tout_a(tout_a));
    Reg_b rb (.clk(clk), .rst(rst), .b(data_out), .ld_b(ld_b), .tout_b(tout_b));
    Reg_i ri (.clk(clk), .rst(rst), .i(mux2x1_out_m5), .ld_i(ld_i), .tout_i(tout_i));
    Reg_j rj (.clk(clk), .rst(rst), .j(mux2x1_out_m6), .ld_j(ld_j), .tout_j(tout_j));
    Reg_k rk (.clk(clk), .rst(rst), .k(ALU_out), .ld_k(ld_k), .tout_k(tout_k));
    Reg_n_1 rn_1 (.clk(clk), .rst(rst), .n_1(n_1), .ld_n_1(ld_n_1), .tout_n_1(tout_n_1));
    Reg_eoc reoc (.clk(clk), .rst(rst), .clear_eoc(clear_eoc), .preset_eoc(preset_eoc), .eoc_out(eoc_out));

    // Multiplexers
    MUX2X1 m5 (.a({data_in_width{1'b0}}), .b(ALU_out), .sel(sel_m5), .mux2x1_out(mux2x1_out_m5));
    MUX2X1 m6 (.a({data_in_width{1'b0}}), .b(ALU_out), .sel(sel_m6), .mux2x1_out(mux2x1_out_m6));
    MUX2X1 m7 (.a(data_in), .b(mux2x1_out_m3), .sel(sel_m7), .mux2x1_out(mux2x1_out_m7));
    MUX2X1 m8 (.a(addr_ptr), .b(mux4x1_out_m4), .sel(sel_m8), .mux2x1_out(mux2x1_out_m8));
    MUX2X1 m3 (.a(tout_a), .b(tout_b), .sel(sel_m3), .mux2x1_out(mux2x1_out_m3));
    MUX4X1 m1 (.d0(tout_i), .d1(tout_j), .d2(tout_a), .d3(tout_k), .sel(sel_m1), .mux4x1_out(mux4x1_out_m1));
    MUX4X1 m2 (.d0(tout_n_1), .d1(tout_b), .d2({data_in_width{1'b1}}), .d3({data_in_width{1'b0}}), .sel(sel_m2), .mux4x1_out(mux4x1_out_m2));
    MUX4X1 m4 (.d0(tout_i), .d1(tout_j), .d2(tout_k), .d3({data_in_width{1'b0}}), .sel(sel_m4), .mux4x1_out(mux4x1_out_m4));

    // ALU
    ALU A1 (
        .in_1(mux4x1_out_m1), 
        .in_2(mux4x1_out_m2), 
        .ALU_sel(ALU_sel), 
        .ALU_out(ALU_out), 
        .in_1_eq_in_2(in_1_eq_in_2), 
        .in_1_gt_in_2(in_1_gt_in_2), 
        .in_1_lt_in_2(in_1_lt_in_2)
    );

    // RAM Memory
    RAM_MEM mem (
        .clk(clk),
        .data_in_mem(mux2x1_out_m7), 
        .addr_ptr(mux2x1_out_m8), 
        .en(mem_en), 
        .RW_MEM(RW_MEM), 
        .data_out(data_out)
    );

endmodule
