module sign_extend (
    input  logic [31:0] instruction,  
    input  logic        immSrc,       
    output logic [31:0] imm_ext       
);

    always_comb begin
        if (immSrc)
            imm_ext = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        else
            imm_ext = {{20{instruction[31]}}, instruction[31:20]};
    end
endmodule
