#include "base_testbench.h"
Vdut *top;
VerilatedVcdC *tfp;
unsigned int ticks = 0;


// Testbench class
class ALUTestbench : public ::testing::Test {
protected:
    virtual void SetUp() {
        top = new Vdut;
        tfp = new VerilatedVcdC;

        Verilated::traceEverOn(true);
        top->trace(tfp, 99);
        tfp->open("waveform.vcd");
    }

    virtual void TearDown() {
        top->final();
        tfp->close();

        delete top;
        delete tfp;
    }

    void initializeInputs() {
        top->SrcA = 0;
        top->SrcB = 0;
        top->ALUControl = 0;
    }
};

// Test for addition
TEST_F(ALUTestbench, AdditionWorks) {
    top->SrcA = 10;
    top->SrcB = 20;
    top->ALUControl = 0b0000; // ALUControl for addition

    top->eval();

    EXPECT_EQ(top->ALUResult, 30);
    EXPECT_EQ(top->zero, 0);
}

// Test for subtraction
TEST_F(ALUTestbench, SubtractionWorks) {
    top->SrcA = 20;
    top->SrcB = 10;
    top->ALUControl = 0b1000; // ALUControl for subtraction

    top->eval();

    EXPECT_EQ(top->ALUResult, 10);
    EXPECT_EQ(top->zero, 0);
}

// Test for AND operation
TEST_F(ALUTestbench, AndOperationWorks) {
    top->SrcA = 0b1010;
    top->SrcB = 0b1100;
    top->ALUControl = 0b0010; // ALUControl for AND

    top->eval();

    EXPECT_EQ(top->ALUResult, 0b1000);
}

// Test for SLT (Set Less Than)
TEST_F(ALUTestbench, SltWorks) {
    top->SrcA = 5;
    top->SrcB = 10;
    top->ALUControl = 0b0101; // ALUControl for SLT

    top->eval();

    EXPECT_EQ(top->ALUResult, 1); // Should be 1 because SrcA < SrcB
    EXPECT_EQ(top->zero, 0);
}

// Test for zero flag
TEST_F(ALUTestbench, ZeroFlagWorks) {
    top->SrcA = 10;
    top->SrcB = 10;
    top->ALUControl = 0b1000; // Subtraction that results in zero

    top->eval();

    EXPECT_EQ(top->ALUResult, 0);
    EXPECT_EQ(top->zero, 1); // Zero flag should be set
}

// Test for unsigned comparison
TEST_F(ALUTestbench, UnsignedComparisonWorks) {
    top->SrcA = 1;
    top->SrcB = 2;
    top->ALUControl = 0b0111; // ALUControl for SLTU

    top->eval();

    EXPECT_EQ(top->ALUResult, 1); // Should output 1 as SrcA < SrcB
    EXPECT_EQ(top->unsignedsmaller, 1); // Confirm the unsignedsmaller flag
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}