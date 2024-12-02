module PCReg #(
    OFFSET = 4,
    DATA_WIDTH = 16
) (
    input   logic [DATA_WIDTH-1:0]  next_PC,
    input   logic                   clk,
    input   logic                   rst,  
    input   logic [DATA_WIDTH-1:0]  immOp,
    output  logic [DATA_WIDTH-1:0]  branchPC,          
    output  logic [DATA_WIDTH-1:0]  pc,
    output  logic [DATA_WIDTH-1:0]  incPC
);

    always_comb begin

        incPC = pc + OFFSET;
        branchPC = pc + immOp[15:0];

    end

    always_ff @ (posedge clk)begin
        if (rst)
            pc <= 0;
    else
            pc <= next_PC;
   
    end


endmodule
