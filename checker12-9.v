`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 08:10:04 PM
// Design Name: 
// Module Name: moore_FSM
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

// Current concerns: not sure how the grabnext/pass is gonna be working; should everything be in an always block set off by a change in cword? 

module checker(pass, fail, npassed, cletter, nxtletter, kstrk, kr, cword, reset, clk);
    input kr, reset; //key release
    input [4:0] kstrk; //data from one key stroke
    input [19:0] cword; //current word from big word reg
    input clk; 
    
    output reg [5:0] npassed; //increments every passed word
   /* Im not sure this is gonna work if we're incrementing it in here, depending on how getting the next word works we might need to increment in top or in some module that is between top 
    and Arnouv and I's module
    */ 
    output reg pass, fail; //pass goes high when the word is completed, fail goes high when it is failed (Pass should be the same as grab next)
    output reg [2:0] cletter, nxtletter; //essentially the state vars (currentstate nextstate)
 
  	reg [4:0] ccrctlet; //current correct letter to be compared to keystroke
    
    parameter L1 = 0, L2 = 1, L3= 2, L4 = 3, failstate=4; //L1 is when waiting for the letter 1 to be typed, same logic with 2-4.
    
    initial cletter = L1;
    initial nxtletter = L1; //adding this because cletter might transition to nxtletter before the first always block is set off
    initial pass = 0;
    initial fail = 0;
    initial npassed = 0;

    always @ (posedge kr) 
        case(cletter)
          L1: begin
              ccrctlet = cword[4:0];
                if(kstrk == ccrctlet)
                  nxtletter = cletter+1;               
                else
                  nxtletter = failstate;
                  
           pass = 0;
           fail = 0;
           end
           
           
          L2: begin
              ccrctlet = cword[9:5];
                if(kstrk == ccrctlet)
                  nxtletter = cletter+1;
                else
                  nxtletter = failstate;
                  
             pass = 0;
             fail = 0;
          end
          
          L3: begin
              ccrctlet = cword[14:10];
                if(kstrk == ccrctlet)
                  nxtletter = cletter+1;
                else
                  nxtletter = failstate;
             pass = 0;
             fail = 0;
          end       
            
          L4: begin
              ccrctlet = cword[19:15];
                if(kstrk == ccrctlet)begin
                  nxtletter = L1;
                  pass = 1;
                  npassed = npassed + 1;
                  end
                else begin
                  pass = 0;
                  nxtletter = failstate;
                 end
                 
             fail = 0;
               
              end
           failstate: begin
             //I dont know what we need from here besides this
             //Should cletter go back to L1? 
             fail = 1;
              end
        endcase  
 
 //not adding an else because it wont even change next state if kr==0
   always @(posedge clk) begin
    if (reset)
      cletter = L1;
    else
      cletter = nxtletter;
   end

endmodule