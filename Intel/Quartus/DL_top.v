
wire tdc_in/*synthesis keep*/;
wire tdc_pulse;
wire tdc_pulse_1;

localparam DELAY = 256;
wire [DELAY-1:0] test;
delayline #(.LENGTH(DELAY)) u_DUT(
    .din (wCLK10),
    .dout(test)
);


dl_platform u_dut(
	.clk10m          (wCLK10),
  .clk10m_dly      (wCLK10),
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

assign bMKR_A[2] = wCLK10;
assign bMKR_A[5] = ~pulse_out;
assign tdc_in = tdc_pulse;
 