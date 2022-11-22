#!/bin/bash
iverilog -Wall -o fracdiv_tb.vvp ../fracdiv.v ../sdm1b.v ./fracdiv_tb.v ../lfsr_prbs_gen.v ../lfsr.v
vvp fracdiv_tb.vvp
gtkwave fracdiv_tb.vcd fracdiv_tb.gtkw