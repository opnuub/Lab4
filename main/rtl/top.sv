module top #(
    parameter DATA_WIDTH = 32,
    parameter INSTR_WIDTH = 32,
    parameter ADDR_WIDTH = 12,
    parameter REG_DATA_WIDTH = 5,
    parameter OFFSET = 4
) (
    input   logic                   clk,
    input   logic                   rst,
    output  logic [DATA_WIDTH-1:0]  a0
);

    logic [ADDR_WIDTH-1:0]  pc;
    logic [INSTR_WIDTH-1:0] instr;
    logic [INSTR_WIDTH-1:0] immOp;
    logic                   regWrite;
    logic [2:0]             aluCtrl;
    logic                   aluSrc;
    logic                   immSrc;
    logic                   pcSrc;
    logic [DATA_WIDTH-1:0]  aluOp1;
    logic [DATA_WIDTH-1:0]  aluOp2;
    logic [DATA_WIDTH-1:0]  regOp2;
    logic [DATA_WIDTH-1:0]  aluOut;
    logic                   eq;
    logic [ADDR_WIDTH-1:0]  nextPC;
    logic [ADDR_WIDTH-1:0]  branchPC;
    logic [ADDR_WIDTH-1:0]  incPC;
    
    instr_mem #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .INSTR_WIDTH(INSTR_WIDTH)
    ) imem (
        .pc (pc),
        .instr (instr)
    );

    sign_extend sign_ext (
        .instruction(instr),
        .immSrc(immSrc),
        .imm_ext(immOp)
    );

    control_unit ctrl_unit (
        .opcode (instr[6:0]),
        .funct3 (instr[14:12]),
        .reg_write (regWrite),
        .eq (eq),
        .alu_src (aluSrc),
        .branch (pcSrc),
        .alu_op (aluCtrl),
        .immSrc (immSrc),
        .PCsrc(pcSrc)
    );

    RegFile #(
        .DATA_WIDTH(DATA_WIDTH),
        .REG_DATA_WIDTH(REG_DATA_WIDTH)
    ) RegFile (
        .clk (clk),
        .rs1 (instr[19:15]),
        .rs2 (instr[24:20]),
        .rd (instr[11:7]),
        .RegWrite (regWrite),
        .ALUout (aluOut),
        .a0 (a0),
        .ALUop1 (aluOp1),
        .regOp2 (regOp2)
    );

    mux regFileMux (
        .ImmOp (immOp),
        .regOp2 (regOp2),
        .ALUsrc (aluSrc),
        .ALUop2 (aluOp2)
    );

    ALU regFileALU (
        .ALUop1 (aluOp1),
        .ALUop2 (aluOp2),
        .ALUctrl (aluCtrl),
        .ALUout (aluOut),
        .EQ (eq)
    );

    PCReg PCReg (
        .clk (clk),
        .rst (rst),
        .PC (pc),
        .next_PC (nextPC)
    );

    mux2 pcMux (
        .inc_PC (incPC),
        .branch_PC (branchPC),
        .PCsrc (pcSrc),
        .next_PC (nextPC)
    );

    always_comb begin
        branchPC = pc + OFFSET;
        incPC = pc + immOp;
    end

endmodule
