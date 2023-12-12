`timescale 1ns / 1ps

module WordDelivery_tb;

    // Inputs
    reg clk;
    reg wordComplete;
    reg reset;

    // Outputs (Corrected to 20-bit width)
    wire [19:0] currentWord;
    wire [19:0] nextWord;

    // Instantiate the Unit Under Test (UUT)
    WordDelivery uut (
        .clk(clk), 
        .wordComplete(wordComplete), 
        .reset(reset), 
        .currentWord(currentWord), 
        .nextWord(nextWord)
    );

    // Clock generation
    always #5 clk = ~clk; // Generate a clock with a period of 10 ns

    // Test sequence
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        wordComplete = 0;

        // Reset the system
        #10;
        reset = 0;

        // Toggle wordComplete to generate words
        #10 wordComplete = 1;
        #10 wordComplete = 0;
        #10 wordComplete = 1;
        #10 wordComplete = 0;
        #10 wordComplete = 1;
        #10 wordComplete = 0;
        #10 wordComplete = 1;
        #10 wordComplete = 0;
        #10 wordComplete = 1;
        #10 wordComplete = 0;
        #10 wordComplete = 1;
        #10 wordComplete = 0;
        
        // Continue toggling as needed to generate more words

        // Stop the simulation after some time
        #100;
        $stop;
    end

    // Optional: Monitor the outputs
    initial begin
        $monitor("Time = %d : Current Word = %b, Next Word = %b", $time, currentWord, nextWord);
    end

endmodule
