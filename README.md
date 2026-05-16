## Overview
A fully functional 5-stage pipelined RISC-V processor 
implemented from scratch in Verilog HDL, with a dedicated 
Hazard Detection Unit featuring data forwarding.

## Pipeline Architecture
Fetch → Decode → Execute → Memory → Write-Back

## Features
- MEM→EX and WB→EX data forwarding
- Hazard Detection Unit (correctly ignores x0 register)
- Separate Control Unit + ALU Decoder
- Register File with synchronous write
- Sign Extender (supports I, S, B, J type instructions)
- Instruction & Data Memory
- Active-low synchronous reset
- Verified with GTKWave simulation

## Project Structure
├── Fetch_Cycle.v
├── Decode_Cycle.v
├── Execute_Cycle.v
├── Memory_Cycle.v
├── Write_back_Cycle.v
├── Hazard_Unit.v
├── Control_Unit_top.v
├── ALU.v
├── ALU_decoder.v
├── main_decoder.v
├── Registerfile.v
├── Sign_Extend.v
├── instruction_memory.v
├── Data_memory.v
├── Mux.v
├── Mux_2.v
├── PC_Counter.v
├── PC_Adder.v
├── pipeline_Top.v
└── single_cycle_top_tb.v

## Simulation Results
[Add your GTKWave screenshots here]

## Known Limitations
- Load-use stall not yet implemented
- Branch flush not yet implemented
- Compiler/programmer must insert NOPs for load-use hazards

## Tools Used
- Verilog HDL
- GTKWave

## Future Work
- Add load-use stall logic
- Add branch flush signals
- Implement on FPGA (Basys3/Nexys)
- Extend to full RV32I instruction set

