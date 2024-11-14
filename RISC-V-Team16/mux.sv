module mux #(
    DATA_WIDTH = 32,
    OFFSET = 4
) (
    input   logic [DATA_WIDTH-1:0]  PC,
    input   logic [DATA_WIDTH-1:0]  ImmOp,
    input   logic                   PCsrc,
    output  logic [DATA_WIDTH-1:0]  next_PC
);
    
    logic [DATA_WIDTH-1:0] branch_PC;
    logic [DATA_WIDTH-1:0] inc_PC;

    always_comb begin
    branch_PC = PC + OFFSET;
    inc_PC = PC + ImmOp;
    end

    assign next_PC = PCsrc ? inc_PC : branch_PC;

endmodule
