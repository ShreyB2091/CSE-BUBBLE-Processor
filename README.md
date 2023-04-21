# CSE BUBBLE Processor

This is a processor made using Verilog HDL.

It was made as a part of a course project (CS253) - Computer Organization

A custom architecture set similar to MIPS was made. It consists of 3 memory modules, an ALU module and a CPU module.

It was made to perform Bubble Sort on a given a array stored in the data module. The machine code for the sorting algorithm is stored in the instructions memory module.

To run the processor, run ```iverilog -o cpu_tb.vvp cpu_tb.v``` to compile the program. Then run ```vvp cpu_tb.vvp``` to execute the program.
