module instr_mem #(
    parameter ADDR_WIDTH = 16,
    parameter INSTR_WIDTH = 32
)(
    input  logic [ADDR_WIDTH-1:0] pc,
    output logic [INSTR_WIDTH-1:0] instr
);

    logic [7:0] rom [2**ADDR_WIDTH-1:0]; // 0xBFC00000 - 0xBFC00FFF

    always_comb begin
        instr = {rom[pc + 3], rom[pc + 2], rom[pc + 1], rom[pc]};
    end

    initial begin
        $readmemh("../rtl/program.hex", rom);
    end

endmodule
