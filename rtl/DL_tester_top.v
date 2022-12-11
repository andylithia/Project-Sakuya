module DL_tester_top#(
    parameter LENGTH = 16
)(
    input clk,
    input rst_n,
    output reg [LENGTH-1:0] dout_r
);
    wire [LENGTH-1:0] constant = {LENGTH{1'b1}}  /*synthesis keep*/;
    wire dinw;
    wire [LENGTH-1:0] doutw /*synthesis keep*/;
  
    assign doutw = constant + dinw;
    assign dinw  = clk;
    assign dout  = doutw;

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) dout_r <= 0;
        else       dout_r <= dout;
    end


endmodule /* DL_tester_top */

