#!/bin/bash
iverilog -Wall -o sdm1b_tb.vvp ../sdm1b.v ./sdm1b_tb.v
vvp sdm1b_tb.vvp
gtkwave sdm1b_tb.vcd sdm1b_tb.gtkw