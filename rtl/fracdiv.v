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
// Fractal Frequency Divider
// Divide Ratio is 2*(M+1)/((2**NLEN)/N)
// New divider ratio are loaded each cycle
//
module fracdiv#(
    parameter MLEN = 16,
    parameter NLEN = 16
)(
    input clk_fast,
    input rst_n,
    input [MLEN-1:0] m,
    input [NLEN-1:0] n,
    output clk_out
);

    reg [MLEN-1:0] m_r;
    reg [NLEN-1:0] n_r;
    wire sdm_bit;
    sdm1b #(.W(NLEN),.ADD_NOISE(1)) u_sdm(
        .clk_fast(clk_fast),
        .rst_n   (rst_n   ),
        .din     (n_r     ),
        .error   (        ),
        .dout    (sdm_bit )
    );

    reg [MLEN-1:0] acc_r;
    reg            clk_out_r;
    assign clk_out = clk_out_r;
    always @(posedge clk_fast or negedge rst_n) begin
        if(~rst_n) begin
            acc_r     <= 0;
            clk_out_r <= 0;
            m_r       <= 0;
            n_r       <= 0;
        end else begin
            if(sdm_bit) begin 
                if(acc_r>=m_r) begin
                    acc_r <= 0;
                    clk_out_r <= ~clk_out_r;
                end else begin
                    acc_r <= acc_r + 1;
                end
            end
            m_r <= m;
            n_r <= n;
        end
    end

endmodule /* fracdiv */
