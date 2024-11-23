#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"
// #include "vbuddy.h"
void printControlSignals(Vtop* top) {
    printf("Control Signals:\n");
    printf("- RegWrite: %d\n", top->reg_write);
    printf("- ALUSrc:   %d\n", top->alu_src);
    printf("- Branch:   %d\n", top->branch);
    printf("- ALUOp:    %d\n", top->alu_op);
    printf("-------------------\n");
}

void decodeInstruction(uint32_t instr) {
    uint32_t opcode = instr & 0x7F;
    printf("Instruction: 0x%08x\n", instr);
    switch(opcode) {
        case 0x13: // addi
            printf("Type: ADDI\n");
            break;
        case 0x63: // bne
            printf("Type: BNE\n");
            break;
        default:
            printf("Type: Unknown\n");
    }
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    

    Vtop* top = new Vtop;
    

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("waveform.vcd");
    

    if (vbdOpen()!=1) return(-1);
    vbdHeader("Instruction Memory Test");

    int simcyc;
    

    for (simcyc=0; simcyc<10; simcyc++) {

        top->pc = simcyc % 3;  
        top->eval();
        
        // Print the current cycle and instruction information
        printf("\n=== Simulation Cycle %d ===\n", simcyc);
        printf("PC: %d\n", top->pc);
        decodeInstruction(top->instruction);

        printControlSignals(top);
        

        vbdHex(1, (int)((top->instruction >> 24) & 0xFF));
        vbdHex(2, (int)((top->instruction >> 16) & 0xFF));
        vbdHex(3, (int)((top->instruction >> 8) & 0xFF));
        vbdHex(4, (int)(top->instruction & 0xFF));
        

        tfp->dump(simcyc);
        vbdCycle(simcyc);
        

        if (Verilated::gotFinish() || vbdGetkey()=='q') 
            break;
    }
    

    vbdClose();
    tfp->close();
    delete top;
    delete tfp;
    
    return 0;
}