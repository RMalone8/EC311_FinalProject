module segmentDecoder(
input [4:0] char,
output reg [15:0] segments
);

    always @(char) begin
        case (char)
            // Assign 16-bit values for each alphabet letter
            5'b00000: segments = 16'b1110011101000010; // A
            5'b00001: segments = 16'b1001111111100010; // B
            5'b00010: segments = 16'b1111100100000000; // C
            5'b00011: segments = 16'b1001111110100000; // D
            5'b00100: segments = 16'b1111100101000000; // E
            5'b00101: segments = 16'b1110000001000000; // F
            5'b00110: segments = 16'b1111110100000010; // G
            5'b00111: segments = 16'b0000000011100111; // H
            5'b01000: segments = 16'b1001100100011000; // I
            5'b01001: segments = 16'b0001100100000101; // J
            5'b01010: segments = 16'b0000000011110001; // K
            5'b01011: segments = 16'b0111000000000000; // L
            5'b01100: segments = 16'b1110011100011000; // M
            5'b01101: segments = 16'b1110000000011000; // N
            5'b01110: segments = 16'b1111111100000000; // O
            5'b01111: segments = 16'b1110000001010000; // P
            5'b10000: segments = 16'b1111100000011000; // Q
            5'b10001: segments = 16'b1110100101001110; // R
            5'b10010: segments = 16'b1101110101000010; // S
            5'b10011: segments = 16'b1000000100011000; // T
            5'b10100: segments = 16'b0111111000000000; // U
            5'b10101: segments = 16'b0100001000100001; // V
            5'b10110: segments = 16'b0111111000001000; // W
            5'b10111: segments = 16'b0110011001000010; // X
            5'b11000: segments = 16'b0100001001001010; // Y
            5'b11001: segments = 16'b1011100001000100; // Z
            default:  segments = 16'b0000000000000000; // Default case (blank)
        endcase
    end
endmodule

