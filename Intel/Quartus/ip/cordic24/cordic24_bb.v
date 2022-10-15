
module cordic24 (
	clk,
	areset,
	a,
	c,
	s);	

	input		clk;
	input		areset;
	input	[24:0]	a;
	output	[24:0]	c;
	output	[24:0]	s;
endmodule
