`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 03:37:38 PM
// Design Name: 
// Module Name: final_top
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


module final_top(
input [4:0] char,
input reset,
input CLK100MHZ,
input PS2_CLK,
input PS2_DATA,
output hsync,
output vsync,
output [3:0] VGA_R,
output [3:0] VGA_G,
output [3:0] VGA_B
    );
    
reg CLK50MHZ=0; 
wire[4:0] a;

wire [31:0]keycode;

wire [3:0]test_num1;
wire [3:0]test_num2;
wire [3:0]test_num3;
wire [3:0]test_num4;

wire failwire;

wire kr;

wire swstart;

wire [3:0] word_pos;

wire [19:0] currentWord;
wire [19:0] nextWord;

reg [4:0] let_1 = 5'b01011;
reg [4:0] let_2 = 5'b00000;
reg [4:0] let_3 = 5'b00001; 
reg [4:0] let_4 = 5'b00010; 
reg [4:0] let_5 = 5'b00011;
reg [4:0] let_6 = 5'b00100; 
reg [4:0] let_7 = 5'b00101; 
reg [4:0] let_8 = 5'b00110;


wire [7:0] score; //= 3;

//reg [6:0] score_100s;
//reg [6:0] score_10s = 7'b0110111;
//reg [6:0] score_1s = 7'b0001100;
wire [1:0] lives; //= 3;

reg [7:0] lives_seg = 7'b0011111;

always @ (lives)
    case (lives)
        0: lives_seg <= 7'b1111110;
        1: lives_seg <= 7'b0001100;
        2: lives_seg <= 7'b0110111;
        3: lives_seg <= 7'b0011111;
    endcase

wire [20:0] score_seg;
//wire [20:0] lives_seg;

wire [15:0] seg_data_1;
wire [15:0] seg_data_2;
wire [15:0] seg_data_3;
wire [15:0] seg_data_4;
wire [15:0] seg_data_5;
wire [15:0] seg_data_6;
wire [15:0] seg_data_7;
wire [15:0] seg_data_8;

always @ (posedge CLK100MHZ) begin
    case(word_pos)
        4: begin
            let_1 <= 5'b00110; // G
            let_2 <= 5'b00000; // A
            let_3 <= 5'b01100; // M
            let_4 <= 5'b00100; // E
            let_5 <= 5'b01110; // O
            let_6 <= 5'b10101; // V
            let_7 <= 5'b00100; // E
            let_8 <= 5'b10001; // R
        end
        5: begin
            let_1 <= 5'b11111; // 
            let_2 <= 5'b00111; // H
            let_3 <= 5'b01000; // I
            let_4 <= 5'b10011; // T
            let_5 <= 5'b00100; // E
            let_6 <= 5'b01101; // N
            let_7 <= 5'b10011; // T
            let_8 <= 5'b10001; // R
        end
        default: begin
            let_1 <= currentWord[19:15];
            let_2 <= currentWord[14:10];
            let_3 <= currentWord[9:5];
            let_4 <= currentWord[4:0]; 
            let_5 <= nextWord[19:15];
            let_6 <= nextWord[14:10];
            let_7 <= nextWord[9:5];
            let_8 <= nextWord[4:0];
       end
    endcase
end

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
 .failflag(failwire),
 .num1(test_num1[3:0]),
 .num2(test_num2[3:0]),
 .num3(test_num3[3:0]),
 .num4(test_num4[3:0]),
 .kr(kr)
 );
 
 keycode_decoder(
 .dig1(test_num1[3:0]),
 .dig2(test_num2[3:0]),
 .a_or_b_out(a[4:0])
    );

PlayerActivity pa(
.keystroke(a),
.keyReleased(kr),
.clk(CLK100MHZ),
.reset(reset),
.currentWord(currentWord),
.nextWord(nextWord),
.currentState(word_pos),
.score(score),
.lives(lives),
.swstart(swstart)
);


// Score Decoders
numericSegmentDecoder nsd(
.num(score),
.num_seg(score_seg)
);



// Segment Decoders
segmentDecoder segcontrol_1(
.char(let_1),
.segments(seg_data_1)
);

segmentDecoder segcontrol_2(
.char(let_2),
.segments(seg_data_2)
);

segmentDecoder segcontrol_3(
.char(let_3),
.segments(seg_data_3)
);

segmentDecoder segcontrol_4(
.char(let_4),
.segments(seg_data_4)
);

segmentDecoder segcontrol_5(
.char(let_5),
.segments(seg_data_5)
);

segmentDecoder segcontrol_6(
.char(let_6),
.segments(seg_data_6)
);

segmentDecoder segcontrol_7(
.char(let_7),
.segments(seg_data_7)
);

segmentDecoder segcontrol_8(
.char(let_8),
.segments(seg_data_8)
);
    
vga vga_cont(
.in_clk(CLK100MHZ),
.let_code_1(seg_data_1),
.let_code_2(seg_data_2),
.let_code_3(seg_data_3),
.let_code_4(seg_data_4),
.let_code_5(seg_data_5),
.let_code_6(seg_data_6),
.let_code_7(seg_data_7),
.let_code_8(seg_data_8),
.score_100s(score_seg[20:14]),
.score_10s(score_seg[13:7]),
.score_1s(score_seg[6:0]),
.lives(lives_seg),
.word_pos(word_pos),
.VGA_R(VGA_R),
.VGA_G(VGA_G),
.VGA_B(VGA_B),
.VGA_HS(hsync),
.VGA_VS(vsync)
);
   
 
endmodule