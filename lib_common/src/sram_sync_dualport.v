/*****************************************************************************
*
* File:         sram_sync_dualport.v
* Description:  generic dual-port synchronous SRAM for FPGA inferrence
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
module sram_sync_dualport
  (
   input clk,

   input we_a,
   input [(ADDR_WIDTH-1):0] addr_a,
   input [(DATA_WIDTH-1):0] data_a,
   output reg [(DATA_WIDTH-1):0] q_a,

   input we_b,
   input [(ADDR_WIDTH-1):0] addr_b,
   input [(DATA_WIDTH-1):0] data_b,
   output reg [(DATA_WIDTH-1):0] q_b
   );

   parameter DATA_WIDTH = 8;
   parameter ADDR_WIDTH = 6;

   // Declare the RAM variable
   reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

   always @ (posedge clk)
     begin // Port A
        if (we_a)
          begin
             ram[addr_a] <= data_a;
             q_a <= data_a;
          end
        else
          q_a <= ram[addr_a];
     end

   always @ (posedge clk)
     begin // Port b
        if (we_b)
          begin
             ram[addr_b] <= data_b;
             q_b <= data_b;
          end
        else
          q_b <= ram[addr_b];
     end

endmodule // sram_sync_dualport
