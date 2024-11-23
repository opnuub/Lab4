/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off CASEINCOMPLETE */
module control_unit (
    input  logic [6:0] opcode,     // 指令操作码
    input  logic [2:0] funct3,     // 功能码
    output logic       reg_write,   // 寄存器写使能
    output logic       alu_src,     // ALU输入选择
    output logic       branch,      // 分支指令标志
    output logic [2:0] alu_op      // ALU操作选择
);
/* verilator lint_on UNUSEDSIGNAL */
/* verilator lint_on CASEINCOMPLETE */

    always_comb begin
        // 默认值设置
        reg_write = 1'b0;
        alu_src   = 1'b0;
        branch    = 1'b0;
        alu_op    = 3'b000;

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
