`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// Module Name: Stopwatch
//
// Additional Comments:
// https://simplefpga.blogspot.com/2012/07/to-code-stopwatch-in-verilog.html
//////////////////////////////////////////////////////////////////////////////////

module Stopwatch_TB;

 reg clock;
 reg reset;
 reg start;

 wire [3:0] minutes; // M
 wire [3:0] sec_high; // First S
 wire [3:0] sec_low; // Second S
 wire [3:0] tenths; // d

 Stopwatch uut (
  .clock(clock), 
  .reset(reset), 
  .start(start), 
  .minutes(minutes), 
  .sec_high(sec_high), 
  .sec_low(sec_low), 
  .tenths(tenths)
 );

 initial begin
   clock = 0;
   forever #5 clock = ~clock;
 end

 initial begin
  reset = 1; 
  start = 0;
  #100;      
  reset = 0; 
  #100;      
  start = 1; 
  
  #450;
   
  start = 0;
  #100;
  reset = 1;
  #100;
  reset = 0;
  #100;
  start = 1;
  
  #450;
  
  
  start = 0; 
  #100;
  $stop; 
 end

endmodule

