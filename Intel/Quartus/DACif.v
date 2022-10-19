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

// DAC controller
// Operating Modes:
// 
module DACif#(
	parameter DWIDTH = 8
)(  
	// input        clk10m,    // System Clock, used for counting - wave generation
	input               rst_n,    // Global Reset
	input [1:0]         opmode,   // 00: triangle wave
								  // 01: sawtooth
	                              // 10: square wave
	                              // 11: pulse
	input [DWIDTH-1:0]  stepsize,  // Does not support fractal-N
	                               // The non-integer division noise can't be removed
	output              chirp_n,   //
	// 
	input               dclk,      // Device Interface Clock
	input               dce_n,     // Device Latch Signal, from the device's internal divider 
	output [DWIDTH-1:0] dout       // Device Parallel Data
);
	
	reg            up_dn_r;
	reg [DWIDTH:0] cnt_r;
	always@(negedge dce_n or negedge rst_n) begin
		if(~rst_n) begin
			up_dn_r <= 0;
			cnt_r   <= 0;
		end else begin
			if (cnt[DWIDTH]) begin
				// Overflow, wrapback
				up_dn_r <= ~up_dn_r;
				if(up_dn_r) cnt_r <= cnt_r - stepsize;
				else        cnt_r <= cnt_r + stepsize;
			end else begin
				if(up_dn_r) cnt_r <= cnt_r + stepsize;
				else        cnt_r <= cnt_r - stepsize;
			end
		end
	end
	
	reg [DWIDTH-1:0] out_sr;
	always @(negedge dclk or negedge rst_n) begin
		if(~rst_n) begin 
			out_sr <= 0;
		end else begin
			if(~dce_n) out_sr <= cnt_r;
			else       out_sr <= {1'bx, out_sr[DWIDTH-1:1]};
		end
	end
	
	assign dout = out_sr[0];
	

endmodule /* DACif */
/* vim: set ts=4 sw=4 noet */
