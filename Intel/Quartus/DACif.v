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
//
// DAC Parallel to Serial Controller
//
module DACif #(
    parameter integer DWIDTH = 8
)(
    input              clk_4M, // Use PLL to adjust the phase of this one when necessary
    input              rst_n,       //
    input [DWIDTH-1:0] din,         // Parallel Data Input
    input              a,           // Address 
    input              DAC_scen,    //
    output             dout         // Serial Data Output
);
    reg [DWIDTH+1:0]           sreg_r;  // Shift register
    reg [1:0]                  SS_r;
    reg [$clog2(DWIDTH+1)-1:0] txcnt_r; // Transmit Counter
    parameter integer S_WAIT_SCEN = 0;  // Wait for SCE to fall
    parameter integer S_TRANSMIT = 1;
    parameter integer S_A = 2;
    parameter integer S_G = 3;

    assign dout = sreg_r[0];

    always @(posedge clk_4M or negedge rst_n) begin
        if(~rst_n) begin
            sreg_r <= 0;
        end else begin
            if(SS_r == S_WAIT_SCEN) begin
                if(~DAC_scen) begin
                    txcnt_r <= 0;
                    SS_r    <= S_TRANSMIT;
                    sreg_r  <= {1'b0, sreg_r[DWIDTH+1:1]};  // Shift Right, LSB Out
                end else begin
                    sreg_r <= {1'b1,a,din};
                end
            end else if (SS_r == S_TRANSMIT) begin
                sreg_r <= {1'b0, sreg_r[DWIDTH+1:1]};       // Shift Right, LSB Out
                if(txcnt_r==16) begin
                    SS_r <= S_A;
                end else begin
                    txcnt_r <= txcnt_r + 1;
                end
            end else if (SS_r == S_A) begin
                sreg_r <= {1'b0, sreg_r[DWIDTH+1:1]};       // Shift Right, LSB Out
                SS_r <= S_G;
            end else if (SS_r == S_A) begin
                sreg_r <= {1'b0, sreg_r[DWIDTH+1:1]};       // Shift Right, LSB Out
                SS_r <= S_WAIT_SCEN;
            end
        end
    end
endmodule /* DACif */
