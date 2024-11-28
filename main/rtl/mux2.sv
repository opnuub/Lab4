module mux2 #(
    parameter ADDR_WIDTH = 16
) (
    input   logic [ADDR_WIDTH-1:0]  branch_PC,
    input   logic [ADDR_WIDTH-1:0]  inc_PC,
    input   logic                   PCsrc,
    output  logic [ADDR_WIDTH-1:0]  next_PC
);


    assign next_PC = PCsrc ? branch_PC : inc_PC;

endmodule
