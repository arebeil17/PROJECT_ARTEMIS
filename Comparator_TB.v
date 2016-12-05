`timescale 1ns / 1ps

module Comparatortb();
    reg [31:0] InA, InB;
    reg [4:0] s;
    reg Clock
    
    wire [31:0] Result;
    
    Comparator C(Clock,InA,InB,Result,Control);
    
    initial begin
        // BEQ Out = 0
        InA <= 1;
        InB <= 10;
        Control <= 000;
        #10
        // BEQ Out = 1
        InA <= 1;
        InB <= 1;
        Control <= 000;
        #10
        // BGEZ Out = 1
        InA <= 10;
        InB <= 0;
        Control <= 001;
        #10
        // BGEZ Out = 0
     	InA <= -10;
        InB <= 0;
        Control <= 001;
        #10
        // BGTZ Out = 1
        InA <= 1;
        InB <= 0;
        Control <= 010
        #10
        // BGTZ Out = 0
        InA <= -1;
        InB <= 0;
        Control <= 010;
        #10
        // BLEZ Out = 0
        InA <= 1;
        InB <= 0;
        Control <= 011;
        #10
        // BLEZ Out = 1
        InA <= -1;
        InB <= 0;
        Control <= 011;
        #10
        // BLTZ Out = 0
        InA <= 1;
        InB <= 0;
        Control <= 100;
        #10
        // BLTZ Out = 1
        InA <= -1;
        InB <= 0;
        Control <= 100;
        #10
        // BNE = 0
        InA <= 1;
        InB <= 1;
        Control <= 101;
        #10
        // BNE Out = 1
        InA <= 1;
        InB <= 0;
        Control <= 101
        #10
        // BGT Out = 1
        InA <= 1;
        InB <= 0;
        Control <= 110;
        #10
        // BGT Out = 0
        InA <= 0;
        InB <= 1;
        Control <= 110;
    	#10
    end
endmodule