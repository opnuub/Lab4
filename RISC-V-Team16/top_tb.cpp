#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"
#include <iostream>

#define MAX_SIM_CYC 20

int main(int argc, char **argv, char **env)
{
    int simcyc; // simulation clock count
    int tick;   // each clk cycle has two ticks for two edges

    Verilated::commandArgs(argc, argv);

    Vtop *top = new Vtop;

    VerilatedVcdC *tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    top->trace(tfp, 99);
    tfp->open("waveform.vcd");

    top->clk = 0;
    top->rst = 1;
    top->PCsrc = 0;
    top->ImmOp = 0;

    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++)
    {
        // Toggle clock for two ticks per cycle (rising and falling edges)
        for (tick = 0; tick < 2; tick++)
        {
            tfp->dump(2 * simcyc + tick);
            top->clk = !top->clk;
            top->eval();
        }

        // Control logic for reset and PC branching
        if (simcyc < 1)
        {
            top->rst = 1; // Apply reset in the first cycle
        }
        else
        {
            top->rst = 0;
            top->PCsrc = (simcyc % 4 == 0) ? 1 : 0; // Branch every 4 cycles
            top->ImmOp = (top->PCsrc) ? 16 : 0;     // Set immediate operand for branching
        }

        // Print the current PC value on every cycle
        std::cout << "Cycle " << simcyc << ": PC = " << top->a0 << std::endl;

        // Check for simulation finish condition or key press (if used with Vbuddy)
        if (Verilated::gotFinish())
            break;
    }

    tfp->close();
    delete top;
    delete tfp;
    return 0;
}