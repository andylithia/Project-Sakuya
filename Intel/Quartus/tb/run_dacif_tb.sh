#!/bin/bash
iverilog -Wall -o dacif_tb.vvp ../DACif.v ./dacif_tb.v 
vvp dacif_tb.vvp
gtkwave dacif_tb.vcd dacif_tb.gtkw