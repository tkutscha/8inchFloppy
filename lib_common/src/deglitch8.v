/*****************************************************************************
 * File:         deglitch8.v
 * Description:  generic deglitch module with 8-bit counter to save logic
 * Author:       Tim Kutscha
 * Created:      02/27/2017
 * Language:     Verilog
 * Package:      N/A
 * (C) Copyright 2017, Simplexity Product Development, all rights reserved.
 *
 *  Date    By  Modification
 *-------- ---- ---------------------------------------------------------------
 *02/27/17 TNK   Initial version copied from deglitch16
 *****************************************************************************/
`timescale 100ps / 1ps

module deglitch8
  (
   input      clk,
   input      reset_n,
   input      in,
   output reg out
   );

   // default deglitch is 5 clock cycles
   parameter FILTER_TIME = 8'd5;

   reg [7:0] counter; 
   reg       sig_dly;
   reg       sig_sync;

   // synchronize incoming signal to local clock
   always @(posedge clk or negedge reset_n)
     if (!reset_n)
       begin
          sig_dly  <= 1'b0;
          sig_sync <= 1'b0;
       end  
     else
       begin
          sig_dly  <= in;
          sig_sync <= sig_dly;
       end

   //*******************************************************
   // increment counter to filter time if incoming signal is
   //  different from saved state
   //*******************************************************
   always @(posedge clk or negedge reset_n)
     if (~reset_n)
       begin
          counter  <= 8'd0;
          out      <= 1'b0;
       end
   // incoming signal is the same as the current output
   // so reset counter
     else if (sig_sync == out)
       begin
          counter <= 8'd0;
       end
   // incoming signal is different, so start counting up
     else if (counter < FILTER_TIME)
       begin
          counter <= counter + 8'd1;
       end
   // signal is different and stable for FILTER_TIME, so
   // flip the output and reset the counter
     else
       begin
          counter <= 8'd0;
          out     <= sig_sync;
       end

endmodule
