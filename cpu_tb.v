// Shrey Bansal (210997)
// Narendra Singh (210649)

`include "cpu.v"

module cpu_tb();

    reg clk;

    initial begin
        clk = 0;
    end
    
    cpu uut(clk);

    always #50 clk = ~clk;

    initial begin
        
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);

        #500000  // Time given to complete the execution of the program

        $finish;
    end

endmodule