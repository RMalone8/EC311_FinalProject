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
    input [4:0] keystroke,
    input keyReleased, 
    input clk, 
    input reset,
   
    inout [19:0] currentWord,
    inout [19:0] nextWord, 
   
     
   // output reg gameOver, 
   // output reg newGame,
    output reg [3:0] currentState,
//    output reg [19:0] currentWord,
//    output reg [19:0] nextWord,
    output reg [7:0] score,
    output reg [1:0] lives,
    output reg swstart
 
    );
    
    parameter gameTimer = 500000000;   
  reg wordComplete;  
  reg [28:0] counter;
  reg [3:0] nextState;
    
//  wire [19:0] currentWordWire;
//  wire [19:0] nextWordWire;
// assign nextWordWire = nextWord;  
// assign currentWordWire = currentWord;  
 
  wire [4:0] L4 = currentWord[19:15];
  wire [4:0] L3 = currentWord[14:10];
  wire [4:0] L2 = currentWord[9:5];
  wire [4:0] L1 = currentWord[4:0];


    initial begin
        
        currentState = 5;
        nextState = 5;
      // currentState = 0;
        score = 0;
        lives = 2'b11;
        wordComplete = 1;
        swstart = 0;
        //counter = 0;
        
    end
 
    always @ (posedge keyReleased) begin
        case(currentState)
            0: begin
            wordComplete = 0;
            swstart = 1;
                if(keystroke == L1) begin 
                    nextState = 1;
                end else begin
                if (lives == 1) begin
                    swstart = 0;
                    nextState = 5;end
                    else
                    lives = lives-1;
                end
                    
            end
            
            1: begin
            wordComplete = 0;
                if(keystroke == L2) begin
                    nextState = 2;
                    wordComplete = 0;
                end else begin
                  if (lives == 1) begin
                    swstart = 0;
                   nextState = 5;end
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
                     swstart = 0;
                    nextState = 5;end
                    else
                    lives = lives-1;
                end
            end
            
            3: begin
            wordComplete = 0;
                if(keystroke == L4) begin
                    score = score + 1; 
                   nextState = 0;
                    wordComplete = 1;
                end else begin
                  if (lives == 1) begin
                    swstart = 0;
                    nextState = 5;end
                    else
                    lives = lives-1;
                end
            end
          
           5: begin
     
                if (keystroke == 5'b11111)begin
                    
                    nextState = 6;
                    score = 0;
                    lives = 3;
                    wordComplete = 0;
                    swstart = 0;
                 end
                end 
                
           
              
        endcase
    end

  WordDelivery wd (
        .clk(clk),
        .wordComplete(wordComplete),
        .reset(reset),
        
        .currentWord(currentWord),
        .nextWord(nextWord)
    );
 
 always @(posedge clk) begin
 case (currentState)
            6: begin
               wordComplete = 1;
               nextState = 7;
              // newGame = 1;
               end
               
            7: begin
                wordComplete = 0;
                nextState = 8;
                end
                
            8: begin
                wordComplete = 1;
                nextState = 0;
                end
 endcase
 
// if (currentState == 4)begin
//        counter = counter +1;
//        wordComplete = 1;
//        end
//    if (counter == gameTimer)begin
//        counter = 0;
//        nextState = 5;
//        end
  
   currentState = nextState;
   end
endmodule
