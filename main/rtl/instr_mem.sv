module instr_mem #(
    parameter ADDR_WIDTH = 12,
    parameter INSTR_WIDTH = 32
)(
    input  logic [ADDR_WIDTH-1:0] pc, // the Full-width 32 PC input here, but we use 8 only..?
    output logic [INSTR_WIDTH-1:0] instr
);

    logic [INSTR_WIDTH-1:0] rom [(2**ADDR_WIDTH)-1:0];

    assign instr = rom[pc[7:0]]; // Use only the 8 LSBs of the PC

    logic [ADDR_WIDTH-9:0] unused_pc = pc[31:8]; // the bits are unused since martin stated that we only need 8 bits?

    initial begin
        $readmemh("/Users/michaelli/Documents/GitHub/Lab4/main/rtl/program.hex", rom);
    end
endmodule
