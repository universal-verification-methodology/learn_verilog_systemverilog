/*
 * D flip-flop - IEEE 1364-1995 style
 *
 * Sequential logic: always @(posedge clk) with nonblocking <=.
 * reg holds value; flip-flop inferred from edge-sensitive always.
 */

module dff(clk, rst_n, d, q);
    input  clk;
    input  rst_n;
    input  d;
    output q;

    reg q;

    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            q <= 0;
        else
            q <= d;
endmodule

module top;
    reg clk;
    reg rst_n;
    reg d;
    wire q;

    dff u_dff (.clk(clk), .rst_n(rst_n), .d(d), .q(q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("D flip-flop (1364-1995): always @(posedge clk or negedge rst_n); q <= d");
        rst_n = 0;
        d = 1;
        #12 rst_n = 1;
        #10 $display("  t=%0t d=%b q=%b", $time, d, q);
        d = 0;
        #10 $display("  t=%0t d=%b q=%b", $time, d, q);
        d = 1;
        #10 $display("  t=%0t d=%b q=%b", $time, d, q);
        #20 $finish;
    end
endmodule
