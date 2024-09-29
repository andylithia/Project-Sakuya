`timescale 1ns / 1ps
module top(
input CLK100MHZ,
input [3:0] sw,
input [3:0] btn,
output [7:0] ja,
output [3:0] led
    );
    
wire clk_200MHz;
wire clk_100MHz;
wire clk_50MHz;
wire pll_locked;

clk_wiz_0 u_pll(
    .clk_out1(clk_200MHz),
    .clk_out2(clk_100MHz),
    .clk_out3(clk_50MHz),
    .reset(btn[0]),
    .locked(pll_locked),
    .clk_in1(CLK100MHZ)
);

// Xilinx IODelay, UG471
IDELAYCTRL u_delay_ctrl(
    .REFCLK(clk_200MHz),
    .RST(~pll_locked),
    .RDY()
);


parameter LEN=10;
wire [4:0] cnt_value_out[LEN:0];

genvar gi;
generate
    wire [LEN:0] dut_do;
    for(gi=0;gi<LEN;gi=gi+1) begin: gen_delayline
        IDELAYE2 #(
            .IDELAY_TYPE           ("VAR_LOAD"),
            .DELAY_SRC             ("DATAIN"),
            .IDELAY_VALUE          (15),
            .HIGH_PERFORMANCE_MODE (1'b1),
            .SIGNAL_PATTERN        ("DATA"),
            .REFCLK_FREQUENCY      (200),
            .CINVCTRL_SEL          (1'b0),
            .PIPE_SEL              (1'b0)
        ) u_dut (
            .C           (clk_50MHz),
            .REGRST      (~pll_locked),
            .LD          (btn[1]),
            .CE          (1'b0),         // Incr/Decr Mode Disabled
            .INC         (1'bx),
            .CINVCTRL    (1'b0),
            .CNTVALUEIN  ({sw,1'b1} ),
            .IDATAIN     (          ),   // From the IBUF
            .DATAIN      (dut_do[gi]),   // From FPGA Fabric
            .LDPIPEEN    (1'b0      ), // Load Pipeline
            .DATAOUT     (dut_do[gi+1]),
            .CNTVALUEOUT (cnt_value_out[gi]) 
        );
    end
endgenerate

LUT2 #(.INIT(4'b0001)) u_inv(
    .O (dut_do[0]),
    .I0(dut_do[LEN]),
    .I1(btn[2])
 );
 
wire [63:0] ila_p0;
ila_0 u_ila(
    .clk(clk_200MHz),
    .probe0(ila_p0)
);

reg [31:0] dut_do_div;
reg        dut_do_ff;
wire       dut_do_clk;
BUFG u_dut_do_drv(
    .I(dut_do[LEN]),
    .O(dut_do_clk)
);

always@(posedge dut_do_clk) begin
    if(~pll_locked) begin
        dut_do_div <= 0;
        dut_do_ff  <= 0;
    end else begin
        if(dut_do_div >= 32'd2_500_000) begin
            dut_do_ff <= ~dut_do_ff;
            dut_do_div <= 0;
        end else begin
            dut_do_div <= dut_do_div+1;
        end
    end
end

assign ila_p0[0]   = clk_50MHz;
assign ila_p0[1]   = dut_do[LEN];
assign ila_p0[6:2] = cnt_value_out[0];
assign ja[1] = dut_do[LEN];    
assign ja[0] = clk_50MHz;
assign led[3:1]   = cnt_value_out[0][4:2];
assign led[0]     = dut_do_ff;

endmodule
