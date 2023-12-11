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
    currentWord,
    nextWord,
    keystroke,
    keyReleased,
    
    wordComplete,
    gameOver
    );
    
    input [19:0] currentWord;
    input [4:0] keystroke;
    input keyReleased;
    
    output reg wordComplete;
    output reg gameOver;
    
    wire [4:0] L1 = currentWord[19:15];
    wire [4:0] L2 = currentWord[14:10];
    wire [4:0] L3 = currentWord[9:5];
    wire [4:0] L4 = currentWord[4:0];
    
    reg [1:0] currentState;
    
    initial begin
        currentState = 1;
    end

    always @ (posedge keyReleased) begin
        case(currentState)
            1: begin
                if(keystroke == L1) begin
                    currentState = 2;
                    wordComplete = 0;
                end else begin
                    gameOver = 1;
                end
                    
            end
            
            2: begin
                if(keystroke == L2) begin
                    currentState = 3;
                    wordComplete = 0;
                end else begin
                    gameOver = 1;
                end
            end
            
            3: begin
                if(keystroke == L3) begin
                    currentState = 4;
                    wordComplete = 0;
                end else begin
                    gameOver = 1;
                end
            end
            
            4: begin
                if(keystroke == L4) begin
                    currentState = 1;
                    wordComplete = 1;
                end else begin
                    gameOver = 1;
                end
            end
            
        endcase
    end
        
    
endmodule
