
//module to sign extend the immediate value of the instruction
module sign_extend (
    input  logic [31:0] instruction,  
    input  logic [6:0]  opcode,       
    output logic [31:0] imm_ext       
);

    always_comb begin
        imm_ext = 32'b0; 

        case(opcode)
            7'b0010011: begin // I-type (addi)
                imm_ext = {{20{instruction[31]}}, instruction[31:20]};
            end
            
            7'b1100011: begin // B-type (bne)
                imm_ext = {{19{instruction[31]}}, instruction[31],
                          instruction[7], instruction[30:25],
                          instruction[11:8], 1'b0};
            end
            
            default: begin
                imm_ext = 32'b0;
            end
        endcase
    end
endmodule
