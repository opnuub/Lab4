module top (
    input  logic        clk,         // 时钟信号
    input  logic        rst,         // 复位信号
    input  logic [7:0]  pc,          // 程序计数器
    output logic [31:0] instruction, // 指令
    output logic        reg_write,   // 寄存器写使能
    output logic        alu_src,     // ALU输入选择
    output logic        branch,      // 分支控制
    output logic [2:0]  alu_op,      // ALU操作码
    output logic [31:0] imm_ext      // 扩展后的立即数
);

    // 内部信号
    logic [6:0] opcode;
    logic [2:0] funct3;
    
    // 直接从指令中提取字段，不需要额外的寄存器
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    
    // 实例化指令存储器
    instr_mem #(
        .ADDR_WIDTH(8),
        .INSTR_WIDTH(32)
    ) imem (
        .pc(pc),
        .instr(instruction)
    );
    
    // 实例化控制单元
    control_unit ctrl_unit (
        .opcode(opcode),
        .funct3(funct3),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .branch(branch),
        .alu_op(alu_op)
    );
    
    // 实例化符号扩展单元
    sign_extend sign_ext (
        .instruction(instruction),  // 直接使用instruction
        .opcode(opcode),
        .imm_ext(imm_ext)
    );

    // 使用时钟和复位信号的同步逻辑
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // 在复位时可以添加一些初始化逻辑
        end
    end

endmodule
