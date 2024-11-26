module PCReg #(
    DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  next_PC,
    input   logic                   clk,
    input   logic                   rst,
    output  logic [DATA_WIDTH-1:0]  PC
);

    always_ff @ (posedge clk, posedge rst)
        if (rst)
            PC <= 32'b0;
        else
            PC <= next_PC;

endmodule
