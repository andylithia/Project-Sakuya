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
//==============================================================================
// Ring oscillator TDC
// 
// The ring is essentially free-running, calibration is done exclusively in the
//  digital domain.
// A.L. First Version, 2022.10.19
//==============================================================================
module ROTDC#(
	parameter ROLEN_HALF = 126, // 255 stages in total. 
								// GF12 inverter chain delay ~7ps/inv
								// The overall delay should be ~1.5*7ps*255
								// ~373MHz
	parameter COUNTER_LEN = 64
)(
	input       start,      // TDC Start
	input       stop,       // TDC Stop
	input       clk,        // FSM Clock
	input       rst_n,
	output []
	
);



