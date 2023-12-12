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

    // Inputs
    reg clk;
    
    reg reset;

    // Outputs
    wire [6:0] random_num;

    // Instantiate the randomizer module
    RandomNumberGenerator uut (
        .grabWord(clk), 
        .reset(reset),
        .random_num(random_num)
    );

    // Clock generation
    always #10 clk = ~clk; // 50MHz clock (20ns period)

    // Test sequence
    initial begin
        // Initialize Inputs
        clk = 0;

        // Wait for random number generation
        #1000; // Wait long enough to see several random numbers generated

        // Stop the simulation
        $stop;
    end

    // Optional: Monitor the output
    initial begin
        $monitor("Time = %d : Random Number = %d", $time, random_num);
    end

endmodule
