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
// Synchronous DAC Controller
// 12-bit Internal Resolution, 8-bit output resolution
//
// Operating Modes:
// Unified Square / Pulse / Sawtooth / Triangle Wave Generator
//            .-----.               .-----.               .-----.        
//           /       \             /       \             /       \       
//          / |    |  \           /         \           /         \       
//         /           \         /           \         /           \       
//        /   |    |    \       /             \       /             \       
//  -----'               '-----'               '-----'               '-----
//       | A |  B  | C  |  D  |
// 
// Value of A, B, C and D should be pre-computed and stored in an LUT
// The amplitude is not explicitly specified. Instead it's controlled by duration
// of the A and C ramps. 
//
// Fast Clock: 384MHz
// Desired chirp interval: 2ms
// Number of cycles usable: 768000 -> 20bits
//
module DACcon(
    input         clk_fast, // Note: The system runs on 384MHz
                            // The reported fmax is smaller than this (282MHz), 
                            // but at room temperature this should be fine.
    input         rst_n,
    input [1:0]   mode,
    input [19:0]  A_hlen,
    input [19:0]  A_hstep,
    input [11:0]  A_vincr,
    input [19:0]  B_hlen,
    input [19:0]  B_hstep,
    input [11:0]  B_vincr,
    input [19:0]  C_hlen,
    input [19:0]  C_hstep,
    input [11:0]  C_vincr,
    input [19:0]  D_hlen,
    input [19:0]  D_hstep,
    input [11:0]  D_vincr,
    output [7:0]  dac_out,
    output [11:0] raw_out
);

    reg [1:0]  ss_r;
    reg [19:0] hcnt_r;
    reg [11:0] vcnt_r;

    assign raw_out = vcnt_r;

    localparam S_A = 2'b00;
    localparam S_B = 2'b01;
    localparam S_C = 2'b11;
    localparam S_D = 2'b10;
    always @(posedge clk_fast or negedge rst_n) begin
        if(~rst_n) begin
            ss_r <= S_A;
            hcnt_r <= 0;       
            vcnt_r <= 0;       
        end else begin
            if (ss_r == S_A) begin
                if(A_hstep + {1'b0, hcnt_r} > {1'b0,A_hlen}) begin
                    // Overflowing, jump to the next state
                    vcnt_r <= 0;
                    hcnt_r <= 0;
                    if(B_hlen!=0)        ss_r <= S_B;
                    else if (C_hlen!=0)  ss_r <= S_C;
                    else if (D_hlen!=0)  ss_r <= S_D;
                    else                 ss_r <= S_A;
                end else begin
                    hcnt_r <= hcnt_r + A_hstep;

                end
            end else if (ss_r == S_B) begin
                
            end else if (ss_r == S_C) begin

            end else if (ss_r == S_D) begin

            end else begin
                // Should never happen
                ss_r <= 2'bxx;
            end
        end
    end

endmodule /* DACcon */
