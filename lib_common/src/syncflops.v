/*****************************************************************************
*
* File:         syncflops.v
* Description:  synchronizes external signals to internal clock with flops
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
******************************************************************************/
`timescale 100ps / 1ps
module syncflops #(parameter BITS=1)
(
 input clk,
 input [BITS-1:0] in,
 output reg [BITS-1:0] out
);

   reg  [BITS-1:0] sync1;

   // synchronize incoming signal
   always @(posedge clk)
     begin
        sync1 <= in;
        out   <= sync1;
     end
endmodule        
