//top sv file
module top (
    input  logic        clk,         
    input  logic        rst,         
    input  logic [7:0]  pc,          
    output logic [31:0] instruction, 
    output logic        reg_write,   
    output logic        alu_src,     
    output logic        branch,     
    output logic [2:0]  alu_op,      
    output logic [31:0] imm_ext     
);


    logic [6:0] opcode;
    logic [2:0] funct3;
    

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    

    instr_mem #(
        .ADDR_WIDTH(8),
        .INSTR_WIDTH(32)
    ) imem (
        .pc(pc),
        .instr(instruction)
    );
    

    control_unit ctrl_unit (
        .opcode(opcode),
        .funct3(funct3),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .branch(branch),
        .alu_op(alu_op)
    );
    

    sign_extend sign_ext (
        .instruction(instruction),  
        .opcode(opcode),
        .imm_ext(imm_ext)
    );


    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin

        end
    end

endmodule
