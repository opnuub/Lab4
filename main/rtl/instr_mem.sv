// module to sign extend the immediate value of the instruction
module instr_mem #(
    parameter ADDR_WIDTH = 32,
    parameter INSTR_WIDTH = 32
)(
    input  logic [ADDR_WIDTH-1:0] pc,
    output logic [INSTR_WIDTH-1:0] instr
);

    logic [INSTR_WIDTH-1:0] rom [(2**ADDR_WIDTH)-1:0];
    
    assign instr = rom[pc];
    
    initial begin
        $readmemh("/home/fg723/Documents/iac/lab0-devtools/autumn/workspace/Lab4/main/rtl/program.hex", rom);
    end
endmodule
