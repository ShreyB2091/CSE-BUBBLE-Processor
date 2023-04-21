// Shrey Bansal (210997)
// Narendra Singh (210649)

`include "alu.v"
`include "memory.v"

// Module for the Control Unit of the Processor
module cpu(clk);

    input clk;

    reg mode, writeEn;
    reg [4:0] funct, shamt, add1, add2, writeAdd, rs, rt, rd;
    reg [5:0] opcode;
    reg [15:0] pc, const, dataAddress;
    reg [25:0] jumpAddress;
    reg [31:0] s1, s2, dataInData, dataInReg;
    wire [15:0] pcNew;
    wire [31:0] dest, inst, dataOutData, dataOutReg1, dataOutReg2;

    instructions instruc(pc, inst);
    data dt(dataAddress, dataInData, dataOutData, mode);
    registers regs(add1, add2, writeAdd, writeEn, dataInReg, dataOutReg1, dataOutReg2);
    alu calc(opcode, funct, shamt, s1, s2, dest, pc, const, pcNew, jumpAddress);

    initial begin
        
        pc = 0;
        writeEn = 0;

    end

    always @(posedge clk) begin
        
        // inst will be fetched on pc change
        // The incoming instruction is parsed
        opcode = inst[31:26];
        rs = inst[25:21];
        rt = inst[20:16];
        rd = inst[15:11];
        shamt = inst[10:6];
        funct = inst[5:0];
        const = inst[15:0];
        jumpAddress = inst[25:0];

        // Fetching rs and rt from registers
        writeEn = 0;
        add1 = rs;
        add2 = rt;
        #10
        s1 = dataOutReg1;
        s2 = dataOutReg2;
        #10

        // send data to alu based on the opcode
        if(opcode == 0) begin
            
            writeEn = 1;
            writeAdd = rd;
            dataInReg = dest;

        end
        else if(opcode <= 4) begin

            writeEn = 1;
            writeAdd = rs;
            dataInReg = dest;

        end
        else if(opcode == 5) begin
            
            // lw
            mode = 0;
            dataAddress = s1 + const;
            #10
            writeEn = 1;
            writeAdd = rt;
            dataInReg = dataOutData;
            
        end
        else if(opcode == 6) begin
            
            // sw
            mode = 1;
            dataAddress = s1 + const;
            dataInData = s2;

        end
        else if(opcode > 12 && opcode < 16) begin
            
            jumpAddress = inst[25:0];

        end
        else if(opcode == 16) begin

            writeEn = 1;
            writeAdd = rt;
            dataInReg = dest;

        end
        #10

        if(opcode >= 7 && opcode <= 15) begin 

            if(pcNew != pc) pc = pcNew - 1;

        end
        pc = pc + 1;

    end

endmodule