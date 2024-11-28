module ALU #(
    parameter DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  ALUop1,
    input   logic [DATA_WIDTH-1:0]  ALUop2,
    input   logic [4:0]             ALUctrl,
    output  logic [DATA_WIDTH-1:0]  ALUout,
    output  logic                   EQ
);

    logic [DATA_WIDTH-1:0] addi;
    logic [DATA_WIDTH-1:0] sub;
    logic [DATA_WIDTH-1:0] andA;
    logic [DATA_WIDTH-1:0] orA; 
    logic [DATA_WIDTH-1:0] bne;
    
always_comb begin
    addi = ALUop1 + ALUop2;
    sub = ALUop1 - ALUop2;
    andA = ALUop1 & ALUop2;
    orA = ALUop1 | ALUop2;

    EQ = (sub == 0);


    case (ALUctrl)
        0: ALUout = addi;
        1: ALUout = sub;
        2: ALUout = andA;
        3: ALUout = orA;
        4: ALUout = 0;
        default: ALUout = '0;
    endcase

end



endmodule
