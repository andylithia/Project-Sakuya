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

module dl_platform #(
    parameter DATASIZE = 128
)(
    input    clk10m,        // 10 MHz Fast Clock
    input    clk10m_dly,    // 10 MHz Fast Clock with extra delay
    input    rst_n,         // Global Reset
    input    tdc_start,     // Delayline input
    input    tdc_stop,      // TDC Latch input
    output   clk_sampling,  // 30Hz Sampling Clock
    // output   clk_sampling_dly,
    output   txd,           // UART TX
    output   txdone         // UART TX - byte is finished
);


// ░█▀▀░█░░░█▀█░█▀▀░█░█░░░█▀▀░█▀▀░█▀█░
// ░█░░░█░░░█░█░█░░░█▀▄░░░█░█░█▀▀░█░█░
// ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░
parameter  TARGET_FREQ  = 30;
// parameter  TARGET_FREQ  = 1;
localparam SYSTEM_FREQ = 10000000;
localparam HALF_DIV    = (SYSTEM_FREQ/TARGET_FREQ/2);

reg [$clog2(HALF_DIV):0]    clkdiv_r;      // 
reg                         clk_slow_r;    // 30 Hz Slow Clock
assign                      clk_sampling = clk_slow_r;
always @(posedge clk10m or negedge rst_n) begin
    if(~rst_n) begin
        clkdiv_r  <= 0;
    end else begin
        if(clkdiv_r == HALF_DIV) begin
            clkdiv_r   <= 0;
            clk_slow_r <= 1;
        end else begin
            clkdiv_r <= clkdiv_r + 1;
            clk_slow_r <= 0;
        end
    end
end

// ░▀█▀░█▀▄░█▀▀░
// ░░█░░█░█░█░░░
// ░░▀░░▀▀░░▀▀▀░
reg clk_slow_dly_r;
always @(posedge clk10m_dly) begin
    clk_slow_dly_r <= clk_slow_r;
end

wire [DATASIZE-1:0] tdc_delayline_d;
reg  [DATASIZE-1:0] tdc_dq_r/*synthesis keep*/;
delayline #(.LENGTH(DATASIZE)) u_DUT(
    .din (tdc_start),
    .dout(tdc_delayline_d)
);
always @(posedge tdc_stop) begin
    tdc_dq_r <= tdc_delayline_d;   
end

// wire [DATASIZE-1:0] test_DATA = 64'hAA01_2345_AA01_2345;
wire [DATASIZE-1:0] test_DATA = tdc_dq_r;

// ░█░█░█▀█░█▀▄░▀█▀░░░▀█▀░█░█░░░█▀▀░█▀█░█▀█░▀█▀░█▀▄░█▀█░█░░
// ░█░█░█▀█░█▀▄░░█░░░░░█░░▄▀▄░░░█░░░█░█░█░█░░█░░█▀▄░█░█░█░░
// ░▀▀▀░▀░▀░▀░▀░░▀░░░░░▀░░▀░▀░░░▀▀▀░▀▀▀░▀░▀░░▀░░▀░▀░▀▀▀░▀▀▀
wire [4:0] ulim = 7;
reg  [4:0] datasel_r;
reg [7:0]  datamux;
reg [7:0]  datamux_r;
reg [1:0]  SS_r;
reg        tx_push_r;

localparam SS_IDLE        = 2'b00;
localparam SS_SEND        = 2'b01;
localparam SS_WAIT_SEND   = 2'b11;
localparam SS_WAIT_SAMPLE = 2'b10;

wire [7:0] datamux_presel [(DATASIZE/8)-1:0];

genvar gi;
generate 
for (gi=0;gi<(DATASIZE/8);gi=gi+1) begin : gen_datamux
    assign datamux_presel[gi] = test_DATA[((gi+1)*8)-1:gi*8];
end
endgenerate

// Intel tools doesn't support variable as range select
always @* begin
//  datamux = test_DATA[(datasel_r*(8+1))-1:datasel_r*8];
/*
    case(datasel_r)
          0: datamux = test_DATA[ 7: 0];
          1: datamux = test_DATA[15: 8];
          2: datamux = test_DATA[23:16];
          3: datamux = test_DATA[31:24];
          4: datamux = test_DATA[39:32];
          5: datamux = test_DATA[47:40];
          6: datamux = test_DATA[55:48];
          7: datamux = test_DATA[63:56];
    default: datamux = 8'bxxxxxxxx;
    endcase
*/
datamux = datamux_presel[datasel_r];
end


always @(posedge clk10m or negedge rst_n) begin
    if (~rst_n) begin
        SS_r <= SS_WAIT_SAMPLE;
    end else begin
        case(SS_r) 
        SS_SEND: begin
            tx_push_r <= 1'b1;
            datamux_r <= datamux;
            SS_r <= SS_WAIT_SEND;
        end
        SS_WAIT_SEND: begin // Sample arrived, wait for transmission done
            tx_push_r <= 0;
            if (txdone==1) begin    // Transmission finished
                if(datasel_r==ulim) begin
                    SS_r <= SS_WAIT_SAMPLE; // Current transaction done, move to the next one
                    datasel_r <= 0;
                end else begin
                    SS_r <= SS_SEND;
                    datasel_r <= datasel_r+1;
                end                
            end
        end
        SS_WAIT_SAMPLE: begin
            if(clk_slow_r==1) begin
                SS_r <= SS_SEND;
            end
        end
        endcase
    end    
end

// Sending data to the MCU
uart_tx #(.CLKS_PER_BIT(10000000/115200)) u_DTX(
    .i_Clock     (clk10m),
    .i_Tx_DV     (tx_push_r),
    .i_Tx_Byte   (datamux_r),
    .o_Tx_Active (txactive),
    .o_Tx_Serial (txd),
    .o_Tx_Done   (txdone)
);


endmodule /* dl_platform */

