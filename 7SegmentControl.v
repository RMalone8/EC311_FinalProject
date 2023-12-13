`timescale 1ns / 1ps

module SevSegControl(
    input clk,  // Clock input
    input [11:0] wpm_integer,  // 12-bit BCD (3 digits) for integer part of WPM
    input [7:0] wpm_decimal,   // 8-bit BCD (2 digits) for decimal part of WPM
    output reg [6:0] SEG,      // 7-segment display segments
    output reg [4:0] AN        // 5 Anodes for 7-segment display
);

    // Internal registers for individual digits
    wire [3:0] digit1, digit2, digit3, digit4, digit5;

    // Extracting individual digits from BCD inputs
    assign digit1 = wpm_integer[3:0];     // Least significant digit of integer part
    assign digit2 = wpm_integer[7:4];     // Middle digit of integer part
    assign digit3 = wpm_integer[11:8];    // Most significant digit of integer part
    assign digit4 = wpm_decimal[3:0];     // Least significant digit of decimal part
    assign digit5 = wpm_decimal[7:4];     // Most significant digit of decimal part

    // Function for mapping digits to 7-segment patterns
    function [6:0] digit_to_seg;
        input [3:0] digit;
        begin
            case(digit)
                4'b0000: digit_to_seg = 7'b1000000; // 0
                4'b0001: digit_to_seg = 7'b1111001; // 1
                4'b0010: digit_to_seg = 7'b0100100; // 2
                4'b0011: digit_to_seg = 7'b0110000; // 3
                4'b0100: digit_to_seg = 7'b0011001; // 4
                4'b0101: digit_to_seg = 7'b0010010; // 5
                4'b0110: digit_to_seg = 7'b0000010; // 6
                4'b0111: digit_to_seg = 7'b1111000; // 7
                4'b1000: digit_to_seg = 7'b0000000; // 8
                4'b1001: digit_to_seg = 7'b0010000; // 9
                default: digit_to_seg = 7'b1111111; // Blank
            endcase
        end
    endfunction

    // Digit selection and refresh logic
    reg [2:0] digit_select;
    reg [16:0] refresh_timer;
    
    always @(posedge clk) begin
        if(refresh_timer >= 100000) begin
            refresh_timer <= 0;
            digit_select <= digit_select + 1;
        end else
            refresh_timer <= refresh_timer + 1;
    end

    // Display logic
    always @(posedge clk) begin
        case(digit_select)
            3'b000 : begin
                SEG <= digit_to_seg(digit1);
                AN <= 5'b11110;
            end
            3'b001 : begin
                SEG <= digit_to_seg(digit2);
                AN <= 5'b11101;
            end
            3'b010 : begin
                SEG <= digit_to_seg(digit3);
                AN <= 5'b11011;
            end
            3'b011 : begin
                SEG <= digit_to_seg(digit4);
                AN <= 5'b10111;
            end
            3'b100 : begin
                SEG <= digit_to_seg(digit5);
                AN <= 5'b01111;
            end
            default : begin
                SEG <= 7'b1111111; // Turn off segment
                AN <= 5'b11111;    // Turn off all anodes
            end
        endcase
    end

endmodule
