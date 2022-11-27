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
// An Example DAC Instance 
// Usage:
//      `include "dac_example.v"

module dac_example;
    // Master Clock _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
    // Reset        --__------------------------------
    // 0x00         __________________----------------
    // 0x01         ________________----------------__
    // 0x02         ______________----------------____
    // 0x03         ____________----------------______
    // 0x04         __________----------------________
    // 0x05         ________----------------__________
    // 0x06         ______----------------____________
    // 0x07         ____----------------______________
    // 0x08         __----------------________________
    // 0x09         __--------------________________--
    // 0x0A         __------------________________----
    // 0x0B         __----------________________------
    // 0x0C         __--------________________--------
    // 0x0D         __------________________----------
    // 0x0E         __----________________------------
    // 0x0F         __--________________--------------
    // 0x0F         __________________----------------
    // Emulate the SCEn signal (which is inside the chip)
    // To provide accurate alignment, the user can change the position by 
    // changing the _preload value

    // Settings
    parameter [3:0] SCEN_SELECT_PRELOAD = 4'b0000;
    parameter [0:0] DAC_A               = 1'b1;

    wire clk_64M;
    wire clk_4M;
    wire rst_n;
    wire dac_sdo;

    // Internally generated DAC_SCEn
    reg  [3:0] SCEn_select_cnt_r;
    wire       SCEn_generated = ~SCEn_select_cnt_r[3];
    always @(posedge clk_4M or negedge rst_n) begin
        if(~rst_n) SCEn_select_cnt_r <= SCEN_SELECT_PRELOAD;
        else       SCEn_select_cnt_r <= SCEn_select_cnt_r + 1'b1;
    end

    // DAC Interface Instance
    wire [7:0] dac_data;
    DACif u_DACif(
        .clk_4M   (clk_4M),
        .rst_n    (rst_n),
        .din      (dac_data),
        .a        (DAC_A),
        .DAC_scen (SCEn_generated),
        .dout     (dac_sdo)
    );

    // Sawtooth generator
    // aincr = 16
    // Steps needed:   (2**12)/aincr = 256
    // Division ratio: (64MHz*2ms)/N_steps = 500
    wire [11:0] dac_out_raw;
    assign dac_data = dac_out_raw[11:4];
    DACcon_saw u_sawgen(
        .clk_fast (clk_64M),
        .rst_n    (rst_n),
        .A_len    (256),
        .A_tstep  (500),
        .A_aincr  (16),
        .out_raw  (dac_out_raw),
        .out_sdm  (),
        .overflow ()
    );

endmodule

