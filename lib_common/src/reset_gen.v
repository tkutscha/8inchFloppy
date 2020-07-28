/*****************************************************************************
 *
 * File:         reset_gen.v
 * Description:  reset generator for FPGA parts (active-low)
 * Author:       Tim Kutscha
 * Created:      01/04/2017
 * Language:     Verilog
 * Package:      N/A
 *
 * (C) Copyright 2017, Simplexity Product Development, all rights reserved.
 *
 *  Date    By  Modification
 *-------- ---- ---------------------------------------------------------------
 *01/04/17 TNK   Initial version
 *02/16/17 TNK   Set initial value for simulation
 *****************************************************************************/
`timescale 1ns / 1ps
module reset_gen
  (
   input            clk,
   output           reset_n
   );
   
   // assume FPGA registers all start at zero
   reg [63:0]       rst=64'd0;

   always @(posedge clk)  rst <= {rst[62:0],1'b1};

   // drive 0 until 1 shifts to top bit
   assign reset_n = rst[63];

endmodule
