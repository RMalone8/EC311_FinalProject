`timescale 1ns / 1ps

module PlayerActivity_TB;

    // Inputs to the PlayerActivity module
    reg [19:0] currentWord;
    reg [19:0] nextWord;
    reg [4:0] keystroke;
    reg keyReleased;
    
    // Outputs from the PlayerActivity module
    wire wordComplete;
    wire gameOver;

    // Instantiate the PlayerActivity module
    PlayerActivity uut (
        .currentWord(currentWord),
        .nextWord(nextWord),
        .keystroke(keystroke),
        .keyReleased(keyReleased),
        .wordComplete(wordComplete),
        .gameOver(gameOver)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        currentWord = 20'b01010100100101100100; // Encoded word "joke"
        nextWord = 20'b10000001000011110101; // Encoded word "game"
        keystroke = 5'b00000; // Initialize to a non-valid key
        keyReleased = 0; // Initially, no key is released

        // Wait for the simulation to settle
        #10;

        // Simulate typing the correct word "joke"
        keystroke = 5'b01010; // 'j'
        keyReleased = 1; #10 keyReleased = 0; #10;
        keystroke = 5'b10010; // 'o'
        keyReleased = 1; #10 keyReleased = 0; #10;
        keystroke = 5'b01011; // 'k'
        keyReleased = 1; #10 keyReleased = 0; #10;
        keystroke = 5'b00100; // 'e'
        keyReleased = 1; #10 keyReleased = 0; #10;
        
        // Check if wordComplete is asserted
        if (wordComplete !== 1) begin
            $display("Test failed: wordComplete not asserted.");
            $finish;
        end

        // Prepare for the next word
        currentWord = nextWord; // Move to next word "game"
        nextWord = 20'bxxxx; // Assume next word is unknown
        
        // Simulate beginning to type the next word "game", which will reset wordComplete
        keystroke = 5'b10000; // 'g' for "game"
        keyReleased = 1; #10 keyReleased = 0; #10;

        // Add more keystrokes for additional words if needed...

        // End the simulation
        #100;
        $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time = %d : wordComplete = %d, gameOver = %d", $time, wordComplete, gameOver);
    end
    
endmodule