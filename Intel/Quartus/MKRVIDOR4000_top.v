// MIT License
// 
// Copyright (c) 2022 andylithia
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

module MKRVIDOR4000_top
(
  // system signals
  input         iCLK,
  input         iRESETn,
  input         iSAM_INT,
  output        oSAM_INT,
  
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
  .c0    (wCLK480),
  // .c0    (wCLK10),
  // .c1    (wCLK10_dly),
  // .c2    (wCLK480),
  .locked());

wire pwm_out;
SPWM12 u_SPWM12(
  .clk(wCLK480),
  .rst_n(iRESETn),
  .x0(19432),
  // .increment(8192),
  .increment((2**20)/4),
  .pwm_out(pwm_out)
);

assign bMKR_A[4] = pwm_out;



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
