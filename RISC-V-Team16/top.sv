module top #(
    parameter DATA_WIDTH = 32
) (
    input   logic                  clk,
    input   logic                  rst,
    input   logic                  PCsrc,
    input   logic [DATA_WIDTH-1:0] ImmOp,
    output  logic [DATA_WIDTH-1:0] a0    
);

    logic [DATA_WIDTH-1:0] next_PC;
    logic [DATA_WIDTH-1:0] PC;

    assign a0 = PC;

    PCReg PCReg (
        .clk (clk),      
        .rst (rst),    
        .PC (PC),       
        .next_PC (next_PC)     	
    );

    mux mux (
        .PC (PC),     
        .ImmOp (ImmOp),      
        .PCsrc (PCsrc),       
        .next_PC (next_PC)     	
    );

endmodule
