`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2023 03:43:58 PM
// Design Name: 
// Module Name: TOP
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


module TOP(
    input start,
    input clk,
    input reset,
    input [4:0] keystroke,
    input keyReleased
);

    // to VGA module
    //include input start;
    wire [19:0] currentWord;
    wire [19:0] nextWord;
    wire [1:0]currenState;
    reg wordComplete;
    wire gameOver;
    
    
    //time registers
    reg [3:0] minutes, sec_high, sec_low, tenths;
    
    reg [10:0] totalWords;
    reg [10:0] WPM;

    // Instantiate PlayerActivity
    PlayerActivity pa (
        .currentWord(currentWord),
        .nextWord(nextWord),
        .keystroke(keystroke),
        .keyReleased(keyReleased),
        .wordComplete(wordComplete),
        .gameOver(gameOver),
        .currentState(currentState)
    );
    
    //Instantiate Stopwatch
    Stopwatch sw (
        .clk(clk),
        .reset(reset),
        .start(start),
        .minutes(minutes),
        .sec_high(sec_high),
        .sec_low(sec_low),
        .tenths(tenths)
    );
    
    //logic to calculate WPM
    reg [9:0] total_sec;
    always @ (clk) begin
        total_sec = minutes * 60;
        total_sec = total_sec + (sec_high*10) + sec_low;
        WPM = totalWords / total_sec;
        WPM = WPM / 60;
    end
        

endmodule