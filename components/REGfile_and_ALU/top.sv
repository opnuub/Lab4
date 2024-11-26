module top #(
    parameter DATA_WIDTH = 32,
    parameter REG_DATA_WIDTH = 5
) (
    input   logic                      clk,
    input   logic                      ALUsrc,
    input   logic [REG_DATA_WIDTH-1:0] ALUctrl,
    input   logic [DATA_WIDTH-1:0]     ImmOp,
    input   logic [REG_DATA_WIDTH-1:0] rs1,
    input   logic [REG_DATA_WIDTH-1:0] rs2,
    input   logic [REG_DATA_WIDTH-1:0] rd,
    input   logic                      RegWrite,
    output  logic [DATA_WIDTH-1:0]     a0    
);

    logic [DATA_WIDTH-1:0] regOp2;
    logic [DATA_WIDTH-1:0] ALUop1;
    logic [DATA_WIDTH-1:0] ALUop2;
    logic [DATA_WIDTH-1:0] ALUout;
    logic [REG_DATA_WIDTH-1:0] EQ;


    RegFile RegFile (
        .clk (clk),      
        .rs1 (rs1),    
        .rs2 (rs2),
        .rd (rd),       
        .ALUout (ALUout),
        .RegWrite (RegWrite),      
        .a0 (a0),    
        .ALUop1 (ALUop1),       
        .regOp2 (regOp2)
    );

    mux mux (
        .ImmOp (ImmOp),     
        .regOp2 (regOp2),      
        .ALUsrc (ALUsrc),       
        .ALUop2 (ALUop2)     	
    );

    ALU ALU (
        .ALUop1 (ALUop1),     
        .ALUop2 (ALUop2),      
        .ALUctrl (ALUctrl),       
        .ALUout (ALUout),
        .EQ (EQ)     	
    );

endmodule
