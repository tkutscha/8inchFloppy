#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 12.1 Build 243 01/31/2013 Service Pack 1 SJ Web Edition
#
#************************************************************

# Copyright (C) 1991-2012 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

# main incoming clock is 50 MHz
create_clock -name "clk_main" -period 20.000ns [get_ports {clk}] -waveform {0.000 10.000}

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# tsu/th constraints
set_input_delay -clock clk_main 4.0ns [all_inputs]
set_output_delay -clock clk_main 0.0ns [all_outputs]

# tco constraints

# tpd constraints

# false paths
