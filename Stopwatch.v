`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// Module Name: Stopwatch
//
// Additional Comments:
// https://simplefpga.blogspot.com/2012/07/to-code-stopwatch-in-verilog.html
//////////////////////////////////////////////////////////////////////////////////

module Stopwatch(
    input clock,
    input reset,
    input start,
    output reg [3:0] minutes, // M
    output reg [3:0] sec_high, // First S
    output reg [3:0] sec_low,  // Second S
    output reg [3:0] tenths    // d
);

reg [3:0] reg_d0, reg_d1, reg_d2, reg_d3; // Registers for individual digits
reg [23:0] ticker; // 24-bit Ticker for 0.1 second intervals
wire click;
reg start_prev;

reg [3:0] latched_minutes, latched_sec_high, latched_sec_low, latched_tenths;

// Detect the negative edge of the start signal
always @(posedge clock or posedge reset) begin
    if (reset) begin
        start_prev <= 1'b0;
    end else begin
        start_prev <= start;
    end
end

// Latch the current time when start signal goes from high to low
always @(posedge clock or posedge reset) begin
    if (reset) begin
        latched_minutes <= 0;
        latched_sec_high <= 0;
        latched_sec_low <= 0;
        latched_tenths <= 0;
    end else if (start_prev && !start) begin
        // Latch the time values
        latched_minutes <= reg_d3;
        latched_sec_high <= reg_d2;
        latched_sec_low <= reg_d1;
        latched_tenths <= reg_d0;
    end
end

// Mod 10M clock to generate a tick every 0.1 second
always @(posedge clock or posedge reset) begin
    if(reset) begin
        ticker <= 0;
    end else if(ticker == 10000000) // (100Mhz = 10000000)
        ticker <= 0;
    else if(start)
        ticker <= ticker + 1;
end

assign click = (ticker == 10000000) ? 1'b1 : 1'b0; // (100Mhz = 10000000)

// Time increment logic
always @(posedge clock or posedge reset) begin
    if (reset) begin
        reg_d0 <= 0;
        reg_d1 <= 0;
        reg_d2 <= 0;
        reg_d3 <= 0;
    end
    else if (click) begin
        if(reg_d0 == 9) begin
            reg_d0 <= 0;
            if (reg_d1 == 9) begin
                reg_d1 <= 0;
                if (reg_d2 == 5) begin
                    reg_d2 <= 0;
                    if(reg_d3 == 9)
                        reg_d3 <= 0;
                    else
                        reg_d3 <= reg_d3 + 1;
                end else
                    reg_d2 <= reg_d2 + 1;
            end else
                reg_d1 <= reg_d1 + 1;
        end else
            reg_d0 <= reg_d0 + 1;
    end
end

always @(posedge clock or posedge reset) begin
    if (reset) begin
        // Reset the outputs to 0
        minutes <= 0;
        sec_high <= 0;
        sec_low <= 0;
        tenths <= 0;
    end else if (!start) begin
        // When start is low, hold the latched values
        minutes <= latched_minutes;
        sec_high <= latched_sec_high;
        sec_low <= latched_sec_low;
        tenths <= latched_tenths;
    end else begin
        // When start is high, continue updating the outputs
        minutes <= reg_d3;
        sec_high <= reg_d2;
        sec_low <= reg_d1;
        tenths <= reg_d0;
    end
end

endmodule