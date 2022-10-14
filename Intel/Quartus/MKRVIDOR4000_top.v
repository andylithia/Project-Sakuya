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
  .c0    (wCLK10),
  .c1    (wCLK10_dly),
  .c2    (wCLK480),
  .locked());
  
wire tdc_in/*synthesis keep*/;
wire tdc_pulse;
wire tdc_pulse_1;

localparam DELAY = 32;
wire [DELAY-1:0] test;
delayline #(.LENGTH(DELAY)) u_DUT(
    .din (wCLK10_dly),
    .dout(test)
);


dl_platform u_dut(
	.clk10m          (wCLK10),
  .clk10m_dly      (wCLK10_dly),
	.rst_n           (iRESETn),
	.tdc_start       (wCLK10_dly),
  .tdc_stop        (~test[DELAY-1]),
	.clk_sampling    (tdc_pulse),
  // .clk_sampling_dly(tdc_pulse_1),
	.txd             (mcu_rx),
  .txdone          (txdone)
);

reg [$clog2(DELAY)-1:0] select_r/*synthesis keep*/;
always @(posedge tdc_pulse or negedge iRESETn) begin
  if(~iRESETn) select_r <= 0;
  else         select_r <= select_r + 1;
end

wire pulse_out;

mux32_1 u_mux(
  .sel(select_r),
  .result (pulse_out),
  .data0    (test[0]),
  .data1    (test[1]),
  .data2    (test[2]),
  .data3    (test[3]),
  .data4    (test[4]),
  .data5    (test[5]),
  .data6    (test[6]),
  .data7    (test[7]),
  .data8    (test[8]),
  .data9    (test[9]),
  .data10   (test[10]),
  .data11   (test[11]),
  .data12   (test[12]),
  .data13   (test[13]),
  .data14   (test[14]),
  .data15   (test[15]),
  .data16   (test[16]),
  .data17   (test[17]),
  .data18   (test[18]),
  .data19   (test[19]),
  .data20   (test[20]),
  .data21   (test[21]),
  .data22   (test[22]),
  .data23   (test[23]),
  .data24   (test[24]),
  .data25   (test[25]),
  .data26   (test[26]),
  .data27   (test[27]),
  .data28   (test[28]),
  .data29   (test[29]),
  .data30   (test[30]),
  .data31   (test[31])
);

assign bMKR_A[2] = wCLK10;
assign bMKR_A[3] = wCLK10_dly;
assign bMKR_A[4] = wCLK10_dly;
assign bMKR_A[5] = ~pulse_out;
// assign bMKR_A[5] = ~test[select_r];
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
