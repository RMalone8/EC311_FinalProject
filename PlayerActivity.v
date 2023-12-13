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
    input [4:0] keystroke,
    input keyReleased, 
    input clk, 
    input reset,
   
    output reg wordComplete, 
    output reg gameOver, 
    output reg newGame,
    output reg [2:0] currentState,
    output reg [2:0] nextState,
    output reg [6:0] score,
    output reg [1:0] lives
 
    );
    
    
  wire [4:0] L4 = currentWord[19:15];
  wire [4:0] L3 = currentWord[14:10];
  wire [4:0] L2 = currentWord[9:5];
  wire [4:0] L1 = currentWord[4:0];


    initial begin
        wordComplete = 1;
        currentState = 5;
        nextState = 5;
        score = 0;
        lives = 2'b11;
        wordComplete = 0;
        gameOver = 0;
      //  newGame = 1;
        
    end
 
    always @ (posedge keyReleased) begin
        case(currentState)
            0: begin
            wordComplete = 0;
                if(keystroke == L1) begin 
                    nextState = 1;
                end else begin
                if (lives == 1) begin
                    gameOver = 1;
                    nextState = 4;end
                    else
                    lives = lives-1;
                end
                    
            end
            
            1: begin
                if(keystroke == L2) begin
                    nextState = 2;
                    wordComplete = 0;
                end else begin
                  if (lives == 1) begin
                    gameOver = 1;
                    nextState = 4;end
                    else
                    lives = lives-1;
                end
            end
            
            2: begin
                if(keystroke == L3) begin
                    nextState = 3;
                    wordComplete = 0;
                end else begin
                  if (lives == 1) begin
                    gameOver = 1;
                    nextState = 4;end
                    else
                    lives = lives-1;
                end
            end
            
            3: begin
                if(keystroke == L4) begin
                    score = score + 1; 
                    nextState = 0;
                    wordComplete = 1;
                end else begin
                  if (lives == 1) begin
                    gameOver = 1;
                    nextState = 4;end
                    else
                    lives = lives-1;
                end
            end
            
            4: begin
                if (keystroke == 5'b11111)begin
                    newGame = 1;
                    nextState = 5;
                    score = 0;
                    lives = 3;
                    //wordComplete = 1;
                    gameOver = 0;
                 end
                end  
                
           
              
        endcase
    end

  WordDelivery wd (
        .clk(clk),
        .reset(newGame),
      //  .initialwordGrab(initialwordGrab),
        .wordComplete(wordComplete),
        .currentWord(currentWord)
    );
 
 always @(posedge clk) begin
 case (currentState)
         5: begin
                wordComplete = 1;
                nextState = 6;
                end
                
            6: begin
               wordComplete = 0;
               nextState = 7;
               end
               
            7: begin
                wordComplete = 1;
                nextState = 0;
                end
 endcase
 
 if (newGame==1)begin
    currentState = 1;
    score = 0;
    lives = 3;
    newGame = 0;
    end   
   currentState = nextState;
   end
endmodule
