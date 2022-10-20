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
// 
module SPWM (
	input               clk,
	input               rst_n,
	input [15:0]        x0,         // Prescale Value
									// 32768/1.646760258 = 1.0
									// 
	input [15:0]        increment,
	output              pwm_out,
	output              pwm_async
);
	localparam DIN_WIDTH = 20;
	localparam PWM_WIDTH = 17;
	reg [DIN_WIDTH-1:0]              cordic_input_r;
	signed wire [PWM_WIDTH-1:0]      sine; // 17-bit signed fixed-point
	CORDIC u_CORDIC(
		.clk    (clk),
		.z0     (cordic_input_gated),
		.x0     (x0),
		.y0     (16'd0),
		.xout_r (sine),
		.yout_r ()
	);

	// The CORDIC module has a pipeline delay of 16-clocks;
	// 
	unsigned wire [PWM_WIDTH:0] sine_zerobias = sine + (2**(PWM_WIDTH-1)); // remove bias
	unsigned reg  [PWM_WIDTH:0] sine_zerobias_r;

	wire PWM_grant;

	reg [4:0] SS_r; // CORDIC control FSM
	always@ (posedge clk or negedge rst_n) begin
		if(~rst_n) SS_r <= 0;
		else begin
			if(SS_r==5'd15) begin
				SS_r <= SS_r + 1;
				cordic_input_r  <= cordic_input_r + increment;
				sine_zerobias_r <= sine_zerobias;
			end else if (SS_r==5'd16)begin
				// Wait for PWM grant
				if(PWM_grant) SS_r <= 0;
				else          SS_r <= SS_r;
			end else begin
				SS_r <= SS_r + 1;
			end
		end
	end 


	reg [DWIDTH-1:0] cnt_r;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) cnt_r <= 0;
		else       cnt_r <= cnt_r + 1;
	end
	assign PWM_grant = cnt_r == 0;
	assign pwm_out = sine_zerobias_r > cnt_r;

endmodule /* PWM */
/* vim: set ts=4 sw=4 noet */
