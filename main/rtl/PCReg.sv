module PCReg #(
    DATA_WIDTH = 12
) (
    input   logic [DATA_WIDTH-1:0]  next_PC,
    input   logic                   clk,
    input   logic                   rst,
    output  logic [DATA_WIDTH-1:0]  PC
);

    always_ff @ (posedge clk)
        if (rst)
            PC <= 0;
        else
            PC <= next_PC;

endmodule
