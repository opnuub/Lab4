module control_unit (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic       eq,
    output logic       reg_write,
    output logic       alu_src,
    output logic       branch,
    output logic [2:0] alu_op,
    output logic       immSrc,
    output logic       PCsrc
);

    assign immSrc = 1'b1;

    always_comb begin
        reg_write = 1'b0;
        alu_src   = 1'b0;
        branch    = 1'b0;
        PCsrc     = 1'b0;
        alu_op    = 3'b000;

        case (opcode)
            7'b0010011: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                branch    = 1'b0;
                alu_op    = 3'b000;
            end
            
            7'b1100011: begin
                reg_write = 1'b0;
                alu_src   = 1'b0;
                branch    = 1'b1;
                alu_op    = 3'b001;

                case (funct3)
                    3'b001: PCsrc = ~eq;
                    3'b000: PCsrc = eq;
                    default: PCsrc = 1'b0;
                endcase
            end

            default: begin
                reg_write = 1'b0;
                alu_src   = 1'b0;
                branch    = 1'b0;
                PCsrc     = 1'b0;
                alu_op    = 3'b000;
            end
        endcase
    end

endmodule
