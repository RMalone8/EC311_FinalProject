`timescale 1ns / 1ps


module RandomNumberGenerator(
    input grabWord,
    input reset,
    output reg [6:0] random_num // 7 bits to represent numbers up to 100
    );
    
    reg [6:0] lfsr;

    wire feedback = lfsr[6] ^ lfsr[5] ^ lfsr[3] ^ lfsr[2];
    
    initial begin
        lfsr <= 7'b0000001;
    end

    always @(posedge grabWord or posedge reset) begin
        if (reset) begin
            lfsr <= 7'b0000001;
        end else begin
            lfsr <= {lfsr[5:0], feedback};
        end
    end

    // Scale LFSR value to 1-100 needed for index
    always @(lfsr) begin
        random_num <= (lfsr % 100) + 1;
    end

endmodule
