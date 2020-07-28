/*****************************************************************************
*
* File:         tracker_tb.v
* Description:  Block-level testbench for 8-inch floppy track counter
* Author:       Tim Kutscha
* Created:      07/28/2020
* Language:     Verilog
* Package:      N/A
*
*  Date    By  Modification
*-------- ---- ---------------------------------------------------------------
*07/28/20 TNK   Initial version
******************************************************************************/
`timescale 1ns / 100ps
module tracker_tb;
   
   // iterator for simulation
   integer i;

   // inputs
   reg step;
   reg dir;
   reg drivenum;
   reg zero_track;

   // outputs
   wire lower_track;

   // system clock
   reg clk10;

   // instantiate tracker FPGA
   tracker_fpga fpga
     (
      .clk(clk10),
      .step(step),
      .dir(dir),
      .drivenum(drivenum),
      .zero_track(zero_track),
      .lower_track(lower_track)
      );

   // initial defaults
   initial
     begin
        clk10 <= 0;
        step <= 0;
        dir <= 0;
        drivenum <= 0;
        zero_track <= 0;
     end

   // 10MHz clock generator
   always #(50)
     begin
        clk10 <= ~clk10;
     end

   // primary testbench to stimulate system
   initial
     begin
        $dumpfile("dump_tracker.vcd");
        $dumpvars;

        

        
        $finish;
     end
                
endmodule

