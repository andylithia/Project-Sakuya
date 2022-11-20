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

// HCMS2904 LED controller module

module HCMS29xx #(
    parameter N = 2,            // No. of display units installed
    parameter UNIT_W = 20,      // Unit width,  no unused ones
    parameter UNIT_H = 8,       // Unit height, with 1 bit unused per vline.
    parameter ITD_RATIO = 10    // Idle-to-data ratio
)(
    input                       clk,        // fast clock 
    input                       rst_n,
    input [N*UNIT_W*UNIT_H-1:0] pdatain,
    input [7:0]                 pcmdin,     // CSR
                                            // CW0: 0 S I I P P P P
                                            // CW1: 1 x x x x x O D
    output                      dev_rst_n,  // Device Reset
    output                      dev_clk,    // Pass through
    output                      dev_dout,   // Device Serial Data
    output                      dev_rs,     // Device Control Word Select
    output                      dev_ce_n    // Device Enable
    //output                      dev_blank // Blanking control, unused
    // output                      dev_sel  // Device internal clock select
                                            // Connected Externally
);

// reg [$clog2(CLK_RATIO)-1:0] clkdiv_r;

// Input SRs

reg [N*UNIT_W*UNIT_H-1:0] pdatain_sr;
reg [7:0]                 pcmdin_sr;

// Output Mapping
reg    dev_rst_n_r;         // 
reg    dev_dout;            // Muxed output
reg    dev_rs_r;            // 
reg    dev_ce_n_r;          //
assign dev_ce_n = dev_ce_n_r;   // 
assign dev_clk = clk;     // You may want to use 90deg clock instead
assign dev_rs  = dev_rs_r;// CMD Register Select

reg [1:0]  SS_dout_muxsel_r;
localparam SSDM_0     = 2'b00;
localparam SSDM_PDATA = 2'b01;
localparam SSDM_PCMD  = 2'b10;

reg [2:0] SS_state_r;
localparam SS_RST    = 3'b000; // Reset
localparam SS_CLR    = 3'b001; // Initialize -
localparam SS_TXDATA = 3'b011; // Serial Load Data
localparam SS_TXCMD  = 3'b010; // Serial Load Command
localparam SS_HOLD   = 3'b110; // Data Stable

// General purpose counter
reg [$clog2(ITD_RATIO*N*UNIT_H*UNIT_W):0] SS_cnt_r; 

// Data out MUX
always @* begin
    case (SS_dout_muxsel_r) 
        SSDM_0:     dev_dout = 0;
        SSDM_PCMD:  dev_dout = pcmdin_sr[0];
        SSDM_PDATA: dev_dout = pdatain_sr[0];
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        SS_state_r  <= SS_RST;
        dev_rs_r    <= 1'b0;
        dev_rst_n_r <= 1'b0;
        dev_ce_n_r  <= 1'b0;

    end else begin
        // Move the shifting registers
        // pcmdin_sr  <= {1'bx, pcmdin_sr[7:1]};
        // pdatain_sr <= {1'bx, pdatain_sr[N*UNIT_W*UNIT_W-1:1]}
        case(SS_state_r)
        SS_RST: begin  // Assert 1 display cycle reset
            if (SS_cnt_r == UNIT_H*UNIT_W) begin
                dev_rst_n_r      <= 1'b1;
                SS_dout_muxsel_r <= SSDM_0;
                SS_state_r  <= SS_CLR;
                SS_cnt_r    <= 0;
            end else begin
                SS_cnt_r    <= SS_cnt_r + 1;
            end
        end
        SS_CLR: begin // Clear All dot registers
            if (SS_cnt_r == N*UNIT_H*UNIT_W) begin
                // dev_dout_mux_sel <= SSDM_PCMD;
                pcmdin_sr <= pcmdin;
                dev_rs_r <= 1'b1;
                SS_state_r <= SS_TXCMD;
                SS_cnt_r <= 0;
            end else begin
                SS_cnt_r <= SS_cnt_r + 1;
            end 
        end
        SS_TXCMD: begin // Transmit Control Word
            if (SS_cnt_r == 8)  begin
                // dev_dout_mux_sel <= SSDM_PDATA;
                pdatain_sr <= pdatain;
                dev_rs_r <= 1'b0;
                SS_state_r <= SSDM_PDATA;
                SS_dout_muxsel_r <= SSDM_PDATA;
                SS_cnt_r <= 0;
            end else begin
                SS_cnt_r <= SS_cnt_r + 1;
                pcmdin_sr <= {1'bx, pcmdin_sr[7:1]};
            end
        end
        SS_TXDATA: begin    // Transmit Pixel Data
            if (SS_cnt_r == N*UNIT_W*UNIT_H) begin
                dev_ce_n_r <= 1'b1;
                SS_state_r <= SS_HOLD;
                SS_cnt_r <= 1'b0;
            end else begin 
                SS_cnt_r <= SS_cnt_r + 1;
                pdatain_sr <= {1'bx, pdatain_sr[N*UNIT_W*UNIT_H-1:1]};
            end
        end

        SS_HOLD: begin // Stay idle, probably doing PWM on the blank control pin
            if (SS_cnt_r == ITD_RATIO*N*UNIT_H*UNIT_W) begin
                dev_ce_n_r <= 1'b0;
                SS_state_r <= SS_TXDATA;
                SS_cnt_r   <= 0;
            end else begin
                SS_cnt_r <= SS_cnt_r + 1;
            end

        end
        endcase
    end
end


endmodule /* HCMS2904 */