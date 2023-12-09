`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 03:14:58 PM
// Design Name: 
// Module Name: RandomNumberGenerator
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


module RandomNumberGenerator(
    input grabWord,
    input reset,
    output reg [6:0] random_num // 7 bits to represent numbers up to 100
    );
    
    // LFSR internal state (using a 7-bit register for simplicity)
    reg [6:0] lfsr;

    // Taps for 7-bit LFSR for maximal length sequence
    wire feedback = lfsr[6] ^ lfsr[5] ^ lfsr[3] ^ lfsr[2];
    
    initial begin
        lfsr <= 7'b0000001;
    end

    always @(posedge grabWord or posedge reset) begin
        if (reset) begin
            // Reset the LFSR to a non-zero value
            lfsr <= 7'b0000001;
        end else begin
            // Shift the LFSR and insert the feedback bit
            lfsr <= {lfsr[5:0], feedback};
        end
    end

    // Scale LFSR value to 1-100 range
    always @(lfsr) begin
        random_num <= (lfsr % 100) + 1;
    end

endmodule
