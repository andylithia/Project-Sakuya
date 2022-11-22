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

// Generic Synchronous SPWM Generator
// 12-bit Resolution
module SPWM12 (
    input         clk,
    input         rst_n,
    input  [15:0] x0,         // Prescale Value
    // 32768/1.646760258 = 1.0
    input  [19:0] increment,
    output        pwm_out,
    output        pwm_async,
    output        PWM_grant
);

  // Clock Divider
  localparam DIVLEN = 6;  // divide by 32
  reg [DIVLEN-1:0] clkdiv_r;
  wire clk_slow = clkdiv_r[DIVLEN-1];
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) clkdiv_r <= 0;
    else clkdiv_r <= clkdiv_r + 1;
  end

  localparam DIN_WIDTH = 20;
  localparam DOUT_WIDTH = 17;
  localparam PWM_WIDTH = 10;

  reg         [ DIN_WIDTH-1:0] cordic_input_r;
  wire signed [DOUT_WIDTH-1:0] sine;  // 17-bit signed fixed-point

  CORDIC u_CORDIC (
      .clk   (clk_slow),
      .z0    ({cordic_input_r, 12'b0}),
      .x0    (x0),
      .y0    (16'd0),
      .xout_r(sine),
      .yout_r()
  );

  // The CORDIC module has a pipeline delay of 16-clocks;
  // 
  wire signed [DOUT_WIDTH-1:0] sine_zerobias = sine + ((2 ** (DOUT_WIDTH - 2)));  // remove bias
  // reg  [PWM_WIDTH-1:0] sine_zerobias_r;
  reg [PWM_WIDTH-1:0] sine_zerobias_r1;
  reg [6:0] error_r;
  reg [8:0] SDM_lsb_r;  // 1b ovf, 8b  data
  reg [9:0] SDM_msb_r;  // 1b ovf, 9b  data 
  wire [17:0] SDM_out = {SDM_msb_r + SDM_lsb_r[8], SDM_lsb_r[7:0]};
  reg [10:0] SDM_out_r;  // 1b ovf, 10b data
  // wire PWM_grant;
  localparam CYCLE_FACTOR = (2 ** DIVLEN) * 16;

  reg [$clog2(CYCLE_FACTOR):0] SS_r;  // CORDIC control FSM
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      SS_r <= 0;
      cordic_input_r <= 0;
    end else begin
      if (SS_r == CYCLE_FACTOR - 1) begin
        SS_r <= SS_r + 1;
        cordic_input_r <= cordic_input_r + increment;
        // sine_zerobias_r <= sine_zerobias[DOUT_WIDTH-1:DOUT_WIDTH-PWM_WIDTH]*2;
        SDM_lsb_r <= {1'b0, sine_zerobias[7:0]} + error_r;
        SDM_msb_r <= {1'b0, sine_zerobias[16:8]};
      end else if (SS_r == CYCLE_FACTOR) begin
        SS_r <= SS_r + 1;
        SDM_out_r <= SDM_out[17:7];
        error_r <= SDM_out[6:0];
      end else if (SS_r == CYCLE_FACTOR + 1) begin
        // Wait for PWM grant
        if (PWM_grant) begin
          SS_r <= 0;
          sine_zerobias_r1 <= SDM_out_r;
        end else begin
          SS_r <= SS_r;
        end
      end else begin
        SS_r <= SS_r + 1;
      end
    end
  end

  reg [PWM_WIDTH-1:0] cnt_r;
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) cnt_r <= 0;
    else cnt_r <= cnt_r + 1;
  end
  assign PWM_grant = cnt_r == 0;
  assign pwm_out   = sine_zerobias_r1 > cnt_r;

endmodule  /* SPWM */
/* vim: set ts=4 sw=4 noet */
