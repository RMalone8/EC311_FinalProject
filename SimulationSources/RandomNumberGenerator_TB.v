`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 03:15:49 PM
// Design Name: 
// Module Name: RandomNumberGenerator_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RandomNumberGenerator_TB;

    reg clk;
    
    reg reset;

    wire [6:0] random_num;

    RandomNumberGenerator uut (
        .grabWord(clk), 
        .reset(reset),
        .random_num(random_num)
    );

    // Clock generation
    always #10 clk = ~clk; 
    
    initial begin

        clk = 0;


        #1000;

        $stop;
    end

    initial begin
        $monitor("Time = %d : Random Number = %d", $time, random_num);
    end

endmodule
