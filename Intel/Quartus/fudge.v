module fudge #(
	parameter N = 128
	)(
	input clk,
	input [4:0] din,
	input latch,
	input pulse,
	input clk_smp,
	output [4:0] dat_smp);

	
wire [5:0] c/*synthesis keep*/;
wire [5:0] co/*synthesis keep*/;
wire [4:0] di/*synthesis keep*/;

wire f0 = 0/*synthesis keep*/;
wire f1 = 1/*synthesis keep*/;
wire [4:0] fx/*synthesis keep*/;

assign fx = dat_smp+1'b1;


assign c[0] = clk/*synthesis keep*/;
genvar gi;
generate
	for(gi=0;gi<4;gi=gi+1) begin :gen_cchain
		CARRY cu(.in(c),.out(co));
		assign {c[gi+1],dat_smp[gi]} = f1 + f0 + c[gi];
	end
endgenerate

/*
genvar gi;
generate
	for(gi=0;gi<4;gi=gi+1) begin :gen_cchain
		assign c[gi+1] = c[gi]?1'b0:1'b1 ;
		assign dat_smp[gi] = c[gi] ;
	end
endgenerate
*/

endmodule
