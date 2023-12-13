`timescale 1ns / 1ps

module PATB;

    // Inputs to the PlayerActivity module
    reg [19:0] currentWord;
    reg [19:0] nextWord;
    reg [4:0] keystroke;
    reg keyReleased;
    reg clk;
    reg reset;
    //reg newGame;
    
    // Outputs from the PlayerActivity module
    wire wordComplete;
    wire gameOver;
    wire newGame;
    wire [2:0] currentState;
    wire [2:0] nextState;
    wire [6:0] score;
    wire [1:0]lives;
    
    // Instantiate the PlayerActivity module
    PlayerActivity uut (
       // .currentWord(currentWord),
        .clk(clk),
        .keystroke(keystroke),
        .keyReleased(keyReleased),
   
        
        .wordComplete(wordComplete),
        .gameOver(gameOver),
        .newGame(newGame),
        .currentState(currentState),
        .nextState(nextState),
        .score(score),
        .lives(lives)
        
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
        keystroke = currentWord[4:0]; // Initialize to a non-valid key
        // Wait for the simulation to settle
        #25
        #10
        keystroke = 5'b00100;
        #10
        keystroke = 5'b01011;
        #10
        keystroke = 5'b10010;
        #10
        keystroke = 5'b01010;   
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
    initial begin
        $monitor("Time = %d : wordComplete = %d, gameOver = %d", $time, wordComplete, gameOver);
    end
    
endmodule