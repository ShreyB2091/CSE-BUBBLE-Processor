// Shrey Bansal (210997)
// Narendra Singh (210649)

// Module to perform the arithmetic and logical operations
module alu(opcode, funct, shamt, s1, s2, dest, pc, const, pcNew, jumpAddress);

    input [4:0] funct, shamt;
    input [5:0] opcode;
    input [15:0] pc, const;
    input [25:0] jumpAddress;
    input [31:0] s1, s2;
    output reg [15:0] pcNew;
    output reg [31:0] dest;

    always @(*) begin
        
        if(opcode == 0) begin
            if(funct == 0) dest = s1 + s2;
            else if(funct == 1) dest = s1 - s2;
            else if(funct == 2) dest = s1 + s2;
            else if(funct == 3) dest = s1 - s2;
            else if(funct == 4) dest = s1 & s2;
            else if(funct == 5) dest = s1 | s2;
            else if(funct == 6) dest = s2 << shamt;
            else if(funct == 7) dest = s2 >> shamt;
            else if(funct == 8) dest = (s1 < s2 ? 32'd1 : 32'd0);
        end
        else if(opcode == 1) begin
            dest = s2 + {16'd0, const};                   // Will be stored in s1 register
            dest = {16'd0, dest[15:0]};
        end
        else if(opcode == 2) dest = s2 + {16'd0, const};  // Will be stored in s1 register
        else if(opcode == 3) dest = s2 & {16'd0, const};  // Will be stored in s1 register
        else if(opcode == 4) dest = s2 | {16'd0, const};  // Will be stored in s1 register
        else if(opcode == 7) pcNew = (s1 == s2 ? const : pc);
        else if(opcode == 8) pcNew = (s1 != s2 ? const : pc);
        else if(opcode == 9) pcNew = (s1 > s2 ? const : pc);
        else if(opcode == 10) pcNew = (s1 >= s2 ? const : pc);
        else if(opcode == 11) pcNew = (s1 < s2 ? const : pc);
        else if(opcode == 12) pcNew = (s1 <= s2 ? const : pc);
        else if(opcode == 13) pcNew = jumpAddress;
        else if(opcode == 14) pcNew = jumpAddress;
        else if(opcode == 15) pcNew = jumpAddress;
        else if(opcode == 16) dest = (s1 < {16'd0, const} ? 32'd1 : 32'd0);  // Will be stored in s2 register

    end

endmodule