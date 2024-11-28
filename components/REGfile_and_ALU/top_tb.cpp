#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"
#include <iostream>

#define MAX_SIM_CYC 100

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
    top->rs1 = 0;
    top->rs2 = 2;
    top->rd = 0;
    top->ImmOp = 10;
    top->ALUctrl = 0;
    top->ALUsrc = 0;

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
        if ((simcyc%2) == 0)
        {      
            top->RegWrite = 1;
        }
        else
        {   
            top->RegWrite = 0;
        }

        if(simcyc == 10){
            top->ALUctrl = 1;
        }

        if(simcyc == 12){
            top->ALUctrl = 2;
        }

        if(simcyc == 14){
            top->ALUctrl = 3;
        }

        if(simcyc == 16){
            top->ALUsrc = 1;
        }

        if(simcyc == 18){
            top->ImmOp = 1;
            top->ALUctrl = 1;
        }




        // Print the current PC value on every cycle
        std::cout << "Cycle " << simcyc << ": a0 = " << top->a0 << std::endl;

        // Check for simulation finish condition or key press (if used with Vbuddy)
        if (Verilated::gotFinish())
            break;
    }

    tfp->close();
    delete top;
    delete tfp;
    return 0;
}