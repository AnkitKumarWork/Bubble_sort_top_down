module ALU #(parameter data_in_width = 16)(
    input [data_in_width-1:0] in_1, in_2,
    input [1:0] ALU_sel,
    output reg [data_in_width-1:0] ALU_out,
    output reg in_1_lt_in_2, in_1_eq_in_2, in_1_gt_in_2
);
    // Local parameters for ALU operations
    localparam ADD = 2'b00,
               SUB = 2'b01,
               ADD_1 = 2'b10,
               COMPARE = 2'b11;

    always @(*) begin
        // Initialize all outputs to avoid latches
        ALU_out = 'b0;
        in_1_lt_in_2 = 'b0;
        in_1_eq_in_2 = 'b0;
        in_1_gt_in_2 = 'b0;

        case (ALU_sel)
            ADD: 
                ALU_out = in_1 + in_2;
            SUB: 
                ALU_out = in_1 - in_2;
            ADD_1: 
                ALU_out = in_1 + 1;
            COMPARE: begin
                if (in_1 > in_2) begin
                    in_1_gt_in_2 = 'b1;
                    ALU_out = 'b0;
                    end
                    
                else if (in_1 < in_2) begin
                    in_1_lt_in_2 = 'b1;
                    ALU_out = 'b0;
                    end
                else 
                    begin
                    in_1_eq_in_2 = 'b1;
                    ALU_out = 'b0;
                    end
            end
            default: 
                ALU_out = 'b0; // Default operation
        endcase
    end
endmodule
