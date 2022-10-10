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

// Delayline Toplevel

module dl_platform (
    input    clk10m,    // 10 MHz Fast Clock
    input    rst_n,     // Global Reset
    input    tdc_start, // external
    input    tdc_stop,  // external
    output   tdc_pulse, // going out
    output   txd,       // UART TX
    output   txdone     // 
);

parameter TARGET_FREQ  = 30;
localparam SYSTEM_FREQ = 10000000;
localparam HALF_DIV    = (SYSTEM_FREQ/TARGET_FREQ/2);

reg [$clog2(HALF_DIV):0] clkdiv_r;      // 
reg                      clk_slow_r;    // 30 Hz Slow Clock

always @(posedge clk10m or negedge rst_n) begin
    if(~rst_n) begin
        clkdiv_r <= 0;
    end else begin
        if(clkdiv_r == HALF_DIV) begin
            clkdiv_r <= 0;
            clk_slow_r <= 1;
        end else begin
            clkdiv_r <= clkdiv_r + 1;
            clk_slow_r <= 0;
        end
    end
end

// Sending data to the MCU
uart_tx #(.CLKS_PER_BIT(10000000/115200)) u_DTX(
    .i_Clock     (clk10m),
    .i_Tx_DV     (clk_slow_r),
    .i_Tx_Byte   (8'hAA),
    .o_Tx_Active (),
    .o_Tx_Serial (txd),
    .o_Tx_Done   (txdone)
);


endmodule /* dl_platform */

