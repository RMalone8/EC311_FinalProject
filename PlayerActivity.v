`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 05:20:22 PM
// Design Name: 
// Module Name: PlayerActivity
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


module PlayerActivity(
    input [19:0] currentWord,
    input [19:0] nextWord,
    input [4:0] keystroke,
    input keyReleased,
    
    output reg wordComplete,
    output reg gameOver,
    output reg [1:0] currentState,
    output reg [10:0] totalWords
    );
      
    wire [4:0] L1 = currentWord[19:15];
    wire [4:0] L2 = currentWord[14:10];
    wire [4:0] L3 = currentWord[9:5];
    wire [4:0] L4 = currentWord[4:0];
    
    initial begin
        currentState = 0;
        gameOver = 0;
        totalWords = 0;
    end

    always @ (posedge keyReleased) begin
        case(currentState)
            0: begin
                if(keystroke == L1) begin
                    currentState = 1;
                    wordComplete = 0;
                end else begin
                    gameOver = 1;
                end
                    
            end
            
            1: begin
                if(keystroke == L2) begin
                    currentState = 2;
                    wordComplete = 0;
                end else begin
                    gameOver = 1;
                end
            end
            
            2: begin
                if(keystroke == L3) begin
                    currentState = 3;
                    wordComplete = 0;
                end else begin
                    gameOver = 1;
                end
            end
            
            3: begin
                if(keystroke == L4) begin
                    currentState = 0;
                    wordComplete = 1;
                    totalWords = totalWords + 1;
                end else begin
                    gameOver = 1;
                end
            end
            
        endcase
    end
    
    
    WordDelivery wd (
        .clk(clk),
        .reset(reset),
        .wordComplete(wordComplete),
        .currentWord(currentWord),
        .nextWord(nextWord)
    );
        
    
endmodule
