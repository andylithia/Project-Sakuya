/*
* Copyright 2018 ARDUINO SA (http://www.arduino.cc/)
* This file is part of Vidor IP.
* Copyright (c) 2018
* Authors: Dario Pennisi
*
* This software is released under:
* The GNU General Public License, which covers the main part of 
* Vidor IP
* The terms of this license can be found at:
* https://www.gnu.org/licenses/gpl-3.0.en.html
*
* You can be released from the requirements of the above licenses by purchasing
* a commercial license. Buying such a license is mandatory if you want to modify or
* otherwise use the software for commercial activities involving the Arduino
* software without disclosing the source code of your own applications. To purchase
* a commercial license, send an email to license@arduino.cc.
*
*/

module MKRVIDOR4000_top
(
  // system signals
  input         iCLK,
  input         iRESETn,
  input         iSAM_INT,
  output        oSAM_INT,
  
  // SDRAM
  /*
  output        oSDRAM_CLK,
  output [11:0] oSDRAM_ADDR,
  output [1:0]  oSDRAM_BA,
  output        oSDRAM_CASn,
  output        oSDRAM_CKE,
  output        oSDRAM_CSn,
  inout  [15:0] bSDRAM_DQ,
  output [1:0]  oSDRAM_DQM,
  output        oSDRAM_RASn,
  output        oSDRAM_WEn,
  */

  // SAM D21 PINS
  inout         bMKR_AREF,
  output  [6:0]  bMKR_A,
  input  [12:0]  bMKR_D,
  input          mcu_tx,
  output         mcu_rx

);

wire wCLK10;
wire wCLK10_dly;

assign wCLK48      = iCLK;
// system PLL
SYSTEM_PLL PLL_inst(
  .areset(1'b0),
  .inclk0(wCLK48),
  .c0    (wCLK10),
  .c1    (wCLK10_dly),
  .c2    (wCLK480),
  .locked());
  
wire tdc_in/*synthesis keep*/;
  
dl_platform u_dut(
	.clk10m          (wCLK10),
  .clk10m_dly      (wCLK10_dly),
	.rst_n           (iRESETn),
	.tdc_start       (tdc_in),
	.clk_sampling    (tdc_pulse),
  .clk_sampling_dly(tdc_pulse_1),
	.txd             (mcu_rx),
  .txdone          (txdone)
);
  
assign bMKR_A[2] = wCLK10;
assign bMKR_A[3] = wCLK10_dly;
assign bMKR_A[4] = tdc_pulse;
assign bMKR_A[5] = tdc_pulse_1;
// assign tdc_in    = bMKR_D[5];
assign tdc_in = tdc_pulse;

// signal declaration
/*
wire        wOSC_CLK;

wire        wCLK8,wCLK24, wCLK64, wCLK120;

wire [31:0] wJTAG_ADDRESS, wJTAG_READ_DATA, wJTAG_WRITE_DATA, wDPRAM_READ_DATA;
wire        wJTAG_READ, wJTAG_WRITE, wJTAG_WAIT_REQUEST, wJTAG_READ_DATAVALID;
wire [4:0]  wJTAG_BURST_COUNT;
wire        wDPRAM_CS;

wire [7:0]  wDVI_RED,wDVI_GRN,wDVI_BLU;
wire        wDVI_HS, wDVI_VS, wDVI_DE;

wire        wVID_CLK, wVID_CLKx5;
wire        wMEM_CLK;

assign wVID_CLK   = wCLK24;
assign wVID_CLKx5 = wCLK120;
assign wCLK8      = iCLK;

// internal oscillator
cyclone10lp_oscillator   osc
  ( 
  .clkout(wOSC_CLK),
  .oscena(1'b1));

// system PLL
SYSTEM_PLL PLL_inst(
  .areset(1'b0),
  .inclk0(wCLK8),
  .c0(wCLK24),
  .c1(wCLK120),
  .c2(wMEM_CLK),
   .c3(oSDRAM_CLK),
  .c4(wFLASH_CLK),
   
  .locked());


reg [5:0] rRESETCNT;


`include "user.v"

always @(posedge wMEM_CLK)
begin
  if (!rRESETCNT[5])
  begin
  rRESETCNT<=rRESETCNT+1;
  end
end
*/

/* 	input clk,
	input [4:0] din,
	input latch,
	input pulse,
	input clk_smp,
	output [4:0] dat_smp);
	*/

	
//wire loe/*synthesis keep*/;
//wire hoe/*synthesis keep*/;
//wire [127:0] f_din;
//wire [127:0] f_dout1/*synthesis keep*/;
//wire [127:0] f_dout;
//assign f_din = {128{1'b1}};
//assign bMKR_A[4:0] = f_dout1[127-:5];

//always @ (posedge iCLK) begin
//	f_dout1 <= f_dout;
//end

//delayline #(.LENGTH(128)) dut(.din(f_din[0]),.dout(f_dout));

/*
fudge f1(
	.clk(bWM_PIO31),
	.din(f_din),
	.latch(bWM_PIO27),
	.pulse(bWM_PIO28),
	.clk_smp(bWM_PIO29),
	.dat_smp(f_dout)
);
*/

endmodule
