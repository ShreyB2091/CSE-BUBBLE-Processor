// Shrey Bansal (210997)
// Narendra Singh (210649)

`include "alu.v"

module alu_tb();

    reg [4:0] funct, shamt;
    reg [5:0] opcode;
    reg [15:0] pc, const;
    reg [25:0] jumpAddress;
    reg [31:0] s1, s2;
    wire [15:0] pcNew;
    wire [31:0] dest;

    alu uut(opcode, funct, shamt, s1, s2, dest, pc, const, pcNew, jumpAddress);

    initial begin
        
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);
        $monitor("op: %d\tfunct: %d\tshamt: %d\ts1: %d\ts2: %d\tdest: %d\tpc: %d\tconst: %d\tpcNew: %d\tjump address: %d\n", opcode, funct, shamt, s1, s2, dest, pc, const, pcNew, jumpAddress);
        
        pc = 0;

        opcode = 6'd0;
        funct = 5'd0;
        shamt = 5'd0;
        s1 = 32'd123;
        s2 = 32'd23;
        #100

        opcode = 6'd0;
        funct = 5'd1;
        shamt = 5'd0;
        s1 = 32'd123;
        s2 = 32'd23;
        #100

        opcode = 6'd0;
        funct = 5'd6;
        shamt = 5'd1;
        s1 = 32'd123;
        s2 = 32'd23;
        #100

        pc = pc + 1;
        opcode = 6'd7;
        s1 = 32'd23;
        s2 = 32'd23;
        const = 16'd1000;
        #100

        pc = pc + 1;
        opcode = 6'd7;
        s1 = 32'd243;
        s2 = 32'd23;
        const = 16'd1000;
        #100

        pc = pc + 1;
        opcode = 6'd13;
        jumpAddress = 26'd512;
        #100

        pc = pc + 1;
        opcode = 6'd1;
        s1 = 32'd100;
        s2 = 32'd200;
        const = 16'd512;
        #100

        $finish;
    end

endmodule