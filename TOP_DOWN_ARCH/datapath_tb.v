`timescale 1ns / 1ps

module DATAPATH_TB;

// Parameters
parameter data_in_width = 16;
parameter N = 16;

// Inputs
reg clk, rst;
reg [data_in_width-1:0] data_in;
reg [N-1:0] addr_ptr;
reg RW_MEM, clear_eoc, preset_eoc, mem_en;
reg ld_a, ld_b, ld_i, ld_j, ld_k, ld_n_1;
reg sel_m3, sel_m6, sel_m5, sel_m7, sel_m8;
reg [1:0] sel_m1, sel_m2, sel_m4;
reg [1:0] ALU_sel;

// Outputs
wire eoc_out, in_1_eq_in_2, in_1_gt_in_2, in_1_lt_in_2;
wire [data_in_width-1:0] data_out;
wire [N-1:0] tout_n_1;
wire [N-1:0] tout_i;
wire [N-1:0] tout_j;
 wire [N-1:0] mux2x1_out_m8;
 wire [data_in_width-1:0] tout_a;
  wire [data_in_width-1:0] tout_b;
 wire  [data_in_width-1:0] ALU_out;
 wire [data_in_width-1:0]  tout_k; //tout_n_1;tout_a, ALU_out, tout_b,  tout_i, tout_j,
 wire [data_in_width-1:0] mux2x1_out_m5, mux2x1_out_m6, mux2x1_out_m3;
  wire [data_in_width-1:0] mux4x1_out_m1, mux4x1_out_m2, mux4x1_out_m4;
  wire [data_in_width-1:0] mux2x1_out_m7;
integer i;
// Instantiate the DUT
DATAPATH #(.data_in_width(data_in_width), .N(N)) uut (
    .clk(clk), 
    .rst(rst), 
    .data_in(data_in), 
    .addr_ptr(addr_ptr), 
    //.n_1(n_1),
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
    .data_out(data_out),
    .tout_n_1(tout_n_1),
    .tout_i(tout_i),
    .tout_j(tout_j),
    .mux2x1_out_m8(mux2x1_out_m8),
    .tout_a(tout_a),
    .tout_b(tout_b),
    .ALU_out(ALU_out),
    .tout_k(tout_k),
    .mux2x1_out_m5( mux2x1_out_m5),
    .mux2x1_out_m6(mux2x1_out_m6),
    .mux2x1_out_m3(mux2x1_out_m3),
    .mux4x1_out_m1( mux4x1_out_m1),
    .mux4x1_out_m2(mux4x1_out_m2),
    . mux4x1_out_m4( mux4x1_out_m4),
    .mux2x1_out_m7(mux2x1_out_m7)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Initialization
    clk = 0;
    rst = 1;
    data_in = 0;
    addr_ptr = 0;
   // n_1 = 0;
    RW_MEM = 0;
    clear_eoc = 0;
    preset_eoc = 0;
    mem_en = 0;
    ld_a = 0;
    ld_b = 0;
    ld_i = 0;
    ld_j = 0;
    ld_k = 0;
    ld_n_1 = 0;
    sel_m3 = 0;
    sel_m6 = 0;
    sel_m5 = 0;
    sel_m7 = 0;
    sel_m8 = 0;
    sel_m1 = 0;
    sel_m2 = 0;
    sel_m4 = 0;
    ALU_sel = 0;
    //ALU_out = 0;

    // Reset deassertion
    
    #100;
    rst = 0;

    // Memory write operation
    mem_en = 1;       // Enable memory
    RW_MEM = 1;       // Set memory to write mode
    sel_m7 = 1;       // Select data_in for writing to memory
    sel_m8 = 1;       // Select addr_ptr for writing address

    // Write random data to consecutive memory addresses
    for ( i = 0; i < 8; i = i + 1) begin
        data_in = i+2; // Generate random 16-bit data
        addr_ptr = i;             // Set address pointer
        #100;                      // Wait for one clock cycle
    end
     

     #10 ;
     ALU_sel = 2'b11;
     // idle state s0
     clear_eoc = 1;
     ld_j = 1;
     ld_n_1 = 1;
     sel_m6 = 0;

#20;
      ld_j = 0;
        ld_i = 0;
    //s1 compare j < n-1
    sel_m1 = 2'b01;
    sel_m2 = 2'b00;
    ALU_sel = 2'b11;
  
  

#20
    //s2 i=0 
    sel_m5 = 1;
    ld_i = 1;

    
    
 #20;
    //s3 compare i < n-1
    sel_m1 = 2'b00;
    sel_m2 = 2'b00;
    ALU_sel = 2'b11;
    ld_j = 0;
    ld_i = 0;
 #20;
 
  //  s4memory write w.r.t i , a register is to be loaded by i=0 location's data
   sel_m2 = 2'b11;
    ld_j = 0;
    ld_i = 0;
     RW_MEM = 0;
     sel_m4 = 2'b00;
     sel_m8 = 0;
     ld_a = 1;
    // k = i+1
    sel_m1 = 2'b00;
    sel_m2 = 2'b10;
    ALU_sel = 2'b00;
    ld_k = 1;
 #20;
    //s5 s4memory write w.r.t k = i+1  , b register is to be loaded by k location's data
    ld_a = 0;
    RW_MEM = 0;
    sel_m4 = 2'b10;
    ld_b = 1;
    
 
    
    #200;
    $finish();
end
endmodule

