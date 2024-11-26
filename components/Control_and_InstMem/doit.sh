#!/bin/bash

rm -rf obj_dir
mkdir -p obj_dir
verilator --cc --trace -Wno-fatal \
    -Wno-UNUSEDSIGNAL \
    -Wno-CASEINCOMPLETE \
    top.sv \
    control_unit.sv \
    sign_extend.sv \
    instr_mem.sv \
    --exe top_tb.cpp

if [ $? -ne 0 ]; then
    echo "Verilator failed!"
    exit 1
fi
make -j -C obj_dir/ -f Vtop.mk Vtop

if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    exit 1
fi

obj_dir/Vtop

if [ $? -ne 0 ]; then
    echo "Simulation failed!"
    exit 1
fi

echo "Simulation completed successfully!"