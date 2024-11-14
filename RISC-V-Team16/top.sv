module top #(
    DATA_WIDTH = 32
) (
    input   logic clk,
    input   logic rst,
    input   logic [DATA_WIDTH-1:0] Pc,
    input   logic [DATA_WIDTH-1:0] ImmOP,
    output  logic [DATA_WIDTH-1:0] a0    
);

    logic [DATA_WIDTH-1:0] next_PC;
    logic  PCsrc;
    logic [DATA_WIDTH-1:0] Pci;

    assign a0 = Pc;

PCReg PCReg (
  .clk (clk),      
  .rst (rst),    
  .Pci (Pci),       
  .next_PC (next_PC)     	
  );

mux mux (
  .Pc (Pc),     
  .ImmOP (ImmOP),      
  .PCsrc (PCsrc),       
  .next_PC (next_PC)     	
  );


endmodule
