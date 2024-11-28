module instr_mem #(
    parameter ADDR_WIDTH = 16,
    parameter INSTR_WIDTH = 32
)(
    input  logic [ADDR_WIDTH-1:0] pc, // the Full-width 32 PC input here, but we use 8 only..?
    output logic [INSTR_WIDTH-1:0] instr
);

    logic [INSTR_WIDTH-1:0] rom [(2**ADDR_WIDTH)-1:0];

    assign instr = rom[pc]; // Use only the 8 LSBs of the PC

    initial begin
        $readmemh("/home/kali/Lab4/main/rtl/program.hex", rom);
    end
endmodule
