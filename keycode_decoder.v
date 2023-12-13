`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 11:39:40 AM
// Design Name: 
// Module Name: keycode_decoder
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


module keycode_decoder(
input [3:0] dig1, 
input [3:0] dig2,
output [4:0] a_or_b_out
    );

reg [4:0]abreg;

parameter a = 5'b00000;
parameter b = 5'b00001;
parameter c = 5'b00010;
parameter d = 5'b00011;
parameter e = 5'b00100;
parameter f = 5'b00101;
parameter g = 5'b00110;
parameter h = 5'b00111;
parameter i = 5'b01000;
parameter j = 5'b01001;
parameter k = 5'b01010;
parameter l = 5'b01011;
parameter m = 5'b01100;
parameter n = 5'b01101;
parameter o = 5'b01110;
parameter p = 5'b01111;
parameter q = 5'b10000;
parameter r = 5'b10001;
parameter s = 5'b10010;
parameter t = 5'b10011;
parameter u = 5'b10100;
parameter v = 5'b10101;
parameter w = 5'b10110;
parameter x = 5'b10111;
parameter y = 5'b11000;
parameter z = 5'b11001;
parameter ENTR = 5'b11111;

always @(dig1,dig2) begin
    case(dig2) //leftmost character of keystroke
    1: begin case(dig1) //rightmost character of keystroke
        5: abreg <= q;
        13: abreg <= w;
        12: abreg<= a;
        11:abreg<=s; 
        10: abreg<=z;
        endcase
        end
    2: begin case(dig1)
        4:abreg <= e;
        13:abreg <= r;
        12:abreg <= t;
        3:abreg <= d;
        11:abreg <= f;
        2:abreg <= x;
        1:abreg <= c;
        10:abreg <= v;
        endcase
        end
    3: begin case(dig1)
        5:abreg <= y;
        12:abreg <= u;
        4:abreg <= g;
        3: abreg<= h;
        11: abreg<=j;
        2:abreg<=b;
       1:abreg<=n;
       10:abreg<=m; 
        endcase
        end
    4: begin case(dig1)
        3: abreg <= i;
        4: abreg <= o;
        13:abreg<= p;
        2:abreg<=k;
        11: abreg<=l;
         endcase
        end 
     5: begin case(dig1)
        10: abreg <= ENTR;  
    endcase
    end 
    endcase
    end
    assign a_or_b_out = abreg;    
endmodule

