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
    
    // (WPM signal formatting -> 2 LSB's are the decimals places)
    reg [9:0] total_sec;
    always @(posedge clk) begin
        if (reset) begin
            total_sec <= 0;
            WPM <= 0;
        end else begin
            total_sec = minutes * 60 + sec_high * 10 + sec_low;
            if (total_sec != 0) begin
                // Scale totalWords by 100
                WPM = (totalWords * 60 * 100) / total_sec;
            end else begin
                WPM = 0;
            end
        end
    end
        

endmodule