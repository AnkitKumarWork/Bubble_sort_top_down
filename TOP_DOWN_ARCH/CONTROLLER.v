`timescale 1ns / 1ps

module CONTROLLER #(parameter data_in_width = 16, N = 4)(
    input clk, rst,
    input start, // Signal to start the operation
    input in_1_eq_in_2, in_1_gt_in_2, in_1_lt_in_2, eoc_out, // Comparison signals from ALU
    output reg ld_a, ld_b, ld_i, ld_j, ld_k, ld_n_1, 
    output reg sel_m3, sel_m6, sel_m5, sel_m7, sel_m8,
    output reg [1:0] sel_m1, sel_m2, sel_m4,
    output reg [1:0] ALU_sel,
    output reg RW_MEM, mem_en,
    output reg MEM_WRITE_FLAG,
    output reg clear_eoc, preset_eoc,
    output reg done, // Signal to indicate operation completion
    output reg[3:0] ps, ns
);


localparam s0 = 4'd0, s1 = 4'd1, s2 = 4'd2, s3 = 4'd3,
          s4 = 4'd4, s5 = 4'd5, s6 = 4'd6, s7 = 4'd7,
          s8 = 4'd8, s9 = 4'd9, s10 = 4'd10, s11 = 4'd11,
          s12 = 4'd12;

    // Sequential logic: State transitions
    always @(posedge clk or posedge rst) begin
        if (rst)
            ps <= s0;
        else
            ps <= ns;
    end

always@(*)begin
    case(ps)
        s0: begin
            ns = (start) ? s1 : s0;
        end
        s1: begin
            ns = s2;
        end
        s2: begin  
            ns = (in_1_gt_in_2) ? s3 : s12;
        end
        s3: begin
            ns = s4;
        end
        s4: begin
            ns = (in_1_gt_in_2) ? s5 : s11;
        end
        s5: begin
            ns = s6;
        end
        s6: begin
            ns = s7;
        end
        s7: begin
            ns= (in_1_gt_in_2)? s8 :s10;
        end
        s8: begin
            ns = s9;
        end
        s9: begin
            ns = s10;
        end
        s10: begin
            ns = s4;
        end
        s11: begin
            ns = s2;
        end
        s12: begin
            ns = (eoc_out==1)?s0:s12;
        end
        default: ns = s0;
        endcase
    end
    // Combinational logic: State transitions and control signals
    always @(*) begin
        // Default control signal values
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
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b00;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
        MEM_WRITE_FLAG = 0;
        // Next state logic
        case (ps)
        s0: begin
                ld_a = 0;
                ld_b = 0;
                ld_i = 0;
                ld_j = 0;
                ld_k = 0;
                ld_n_1 = 0;
                sel_m3 = 0;
                sel_m6 = 0;
                sel_m5 = 0;
                sel_m7 = 1;
                sel_m8 = 1;
                sel_m1 = 2'b00;
                sel_m2 = 2'b11;
                sel_m4 = 2'b11;
                ALU_sel = 2'b00;
                RW_MEM = 1;
                mem_en = 1;
                clear_eoc = 0;
                preset_eoc = 0;
                done = 0;
                MEM_WRITE_FLAG = 1;
            end

        s1: begin
      
        ld_a = 0;
        ld_b = 0;
        ld_i = 0;
        ld_j = 1;
        ld_k = 1;
        ld_n_1 = 0;
        sel_m3 = 0;
        sel_m6 = 1;
        sel_m5 = 0;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b11;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 1;
        preset_eoc = 0;
        done = 0;
            end

            s2: begin
           
        ld_a = 0;
        ld_b = 0;
        ld_i = 0;
        ld_j = 0;
        ld_k = 0;
        ld_n_1 = 1;
        sel_m3 = 0;
        sel_m6 = 0;
        sel_m5 = 0;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b01;
        sel_m2 = 2'b00;
        sel_m4 = 2'b11;
        ALU_sel = 2'b11;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s3: begin
            
        ld_a = 0;
        ld_b = 0;
        ld_i = 1;
        ld_j = 0;
        ld_k = 0;
        ld_n_1 = 0;
        sel_m3 = 0;
        sel_m6 = 0;
        sel_m5 = 1;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b00;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s4:
             begin      
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
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b00;
        ALU_sel = 2'b11;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s5: begin
            
        ld_a = 1;
        ld_b = 0;
        ld_i = 0;
        ld_j = 0;
        ld_k = 1;
        ld_n_1 = 0;
        sel_m3 = 0;
        sel_m6 = 0;
        sel_m5 = 0;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b00;
        sel_m2 = 2'b10;
        sel_m4 = 2'b11;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 1;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s6: begin
            
        ld_a = 0;
        ld_b = 1;
        ld_i = 0;
        ld_j = 0;
        ld_k = 0;
        ld_n_1 = 0;
        sel_m3 = 0;
        sel_m6 = 0;
        sel_m5 = 0;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b10;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 1;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s7: begin
                
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
        sel_m1 = 2'b10;
        sel_m2 = 2'b01;
        sel_m4 = 2'b10;
        ALU_sel = 2'b11;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s8: begin
            
        ld_a = 0;
        ld_b = 0;
        ld_i = 0;
        ld_j = 0;
        ld_k = 0;
        ld_n_1 = 0;
        sel_m3 = 1;
        sel_m6 = 0;
        sel_m5 = 0;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b00;
        ALU_sel = 2'b00;
        RW_MEM = 1;
        mem_en = 1;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s9: begin
            
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
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b10;
        ALU_sel = 2'b00;
        RW_MEM = 1;
        mem_en = 1;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s10: begin
            
        ld_a = 0;
        ld_b = 0;
        ld_i = 1;
        ld_j = 0;
        ld_k = 0;
        ld_n_1 = 0;
        sel_m3 = 0;
        sel_m6 = 0;
        sel_m5 = 1;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b00;
        sel_m2 = 2'b10;
        sel_m4 = 2'b10;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s11: begin
            
        ld_a = 0;
        ld_b = 0;
        ld_i = 0;
        ld_j = 1;
        ld_k = 0;
        ld_n_1 = 0;
        sel_m3 = 0;
        sel_m6 = 1;
        sel_m5 = 0;
        sel_m7 = 0;
        sel_m8 = 0;
        sel_m1 = 2'b01;
        sel_m2 = 2'b10;
        sel_m4 = 2'b11;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end

            s12: begin
                
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
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b00;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 1;
        clear_eoc = 0;
        preset_eoc = 1;
        done = 1;
            end

            default: begin
                
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
        sel_m1 = 2'b00;
        sel_m2 = 2'b00;
        sel_m4 = 2'b00;
        ALU_sel = 2'b00;
        RW_MEM = 0;
        mem_en = 0;
        clear_eoc = 0;
        preset_eoc = 0;
        done = 0;
            end
     endcase
end
endmodule
