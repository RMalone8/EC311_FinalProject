`timescale 1ns / 1ps

module WordDelivery_tb;

    reg clk;
    reg wordComplete;
    reg reset;

    wire [19:0] currentWord;
    wire [19:0] nextWord;

    WordDelivery uut (
        .clk(clk), 
        .wordComplete(wordComplete), 
        .reset(reset), 
        .currentWord(currentWord), 
        .nextWord(nextWord)
    );


    always #5 clk = ~clk; 
    
    initial begin
      
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
        

        #100;
        $stop;
    end
    
    initial begin
        $monitor("Time = %d : Current Word = %b, Next Word = %b", $time, currentWord, nextWord);
    end

endmodule
