`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 06:52:07 PM
// Design Name: 
// Module Name: binary_to_BCD_small
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


module binary_to_BCD_small(
    input [6:0] bin,
    output reg [7:0] bcd
);
    // Internal variables
    reg [3:0] i;   

    // Initialize bcd to zero at the start of the simulation
    initial begin
        bcd = 8'b0; // Set all bits to zero
    end

    // Always block - implement the Double Dabble algorithm
    always @(bin) begin
        bcd = 0; // Initialize bcd to zero.
        for (i = 0; i < 7; i = i + 1) begin // Run for 7 iterations
            bcd = {bcd[6:0], bin[6-i]}; // Concatenation
                    
            // If a hex digit of 'bcd' is more than 4, add 3 to it.  
            if(i < 6 && bcd[3:0] > 4) 
                bcd[3:0] = bcd[3:0] + 3;
            if(i < 6 && bcd[7:4] > 4)
                bcd[7:4] = bcd[7:4] + 3;
        end
    end     
endmodule

