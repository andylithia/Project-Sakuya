#!/bin/bash
iverilog -Wall -o sdm1b_tb.vvp ../sdm1b.v ./sdm1b_tb.v ../lfsr_prbs_gen.v ../lfsr.v
vvp sdm1b_tb.vvp
gtkwave sdm1b_tb.vcd sdm1b_tb.gtkw