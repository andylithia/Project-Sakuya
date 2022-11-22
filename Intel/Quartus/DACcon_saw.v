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
// Synchronous DAC Controller - Sawtooth
// 12-bit Internal Resolution, 8-bit output resolution
//
// Operating Modes:
// Unified Square / Pulse / Sawtooth / Triangle Wave Generator
//            /|     /|     /|     /| 
//           / |    / |    / |    / | 
//          /  |   /  |   /  |   /  | 
//         /   |  /   |  /   |  /   | 
//        /    | /    | /    | /    | 
//  -----'     |/     |/     |/     |/
//
// Usage Example:
// Expected output: Full Range, 2ms chirp
// 1.To maximize vertical resolution, set aincr = 1
// 2.Steps needed: (2**12)/aincr = 4096
// 3.Division ratio when the fast clock is 384MHz: (384MHz*2ms)/N_steps= 187.5
// Oops, fractal-N division ratio is not supported yet. It requires another SDM
//
// Falling back to step 1:
// Set aincr = 2
// Steps needed: tlen   = 2048
// Division ratio: tstep = 375
//
module DACcon_saw(
    input         clk_fast,
    input         rst_n,
    input [19:0]  A_len,    // Total number of steps
    input [19:0]  A_tstep,  // Clock-cycle per step
    input [11:0]  A_aincr,  // Vertical increment per step
    output [11:0] out_raw,  //
    output [7:0]  out_sdm,  // Sigma-Delta Dithered Output (8bits)
    output        overflow
);
    // Amplitude 1st order SDM implementation
	reg [3:0]  error_r;
    wire [12:0] SDM = out_raw + error_r;
	reg [8:0]  SDM_out_r; // 1b ovf, 8b data
    assign out_sdm = SDM_out_r;
    always @(posedge clk_fast or negedge rst_n) begin
        SDM_out_r <= SDM[11:4];
        error_r   <= SDM[3:0];      
    end 

    reg [1:0]  ss_r;
    reg [19:0] clkdiv_r;
    reg [19:0] treg_r;
    reg [12:0] areg_r;
    assign overflow = areg_r[12];
    assign out_raw  = areg_r[11:0];

    always @(posedge clk_fast or negedge rst_n) begin
        if(~rst_n) begin
            clkdiv_r <= 0;
            treg_r   <= 0;
            areg_r   <= 0;
        end else begin
            if (clkdiv_r < A_tstep) begin
                clkdiv_r <= clkdiv_r + 1;               
            end else begin
                clkdiv_r <= 0;
                if (treg_r >= A_len) begin
                    treg_r <= 0;
                    areg_r <= 0;
                end else begin  
                    treg_r <= treg_r + 1;
                    areg_r <= areg_r + A_aincr; 
                end
            end
        end
    end

endmodule /* DACcon_saw */