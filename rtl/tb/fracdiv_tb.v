`timescale 1ns/1ps
module fracdiv_tb;

    reg tb_clk_r;
    reg tb_rst_nr;

    reg [11:0] tb_din_r;

    initial begin
        $dumpfile("fracdiv_tb.vcd");
        $dumpvars(0, fracdiv_tb);
        tb_rst_nr = 1;
        tb_clk_r  = 0;
        tb_din_r  = 0;
    #5
        tb_rst_nr = 0;
    #20
        tb_rst_nr = 1;
    #(10*4096)
        $finish;
    end

    // This configuration divides the input by 2*3 = 6

    wire dout;
    fracdiv fracdiv(
        .clk_fast(tb_clk_r),
        .rst_n   (tb_rst_nr),
        .m       (0),
        .n       (16'hFFFF/3),
        .clk_out (dout)
    );

    always begin
    #10
        tb_clk_r = ~tb_clk_r;
        tb_din_r = tb_din_r + 1;
    end

endmodule /* sdm1b_tb */
