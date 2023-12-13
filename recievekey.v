`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 09:20:46 AM
// Design Name: 
// Module Name: revievekey_test_mod
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


module recievekey(

input [31:0] keycode,
output [3:0] num1, //first digit reading right to left
output [3:0] num2, // second digit reading right to left
output [3:0] num3,// first digit of "a" (previous number) reading right to left
output [3:0] num4, // second digit reading right to left
//output [15:0] krcode
output reg kr
    );

reg[8:0] key_up_down;

assign num1 [3:0] = keycode[3:0];    
assign num2 [3:0] = keycode[7:4];
assign num3 [3:0] = keycode[27:24];
assign num4 [3:0] = keycode[31:28];
//assign krcode [15:0] = keycode[23:8];

always@(keycode)begin
    if(keycode[15:12]==16'b1111)
        kr <=1 ;
      else
      kr<=0;
end
endmodule
