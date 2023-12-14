`timescale 1ns / 1ps

module PATB;

    // Inputs to the PlayerActivity module
    //reg [19:0] currentWord;
   // reg [19:0] nextWord;
    reg [4:0] keystroke;
    reg keyReleased;
    reg clk;
    reg reset;
    //reg newGame;
    
    // Outputs from the PlayerActivity module
   // wire wordComplete;
    wire [3:0] currentState;
    wire [19:0] currentWord;
    wire [19:0] nextWord;
    //wire [3:0] nextState;
    wire [7:0] score;
    wire [1:0] lives;
    wire swstart;
 
    // Instantiate the PlayerActivity module
    PlayerActivity uut (
        .keystroke(keystroke),
        .keyReleased(keyReleased),
        .clk(clk),
        .reset(reset),
    
      //  .wordComplete(wordComplete),
        .currentState(currentState),
        .currentWord(currentWord),
        .nextWord(nextWord),
        //.nextState(nextState),
        .score(score),
        .lives(lives),
        .swstart(swstart)
        
    );
    initial begin
    #30
    forever begin
    #5
    keyReleased = ~keyReleased;
    end
    end
    
    initial begin
    clk=0;
    keyReleased=0;
    reset = 0;
    forever begin;
    #5
    clk = ~clk;
    end
    end
    // Test sequence
    initial begin
   // #2.5 newGame = 0;
        // Initialize inputs
    //   currentWord = 20'b01010100100101100100;// Encoded word "joke"
     //  nextWord = 0; // 
        keystroke = 5'b11111; 
        keyReleased = 1;
        #5
        keyReleased = 0;
        keystroke = 5'b01010;
        // Wait for the simulation to settle
        #20
        #20
        keystroke = 5'b01010;
        #10
        keystroke = 5'b01110;
        #10
        keystroke = 5'b01110;
        #10
        keystroke = 5'b01011;   
        #10
        keystroke = 5'b00000;
        #10
        keystroke = 5'b00000;
        #10
        keystroke = 5'b00000;
        #10
        keystroke = 5'b11111;     
        
       

        
        #500;
        $finish;
    end

    // Monitor the outputs
 
    
endmodule