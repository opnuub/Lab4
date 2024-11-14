#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vtop* top = new Vtop;

    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("top.vcd");

    if (vbdOpen()!=1) return(-1);
    vbdHeader("top");
    vbdSetMode(1);
    // initialize simulation inputs
    top->clk = 0;
    top->rst = 0;
    top->Pc = 1000
    top->Pci = top->Pc;
    top->ImmOP = 1048;
    
    // run simulation for many clock cycles
    for (i = 0; i < 3000; i++) {

        // dump variables into VCD file and toggle clock
        for (tick = 0; tick < 2; tick++) {
            tfp->dump (2 * i + tick);
            top->clk = !top->clk;
            top->eval ();
        }

        // ++++ Send count value to Vbuddy
        vbdPlot(int (top->a0), 0, 255);
        vbdCycle(i);

        top->clk = vbdFlag();

        top->rst = (i < 2) | (i == 15);

        if (Verilated::gotFinish() ) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}
