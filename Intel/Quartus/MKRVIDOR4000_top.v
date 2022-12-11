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
wire locked;
// system PLL
SYSTEM_PLL PLL_inst(
  .areset(1'b0),
  .inclk0(wCLK48),
  .c0    (wCLK480),
  // .c0    (wCLK10),
  // .c1    (wCLK10_dly),
  // .c2    (wCLK480),
  .locked(locked));

  wire       rxdv;
  wire [7:0] rxd;
  uart_rx #(.CLKS_PER_BIT(48000000/9600)) u_rx(
    .i_Clock     (wCLK48),
    .i_Rx_Serial (mcu_tx),
    .o_Rx_DV     (rxdv  ),
    .o_Rx_Byte   (rxd   )
  );

  reg       txdv_r;
  reg [7:0] txd_r;
  wire       txdone;
  uart_tx #(.CLKS_PER_BIT(48000000/9600)) u_tx(
    .i_Clock     (wCLK48),
    .i_Tx_DV     (txdv_r),
    .i_Tx_Byte   (txd_r ),
    .o_Tx_Active (      ),
    .o_Tx_Serial (mcu_rx),
    .o_Tx_Done   (txdone)
  );


  localparam N = 128;
  wire latch_clock;
  wire [N-1:0] dout;
  reg  [N-1:0] dout_r /*synthesis keep*/;
  reg  [N-1:0] dout_r1 /*synthesis keep*/; // Synchronizer
  wire [N-1:0] dout_dummy/*synthesis keep*/;
  wire [$clog2(N)-1:0] dout_mux_sel; // 7bits
  wire dout_mux;

  /*
  reg [7:0] sr;
  reg [7:0] srr;
  wire srclk    = bMKR_D[2];
  #wire srlatch  = bMKR_D[1];
  wire srdin    = bMKR_D[0];

  assign dout_mux_sel = srr[6:0];

  always @(posedge srclk) begin
    if(srlatch) srr <= sr;
    else        sr <= {sr, srdin};
  end

  */
  reg [23:0] s_cnt_r; // Count to 2^24=16,777,216
                      // Clk div by 48e6/(2^24)=2.861023 Hz
  reg [23:0] cnt_r;   //

  reg [7:0] srr;
  always @(posedge wCLK48) begin
    if(rxdv) srr <= rxd;
  end

  mux8_pyMUX8 u_dout_mux(
    .A(dout_r1),
    .S(dout_mux_sel),
    .Y(dout_mux)
  );

  always @(posedge wCLK48) begin
    if(s_cnt_r==0) begin
      // Done, Emit
      cnt_r <= 0;
      txd_r  <= cnt_r;
      txdv_r <= 0;
    end else begin
      if(dout_mux==1'b1) cnt_r <= cnt_r + 1'b1;
      txdv_r <= 0;
    end
  end

  delayline #(.LENGTH(N)) u_DUT(.din(wCLK48),.dout(dout));
  always @(posedge wCLK48) begin
    dout_r <= dout;
    dout_r1 <= dout_r;
  end

  assign dout_dummy = ~dout_r;
  assign bMKR_A[6] = &dout_r;
  assign bMKR_A[5] = dout_mux;

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
