#!/bin/bash

# 清理之前的构建
rm -rf obj_dir

# 创建目标目录
mkdir -p obj_dir

# 运行 Verilator
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

# 编译
make -j -C obj_dir/ -f Vtop.mk Vtop

if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    exit 1
fi

# 运行仿真
obj_dir/Vtop

if [ $? -ne 0 ]; then
    echo "Simulation failed!"
    exit 1
fi

echo "Simulation completed successfully!"