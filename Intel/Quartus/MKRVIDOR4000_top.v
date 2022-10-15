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

localparam DELAY = 256;
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


localparam SELECT_RATIO = 8;
genvar gi;
wire [DELAY/SELECT_RATIO-1:0] pulse_select; // Selecting 32 lines from the 256 taps

generate
  for(gi=0;gi<(DELAY/SELECT_RATIO);gi=gi+1) begin : gen_pulse_select
    assign pulse_select[gi] = test[SELECT_RATIO*(gi+1)-1];
  end
endgenerate

// Implement 2:1 mux tree explicitly

wire [15:0] mux_level0/* synthesis keep */;
wire [7:0]  mux_level1/* synthesis keep */;
wire [3:0]  mux_level2/* synthesis keep */;
wire [1:0]  mux_level3/* synthesis keep */;
wire        mux_level4/* synthesis keep */;
wire pulse_out;
assign pulse_out = mux_level4;
generate
  for(gi=0;gi<16;gi=gi+1) begin : gen_muxl0
    assign mux_level0[gi] = select_r[0]?pulse_select[2*gi+1]:pulse_select[2*gi];
  end
  for(gi=0;gi<8;gi=gi+1) begin : gen_muxl1
    assign mux_level1[gi] = select_r[1]?mux_level0[2*gi+1]:mux_level0[2*gi];
  end
  for(gi=0;gi<4;gi=gi+1) begin : gen_muxl2
    assign mux_level2[gi] = select_r[2]?mux_level1[2*gi+1]:mux_level1[2*gi];
  end
  for(gi=0;gi<2;gi=gi+1) begin : gen_muxl3
    assign mux_level3[gi] = select_r[3]?mux_level2[2*gi+1]:mux_level2[2*gi];
  end
endgenerate
assign mux_level4 = select_r[4]?mux_level3[1]:mux_level3[0];

/*
mux32_1 u_mux(
  .sel(select_r),
  .result (pulse_out),
  .data0    (test[7]),
  .data1    (test[15]),
  .data2    (test[23]),
  .data3    (test[31]),
  .data4    (test[39]),
  .data5    (test[47]),
  .data6    (test[55]),
  .data7    (test[63]),
  .data8    (test[71]),
  .data9    (test[79]),
  .data10   (test[87]),
  .data11   (test[95]),
  .data12   (test[103]),
  .data13   (test[111]),
  .data14   (test[119]),
  .data15   (test[127]),
  .data16   (test[135]),
  .data17   (test[143]),
  .data18   (test[151]),
  .data19   (test[159]),
  .data20   (test[167]),
  .data21   (test[175]),
  .data22   (test[183]),
  .data23   (test[191]),
  .data24   (test[199]),
  .data25   (test[207]),
  .data26   (test[215]),
  .data27   (test[223]),
  .data28   (test[231]),
  .data29   (test[239]),
  .data30   (test[247]),
  .data31   (test[255])
);
*/
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
