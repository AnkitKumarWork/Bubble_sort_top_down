`timescale 1ns / 1ps

module TOP_MODULE #(parameter data_in_width = 16, N = 4)(
    input clk, rst,
    input start,
    input [data_in_width-1:0] data_in,
    input [N-1:0] addr_ptr,
    output wire done,
    output [data_in_width-1:0] data_out,
    output in_1_lt_in_2,
    output [3:0] ps,ns
);

    // Internal connections
    wire ld_a, ld_b, ld_i, ld_j, ld_k, ld_n_1;
    wire sel_m3, sel_m6, sel_m5, sel_m7, sel_m8;
    wire [1:0] sel_m1, sel_m2, sel_m4;
    wire [1:0] ALU_sel;
    wire RW_MEM, mem_en, MEM_WRITE_FLAG;
    wire clear_eoc, preset_eoc;
    wire eoc_out;
    wire in_1_eq_in_2, in_1_gt_in_2; //in_1_lt_in_2;
  //  wire [data_in_width-1:0] data_out;

    // Instantiate CONTROLLER
    CONTROLLER #(data_in_width, N) controller (
        .clk(clk), 
        .rst(rst), 
        .start(start), 
        .in_1_eq_in_2(in_1_eq_in_2), 
        .in_1_gt_in_2(in_1_gt_in_2), 
        .in_1_lt_in_2(in_1_lt_in_2), 
        .eoc_out(eoc_out),
        .ld_a(ld_a), 
        .ld_b(ld_b), 
        .ld_i(ld_i), 
        .ld_j(ld_j), 
        .ld_k(ld_k), 
        .ld_n_1(ld_n_1), 
        .sel_m3(sel_m3), 
        .sel_m6(sel_m6), 
        .sel_m5(sel_m5), 
        .sel_m7(sel_m7), 
        .sel_m8(sel_m8), 
        .sel_m1(sel_m1), 
        .sel_m2(sel_m2), 
        .sel_m4(sel_m4), 
        .ALU_sel(ALU_sel), 
        .RW_MEM(RW_MEM), 
        .mem_en(mem_en), 
        .MEM_WRITE_FLAG(MEM_WRITE_FLAG), 
        .clear_eoc(clear_eoc), 
        .preset_eoc(preset_eoc), 
        .done(done),
        .ps(ps),
        .ns(ns)
    );

    // Instantiate DATAPATH
    DATAPATH #(data_in_width, N) datapath (
        .clk(clk), 
        .rst(rst), 
        .data_in(data_in), 
        .addr_ptr(addr_ptr), 
        //.n_1(4'b10),
        .RW_MEM(RW_MEM), 
        .clear_eoc(clear_eoc), 
        .preset_eoc(preset_eoc), 
        .mem_en(mem_en), 
        .ld_a(ld_a), 
        .ld_b(ld_b), 
        .ld_i(ld_i), 
        .ld_j(ld_j), 
        .ld_k(ld_k), 
        .ld_n_1(ld_n_1), 
        .sel_m3(sel_m3), 
        .sel_m6(sel_m6), 
        .sel_m5(sel_m5), 
        .sel_m7(sel_m7), 
        .sel_m8(sel_m8), 
        .sel_m1(sel_m1), 
        .sel_m2(sel_m2), 
        .sel_m4(sel_m4), 
        .ALU_sel(ALU_sel), 
        .eoc_out(eoc_out), 
        .in_1_eq_in_2(in_1_eq_in_2), 
        .in_1_gt_in_2(in_1_gt_in_2), 
        .in_1_lt_in_2(in_1_lt_in_2), 
        .data_out(data_out)
    );

endmodule
