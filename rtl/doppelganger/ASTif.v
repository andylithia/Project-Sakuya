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
// AST Signal Recepient
//
// Usage note:
//   Like other digital blocks, the AST block doesn't have a output buffer
//   This can be quite problematic because in the worst case, a 4MHz system
//   clock that samples the two SDO lines can land on the transitioning part
//   of the waveform, causing metastability.
//   To avoid this, I derive the 4MHz sampling clock from a much faster clock.
//   It gives the user the ability to select the best sampling point
//
//
// Chip Internal Clock / Data:
//           .---------.         .---------
//           |         |         |          <- Synchronous to the FPGA clock
//  ---------'         '---------'
//           .-------------//----.
//           |                   |          <- Derived from the 4MHz Clock
//  ---------'                   '--------     But frequency divided
//
// Actual waveform on the SDO line & Sampling point (of the FPGA)
//                          .----.
//                      /      \__ Good
//                  /               \
//               /   \__ Bad           \
//             /                           \
//  ----------'                              '------------
//            \_____ Bad Sampling Point
//


module ASTif(
    input         clk_64M,  // 64MHz Clock Input
    input         clk_4M,   // 4MHz Clock, Synchronized to the 64MHz
                            // It can be a derived clock (i.e. clock divider),
                            // but should come directly from the PLL whenever possible
    input         rst_n,
    input [3:0]   phase_select,
    input         AST_isdo, // Serial data from the I channel
    input         AST_qsdo, // Serial data from the Q channel
    input         AST_scen, // Serial Chip Select
    output [10:0] icnt, // I channel count
    output        ipol, // I channel polarity
    output [10:0] qcnt, // Q channel count
    output        qpol
);

    // Clock Generator
    reg [15:0] div_control_sr;
    always @(posedge clk_64M or negedge rst_n) begin
        if(~rst_n) begin
            div_control_sr <= 0;
        end else begin
            div_control_sr <= {div_control_sr[14:0], div_control_sr[15]};
        end
    end
    reg [15:0] isdo_latch_r;
    reg [15:0] qsdo_latch_r;
    reg [15:0] sce_latch_r;
    reg isdo_sel;
    reg qsdo_sel;
    reg sce_sel;
    always @(*) begin
        case (phase_select)
        4'd0:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[0], qsdo_latch_r[0], sce_latch_r[0]};
        4'd1:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[1], qsdo_latch_r[1], sce_latch_r[1]};
        4'd2:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[2], qsdo_latch_r[2], sce_latch_r[2]};
        4'd3:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[3], qsdo_latch_r[3], sce_latch_r[3]};
        4'd4:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[4], qsdo_latch_r[4], sce_latch_r[4]};
        4'd5:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[5], qsdo_latch_r[5], sce_latch_r[5]};
        4'd6:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[6], qsdo_latch_r[6], sce_latch_r[6]};
        4'd7:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[7], qsdo_latch_r[7], sce_latch_r[7]};
        4'd8:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[8], qsdo_latch_r[8], sce_latch_r[8]};
        4'd9:    {isdo_sel,qsdo_sel,sce_sel} = { isdo_latch_r[9], qsdo_latch_r[9], sce_latch_r[9]};
        4'd10:   {isdo_sel,qsdo_sel,sce_sel} = {isdo_latch_r[10],qsdo_latch_r[10],sce_latch_r[10]};
        4'd11:   {isdo_sel,qsdo_sel,sce_sel} = {isdo_latch_r[11],qsdo_latch_r[11],sce_latch_r[11]};
        4'd12:   {isdo_sel,qsdo_sel,sce_sel} = {isdo_latch_r[12],qsdo_latch_r[12],sce_latch_r[12]};
        4'd13:   {isdo_sel,qsdo_sel,sce_sel} = {isdo_latch_r[13],qsdo_latch_r[13],sce_latch_r[13]};
        4'd14:   {isdo_sel,qsdo_sel,sce_sel} = {isdo_latch_r[14],qsdo_latch_r[14],sce_latch_r[14]};
        4'd15:   {isdo_sel,qsdo_sel,sce_sel} = {isdo_latch_r[15],qsdo_latch_r[15],sce_latch_r[15]};
        default: {isdo_sel,qsdo_sel,sce_sel} = 3'bxxx;
        endcase
    end

    genvar gi;
    generate
        for(gi=0;gi<16;gi=gi+1) begin : gen_sample_latch
            always @(posedge clk_64M) begin
                if(div_control_sr[gi]) begin
                    isdo_latch_r[gi] <= AST_isdo;
                    qsdo_latch_r[gi] <= AST_qsdo;
                    sce_latch_r[gi]  <= ~AST_scen;
                end
            end
        end
    endgenerate


    reg [4:0] SSI_r; // State Machine for I
    reg [4:0] SSQ_r; // State Machine for Q
    parameter integer S_WAIT_SYNC_1 = 0;    // data register is full 0,
                                            // time to pick up the next data stream
    parameter integer S_CAPTURE     = 1;    // Running 11-bit Capture
    parameter integer S_WAIT_CLEAR  = 2;    // Wait for clear
    parameter integer CAP_WIDTH     = 12;   // 1-bit polarity, 11-bit data
    reg [13:0] id_sr;                           // Channel I Shift Register
    reg [$clog2(CAP_WIDTH)-1:0]  id_scnt_r;     // Channel I shift count
    reg [13:0] qd_sr;                           // Channel I Shift Register
    reg [$clog2(CAP_WIDTH)-1:0]  qd_scnt_r;     // Channel I shift count
    wire id_clear = ~(|id_sr);
    wire qd_clear = ~(|qd_sr);

    reg [11:0] idq_r;
    reg [11:0] qdq_r;

    assign icnt = idq_r[10:0];
    assign ipol = idq_r[11];
    assign qcnt = qdq_r[10:0];
    assign qpol = qdq_r[11];

    always @(posedge clk_4M or negedge rst_n) begin
        if(~rst_n) begin
            SSI_r <= S_WAIT_SYNC_1;
            SSQ_r <= S_WAIT_SYNC_1;
            id_sr <= 0;
            qd_sr <= 0;
            // idq_r <= 0;
            // pdq_r <= 0;
        end else begin
            // I Channel
            id_sr <= {id_sr[12:0],isdo_latch_r}; // MSB First
            if(SSI_r==S_WAIT_SYNC_1) begin
                if(isdo_latch_r == 1'b1) begin
                    SSI_r     <= S_CAPTURE;
                    id_scnt_r <= 0;
                end else begin
                    SSI_r <= S_WAIT_SYNC_1;
                end
            end else if (SSI_r==S_CAPTURE) begin
                if(id_scnt_r!=CAP_WIDTH-1) begin
                    id_scnt_r <= id_scnt_r + 1;
                end else begin                      // We're done here, latch output data and sleep
                    idq_r <= id_sr[11:0];
                    SSI_r  <= S_WAIT_CLEAR;
                end
            end else if (SSI_r==S_WAIT_CLEAR) begin
                if(id_clear) SSI_r <= S_WAIT_SYNC_1;
            end

            // Q Channel
            qd_sr <= {qd_sr[12:0],qsdo_latch_r}; // MSB First
            if(SSQ_r==S_WAIT_SYNC_1) begin
                if(qsdo_latch_r == 1'b1) begin
                    SSQ_r     <= S_CAPTURE;
                    qd_scnt_r <= 0;
                end else begin
                    SSQ_r <= S_WAIT_SYNC_1;
                end
            end else if (SSQ_r==S_CAPTURE) begin
                if(qd_scnt_r!=CAP_WIDTH-1) begin
                    qd_scnt_r <= qd_scnt_r + 1;
                end else begin                      // We're done here, latch output data and sleep
                    qdq_r <= qd_sr[11:0];
                    SSQ_r  <= S_WAIT_CLEAR;
                end
            end else if (SSQ_r==S_WAIT_CLEAR) begin
                if(qd_clear) SSQ_r <= S_WAIT_SYNC_1;
            end
        end
    end

endmodule /* ASTif */
