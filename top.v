`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 06:05:52 PM
// Design Name: 
// Module Name: top
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


module top(
input CLK100MHZ,
input PS2_CLK,
input PS2_DATA,
input [3:0]opcode,
output char,
output kr    
    );

reg CLK50MHZ=0; 
wire[3:0] a;

wire [31:0]keycode;

wire [3:0]test_num1;
wire [3:0]test_num2;
wire [3:0]test_num3;
wire [3:0]test_num4;

always @(posedge(CLK100MHZ))begin
    CLK50MHZ<=~CLK50MHZ;
end

PS2Receiver keyboard(
.clk(CLK50MHZ),
.kclk(PS2_CLK),
.kdata(PS2_DATA),
.keycodeout(keycode[31:0])
);

recievekey(
 .keycode(keycode[31:0]),
 .num1(test_num1[3:0]),
 .num2(test_num2[3:0]),
 .num3(test_num3[3:0]),
 .num4(test_num4[3:0])
 );
 
 keycode_decoder(
 .dig1(test_num1[3:0]),
 .dig2(test_num2[3:0]),
 .a_or_b_out(a[3:0])
 );
 
 endmodule