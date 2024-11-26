module mux #(
    parameter DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  branch_PC,
    input   logic [DATA_WIDTH-1:0]  inc_PC,
    input   logic                   PCsrc,
    output  logic [DATA_WIDTH-1:0]  next_PC
);


    assign next_PC = PCsrc ? inc_PC : branch_PC;

endmodule
