`timescale 1ns/1ps

module CORDIC#(
    parameter XYWIDTH = 16,
    parameter ZWIDTH  = XYWIDTH*2,
    parameter STAGE = 16
)(
    input                          clk,
    input signed [ZWIDTH-1:0]      z0,
    input signed [XYWIDTH-1:0]     x0,
    input signed [XYWIDTH-1:0]     y0,
    output signed [XYWIDTH+1-1:0]  xout_r,
    output signed [XYWIDTH+1-1:0]  yout_r
);
`ifdef FAKE_RAM
    reg [ZWIDTH-3:0] atan_lut [0:ZWIDTH-2];
`else
    wire [ZWIDTH-3:0] atan_lut [0:ZWIDTH-2];
	// 
    assign atan_lut[00] = 30'b100000000000000000000000000000;
    assign atan_lut[01] = 30'b010010111001000000010100011101;
    assign atan_lut[02] = 30'b001001111110110011100001011011;
    assign atan_lut[03] = 30'b000101000100010001000111010100;
    assign atan_lut[04] = 30'b000010100010110000110101000011;
    assign atan_lut[05] = 30'b000001010001011101011111100001;
    assign atan_lut[06] = 30'b000000101000101111011000011110;
    assign atan_lut[07] = 30'b000000010100010111110001010101;
    assign atan_lut[08] = 30'b000000001010001011111001010011;
    assign atan_lut[09] = 30'b000000000101000101111100101110;
    assign atan_lut[10] = 30'b000000000010100010111110011000;
    assign atan_lut[11] = 30'b000000000001010001011111001100;
    assign atan_lut[12] = 30'b000000000000101000101111100110;
    assign atan_lut[13] = 30'b000000000000010100010111110011;
    assign atan_lut[14] = 30'b000000000000001010001011111001;
    assign atan_lut[15] = 30'b000000000000000101000101111101;
    assign atan_lut[16] = 30'b000000000000000010100010111110;
    assign atan_lut[17] = 30'b000000000000000001010001011111;
    assign atan_lut[18] = 30'b000000000000000000101000101111;
    assign atan_lut[19] = 30'b000000000000000000010100011000;
    assign atan_lut[20] = 30'b000000000000000000001010001100;
    assign atan_lut[21] = 30'b000000000000000000000101000110;
    assign atan_lut[22] = 30'b000000000000000000000010100011;
    assign atan_lut[23] = 30'b000000000000000000000001010001;
    assign atan_lut[24] = 30'b000000000000000000000000101000;
    assign atan_lut[25] = 30'b000000000000000000000000010100;
    assign atan_lut[26] = 30'b000000000000000000000000001010;
    assign atan_lut[27] = 30'b000000000000000000000000000101;
    assign atan_lut[28] = 30'b000000000000000000000000000010;
    assign atan_lut[29] = 30'b000000000000000000000000000001;
    assign atan_lut[30] = 30'b000000000000000000000000000000;
`endif


// 
// Pipeline Registers
reg signed [XYWIDTH+1-1:0] xr [0:STAGE-1];
reg signed [XYWIDTH+1-1:0] yr [0:STAGE-1];
reg signed [ZWIDTH-1:0]    zr [0:STAGE-1];

// Start 
wire [1:0] quad = z0[ZWIDTH-1:ZWIDTH-2]; 
always @(posedge clk) begin
    case (quad)
        2'b00,  // Q0, No rotation required
        2'b11:  // Q1, No rotation required
            begin   
                xr[0] <= x0;
                yr[0] <= y0;
                zr[0] <= z0;
            end 
        2'b01:  // Q2, Rotate -pi/2
            begin
                xr[0] <= -y0;
                yr[0] <= x0;
                zr[0] <= {2'b00, z0[ZWIDTH-3:0]};
            end
        2'b10:  // Q3, Rotate +pi/2
            begin
                xr[0] <= y0;
                yr[0] <= -x0;
                zr[0] <= {2'b11,z0[ZWIDTH-3:0]};
            end
    endcase   
end

// Pipeline Stages
genvar gi;
generate
    for (gi=0;gi<STAGE-1;gi=gi+1) begin : gen_cordic_pipeli
        wire signed [XYWIDTH+1-1:0] x_signext, y_signext;
        assign x_signext = xr[gi] >>> gi;
        assign y_signext = yr[gi] >>> gi;
        wire   z_sign    = zr[gi][ZWIDTH-1];    // Direction of the next rotation
        always @(posedge clk) begin
            xr[gi+1] <= z_sign ? xr[gi] + y_signext    : xr[gi] - y_signext;
            yr[gi+1] <= z_sign ? yr[gi] - x_signext    : yr[gi] + x_signext;
            zr[gi+1] <= z_sign ? zr[gi] + {2'b0,atan_lut[gi]} : zr[gi] - {2'b0,atan_lut[gi]};
        end
    end
endgenerate

assign xout_r = xr[STAGE-1];
assign yout_r = yr[STAGE-1];

endmodule /* CORDIC */
/* vim: set ts=4 sw=4 noet */
