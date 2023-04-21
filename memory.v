// Shrey Bansal (210997)
// Narendra Singh (210649)

// Module to store the Machine Code of the program
module instructions(pc, inst);

    input [15:0] pc;
    output reg [31:0] inst;

    reg [31:0] DF [65535:0];

    initial begin

        // main:
        DF[0] = {6'd5, 5'd28, 5'd19, 16'd0};                // s0 = &arr
        DF[1] = {6'd1, 5'd8, 5'd0, 16'd0};                  // t0 = 0
        DF[2] = {6'd1, 5'd9, 5'd0, 16'd0};                  // t1 = 0
        DF[3] = {6'd1, 5'd20, 5'd0, 16'd11};                // s1 = 11 = size of arr
        DF[4] = {6'd1, 5'd21, 5'd0, 16'd11};                // s2 = 11 = size of arr
        DF[5] = {6'd0, 5'd19, 5'd0, 5'd10, 5'd0, 6'd0};     // t2 = s0 = &arr
        DF[6] = {6'd0, 5'd19, 5'd0, 5'd11, 5'd0, 6'd0};     // t3 = s0 = &arr
        DF[7] = {6'd1, 5'd20, 5'd20, -16'sd1};              // s1 = s1 - 1
        // outer_loop:
        DF[8] = {6'd1, 5'd9, 5'd0, 16'd0};                  // t1 = 0
        DF[9] = {6'd1, 5'd21, 5'd21, -16'sd1};              // s2 = s2 - 1
        DF[10] = {6'd0, 5'd19, 5'd0, 5'd11, 5'd0, 6'd0};    // t3 = s0
        // inner_loop:
        DF[11] = {6'd5, 5'd11, 5'd22, 16'd0};               // s3 = Data[t3]
        DF[12] = {6'd1, 5'd11, 5'd11, 16'd1};               // t3 = t3 + 1
        DF[13] = {6'd5, 5'd11, 5'd23, 16'd0};               // s4 = Data[t3]
        DF[14] = {6'd1, 5'd9, 5'd9, 16'd1};                 // t1 = t1 + 1
        DF[15] = {6'd0, 5'd22, 5'd23, 5'd12, 5'd0, 6'd8};   // t4 = (s3 < s4)
        DF[16] = {6'd8, 5'd12, 5'd0, 16'd20};               // pc = 20 if t4 != 0
        // swap
        DF[17] = {6'd6, 5'd11, 5'd22, 16'd0};               // Data[t3] = s3
        DF[18] = {6'd6, 5'd11, 5'd23, -16'sd1};             // Data[t3 - 1] = s4
        DF[19] = {6'd5, 5'd11, 5'd23, 16'd0};               // s4 = Data[t3]
        // cond
        DF[20] = {6'd8, 5'd9, 5'd21, 16'd11};               // pc = 11 if t1 != s2
        DF[21] = {6'd1, 5'd8, 5'd8, 16'd1};                 // t0 = t0 + 1
        DF[22] = {6'd8, 5'd8, 5'd20, 16'd8};                // pc = 8 if t0 != s1

    end

    always @(*) begin
        
        inst = DF[pc];

    end

endmodule


// MOdule to store the data used in the program
module data(address, dataIn, dataOut, mode);

    input mode;
    input [31:0] dataIn;
    input [15:0] address;
    output reg [31:0] dataOut;

    reg [31:0] DF [65535:0];

    initial begin

        DF[0] = 32'd10;
        DF[1] = 32'd60;
        DF[2] = 32'd40;
        DF[3] = 32'd70;
        DF[4] = 32'd20;
        DF[5] = 32'd30;
        DF[6] = 32'd90;
        DF[7] = 32'd100;
        DF[8] = 32'd0;
        DF[9] = 32'd80;
        DF[10] = 32'd50;
        DF[100] = 32'd0;             // stores the address of arr[0]

        $monitor("%d %d %d %d %d %d %d %d %d %d %d", DF[0], DF[1], DF[2], DF[3], DF[4], DF[5], DF[6], DF[7], DF[8], DF[9], DF[10]);
        // Monitoring each element of the array

    end

    always @(*) begin
        
        if(mode == 0) dataOut = DF[address];
        else DF[address] = dataIn;

    end

endmodule


// Module to store the 30 registers used in the Processor
module registers(add1, add2, writeAdd, writeEn, dataIn, dataOut1, dataOut2);

    input writeEn;
    input [4:0] add1, add2, writeAdd;
    input [31:0] dataIn;
    output reg [31:0] dataOut1, dataOut2;

    reg [31:0] DF [29:0];

    initial begin
        
        for(integer i = 0; i < 30; i = i + 1) begin
            
            DF[i] = 32'd0;

        end

        DF[28] = 32'd100;        // the location in memory storing the address of arr

    end

    always @(*) begin
        
        if(writeEn == 0) begin

            // Read Mode
            dataOut1 = DF[add1];
            dataOut2 = DF[add2];

        end 
        else DF[writeAdd] = dataIn;  // Write Mode

    end

endmodule