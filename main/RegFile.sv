module RegFile #(
    parameter DATA_WIDTH = 32,
    parameter REG_DATA_WIDTH = 5
) (
    input   logic [REG_DATA_WIDTH-1:0]  rs1,
    input   logic [REG_DATA_WIDTH-1:0]  rs2,
    input   logic [REG_DATA_WIDTH-1:0]  rd,
    input   logic [DATA_WIDTH-1:0]      ALUout,
    input   logic                       clk,
    input   logic                       RegWrite,
    output  logic [DATA_WIDTH-1:0]      a0,
    output  logic [DATA_WIDTH-1:0]      ALUop1,
    output  logic [DATA_WIDTH-1:0]      regOp2
);

    logic [DATA_WIDTH-1:0] rom_array [2**REG_DATA_WIDTH-1:0];

    // Initialize rom_array in simulation only
    initial begin
        $display("Loading rom.1");
        $readmemh("reg.mem", rom_array);
    end

    // Write and Read Logic
    always_ff @(posedge clk) begin
        if (RegWrite) begin
            rom_array[rd] <= ALUout;  // Write to register
        end 
        else begin
            ALUop1 <= rom_array[rs1]; // Read first operand
            regOp2 <= rom_array[rs2]; // Read second operand
        end
    end

    // Continuous assignment for a0
    assign a0 = rom_array[rd];

endmodule
