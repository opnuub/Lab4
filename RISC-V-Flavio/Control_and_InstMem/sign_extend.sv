/* verilator lint_off UNUSEDSIGNAL */
module sign_extend (
    input  logic [31:0] instruction,  // 完整的指令
    input  logic [6:0]  opcode,       // 操作码
    output logic [31:0] imm_ext       // 扩展后的立即数
);
/* verilator lint_on UNUSEDSIGNAL */

    always_comb begin
        imm_ext = 32'b0; // 默认值

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
