`timescale 1ns/1ps
module sdm1b_tb;

    reg tb_clk_r;
    reg tb_rst_nr;

    reg [11:0] tb_din_r;

    initial begin
        $dumpfile("sdm1b_tb.vcd");
        $dumpvars(0, sdm1b_tb);
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

    wire dout;
    sdm1b u_DUT(
        .clk_fast(tb_clk_r ),
        .rst_n   (tb_rst_nr),
        .din     (tb_din_r ),
        .error   (         ),
        .dout    (dout     )
    );

    always begin
    #10 
        tb_clk_r = ~tb_clk_r;
        tb_din_r = tb_din_r + 1;     
    end

endmodule /* sdm1b_tb */