// Shrey Bansal (210997)
// Narendra Singh (210649)

`include "memory.v"

module memory_tb();

    reg mode;
    reg [4:0] address;
    reg [31:0] dataIn;
    wire [31:0] inst;
    wire [31:0] dataOut;

    // instructions uut(pc, inst);
    // data dt(address, dataIn, dataOut, mode);
    registers dt(address, dataIn, dataOut, mode);

    initial begin
        
        $dumpfile("memory.vcd");
        $dumpvars(0, memory_tb);
        $monitor("mode: %b\tdataIn: %d\tdataOut: %d\taddress: %d", mode, dataIn, dataOut, address);

        // pc = 16'd0;
        mode = 1;
        address = 5'd0;
        dataIn = 32'd3216;
        #5

        // pc = 16'd1;
        mode = 0;
        address = 5'd0;
        #5

        // pc = 16'd2;
        mode = 0;
        address = 5'd1;
        #5

        $finish;
    end

endmodule
