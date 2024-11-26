// module to sign extend the immediate value of the instruction
module control_unit (
    input  logic [6:0] opcode,     
    input  logic [2:0] funct3,     
    output logic       reg_write,  
    output logic       alu_src,     
    output logic       branch,      
    output logic [2:0] alu_op,
    output logic       immSrc,
);

    assign immSrc = 1'b1;
    always_comb begin
        case(opcode)
            7'b0010011: begin // I-type (addi)
                reg_write = 1'b1;
                alu_src   = 1'b1;
                branch    = 1'b0;
                alu_op    = 3'b000;
            end
            
            7'b1100011: begin // B-type (bne)
                reg_write = 1'b0;
                alu_src   = 1'b0;
                branch    = 1'b1;
                alu_op    = 3'b001;
            end

            default: begin
                reg_write = 1'b0;
                alu_src   = 1'b0;
                branch    = 1'b0;
                alu_op    = 3'b000;
            end
        endcase
    end
endmodule
