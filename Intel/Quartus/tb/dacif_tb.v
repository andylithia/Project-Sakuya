`timescale 1ns/1ps
module dacif_tb;

    reg tb_clk_r;
    reg tb_rst_nr;

    reg [11:0] tb_din_r;

    initial begin
        $dumpfile("dacif_tb.vcd");
        $dumpvars(0, dacif_tb);
        tb_rst_nr = 1;
        tb_clk_r  = 0;
        tb_din_r  = 0;
    #5
        tb_rst_nr = 0;
    #20
        tb_rst_nr = 1;
    #2000
        $finish;
    end

    // Clkdiv
    reg [3:0] tb_clkdiv_r;
    wire      tb_clk_div16;
    assign tb_clk_div16 = tb_clkdiv_r[3];
    always @(posedge tb_clk_r or negedge tb_rst_nr) begin
        if(~tb_rst_nr) tb_clkdiv_r <= 4'b0111;
        else           tb_clkdiv_r <= tb_clkdiv_r + 1;
    end

    reg [7:0] tb_din_test_r;
    reg       tb_a_test_r;
    wire dout;
    always @(posedge tb_clk_div16) begin
        tb_din_test_r <= $urandom%256;
        tb_a_test_r   <= $urandom%2;
    end
    DACif u_DUT(
        .clk_4M   (tb_clk_r),
        .rst_n    (tb_rst_nr),
        .din      (tb_din_test_r),
        .a        (tb_a_test_r),
        .DAC_scen (tb_clk_div16),
        .dout     (dout)
    );

    always begin
    #10
        tb_clk_r = ~tb_clk_r;
        tb_din_r = tb_din_r + 1;
    end

endmodule /* dacif_tb */

