/*****************************************************************************
 *
 * File:         tracker_fpga.v
 * Description:  Top-level Verilog for 8-inch floppy track signal
 * Author:       Tim Kutscha
 * Created:      07/28/2020
 * Language:     Verilog
 * Package:      N/A
 *
 *****************************************************************************/
`timescale 100ps / 1ps

module tracker_fpga
  (
   // system signals
   input  clk, // 10MHz on-board crystal
   output clk_en_1, // enables 10MHz crystal

   // floppy signals
   input  step, // look at other signals on falling edge
   input  dir, // direction 0=down, 1=up
   input  drivenum, // drive number, only valid when zero
   input  zero_track, // tells us when drive thinks it's at zero (ignore)

   output lower_track // 0=tracks 0-42, 1=tracke 43-76
   );

   // enable 10MHz clock on development board
   assign clk_en_1 = 1;

   // synchronize all inputs to local clock to prevent metastability
   wire   step_sync;
   wire   dir_sync;
   wire   drivenum_sync;

   syncflops sync1 (.clk(clk), .in(step), .out(step_sync));
   syncflops sync2 (.clk(clk), .in(dir), .out(dir_sync));
   syncflops sync3 (.clk(clk), .in(drivenum), .out(drivenum_sync));

   // detect falling edge of step signal
   reg    step_dly;
   wire   step_falling;

   always @(posedge clk) step_dly <= step_sync; // register delay

   assign step_falling = ~step_sync && step_dly; // detect falling edge
   
   // adjust counter based on input
   reg [7:0] tctr=8'd0; // reset for simulation
   always @(posedge clk)
     // only do something if drivenum is zero on a falling step
     if(step_falling && ~drivenum_sync)
       begin
          // count up if less than 76
          if     (dir_sync && (tctr < 8'd76)) tctr <= tctr + 8'd1;
          // count down if greater than zero
          else if(~dir_sync && (tctr > 8'd0)) tctr <= tctr - 8'd1;
       end

   // drive track signal based on counter
   assign lower_track = (tctr < 8'd43); // 1 for 0-42, 0 for 43-76

   // TODO: decode tctr to drive 7-segment display or LEDs

endmodule
