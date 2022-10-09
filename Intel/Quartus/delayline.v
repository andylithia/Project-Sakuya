module delayline #(
    LENGTH = 16
)(
    input  din,
    output [LENGTH-1:0] dout
);

wire [LENGTH-1:0] constant = {LENGTH{1'b1}}/*synthesis keep*/;
wire dinw;
wire [LENGTH-1:0] doutw;

assign doutw = constant + dinw;
assign dinw = din;
assign dout = doutw;

endmodule /* delayline */