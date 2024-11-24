module top #(
    parameter DATA_WIDTH = 32,
    parameter OFFSET = 4
) (
    input   logic                  clk,
    input   logic                  rst,
    input   logic                  PCsrc,
    input   logic [DATA_WIDTH-1:0] ImmOp,
    output  logic [DATA_WIDTH-1:0] a0    
);

    logic [DATA_WIDTH-1:0] next_PC;
    logic [DATA_WIDTH-1:0] PC;
    logic [DATA_WIDTH-1:0] inc_PC;
    logic [DATA_WIDTH-1:0] branch_PC;

    assign a0 = PC;

    PCReg PCReg (
        .clk (clk),      
        .rst (rst),    
        .PC (PC),       
        .next_PC (next_PC)     	
    );

    always_comb begin
    branch_PC = PC + OFFSET;
    inc_PC = PC + ImmOp;
    end

    mux2 mux (
        .inc_PC (inc_PC),     
        .branch_PC (branch_PC),      
        .PCsrc (PCsrc),       
        .next_PC (next_PC)     	
    );

endmodule
