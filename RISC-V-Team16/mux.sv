module mux #(
    DATA_WIDTH = 32,
    OFFSET = 4
) (
    input   logic [DATA_WIDTH-1:0]  Pc,
    input   logic [DATA_WIDTH-1:0]  ImmOP,
    input   logic                   PCsrc,
    output  logic [DATA_WIDTH-1:0]  next_PC
);
    
    logic [31:0] in0;

    logic [31:0] in1;

    always_comb begin
    in0 = Pc + OFFSET;
    in1 = Pc + ImmOP;
    end

    assign next_PC = PCsrc ? in1 : in0;

endmodule
