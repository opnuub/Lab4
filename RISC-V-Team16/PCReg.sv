module PCReg #(
    DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  next_PC,
    input   logic                   clk,
    input   logic                   rst,
    output  logic [DATA_WIDTH-1:0]  Pci
);

    logic [31:0] sreg;

    always_ff @ (posedge clk, posedge rst)
        if (rst)
            sreg <= 32'0;
        else
            sreg <= next_PC;

    assign Pci = sreg;

endmodule
