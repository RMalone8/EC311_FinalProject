`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// Module Name: Stopwatch
//
// Additional Comments:
// https://simplefpga.blogspot.com/2012/07/to-code-stopwatch-in-verilog.html
//////////////////////////////////////////////////////////////////////////////////

module Stopwatch_TB;

 // Inputs
 reg clock;
 reg reset;
 reg start;

 // Outputs
 wire [3:0] minutes; // M
 wire [3:0] sec_high; // First S
 wire [3:0] sec_low; // Second S
 wire [3:0] tenths; // d

 // Instantiate the Unit Under Test (UUT)
 Stopwatch uut (
  .clock(clock), 
  .reset(reset), 
  .start(start), 
  .minutes(minutes), 
  .sec_high(sec_high), 
  .sec_low(sec_low), 
  .tenths(tenths)
 );

 // Generate a clock with a period of 10 ns (100 MHz)
 initial begin
   clock = 0;
   forever #5 clock = ~clock; // 100 MHz Clock
 end

 // Initialize and start the stopwatch
 initial begin
  // Initialize Inputs
  reset = 1; // Assert reset
  start = 0; // Ensure start is not asserted
  #100;      // Wait for 100 ns
  reset = 0; // Deassert reset
  #100;      // Wait for 100 ns
  start = 1; // Assert start to begin the stopwatch

  // Let the simulation run for slightly over 100 ms, which is enough for the ticker to overflow.
  // Since the clock period is 10 ns, we'll wait 100,000,000 ns + a little extra.
  #450; // 100.01 ms at 100 MHz
  
  //latch 
  start = 0;
  #100;
  reset = 1;
  #100;
  reset = 0;
  #100;
  start = 1;
  
  #450;
  
  
  start = 0; // Stop the stopwatch
  #100;
  $stop; // Stop the simulation
 end

endmodule

