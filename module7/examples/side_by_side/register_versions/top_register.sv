/*
 * Module 7: Top - run all register versions and compare
 */

module top;
    logic clk, rst_n;
    logic [7:0] d, q1995, q2001, q2005, q1800;

    dff_1995 u1995 (.clk(clk), .rst_n(rst_n), .d(d), .q(q1995));
    dff_2001 u2001 (.clk(clk), .rst_n(rst_n), .d(d), .q(q2001));
    dff_2005 u2005 (.clk(clk), .rst_n(rst_n), .d(d), .q(q2005));
    dff_1800 u1800 (.clk(clk), .rst_n(rst_n), .d(d), .q(q1800));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 7: Side-by-side register (1995, 2001, 2005, 1800)");
        rst_n = 0; d = 8'd0;
        #20 rst_n = 1; d = 8'd42;
        #15 d = 8'd99;
        #20 $display("  d=%d q1995=%d q2001=%d q2005=%d q1800=%d", d, q1995, q2001, q2005, q1800);
        if (q1995 === q2001 && q2001 === q2005 && q2005 === q1800)
            $display("  PASS: all versions match");
        else
            $display("  FAIL: mismatch");
        $finish;
    end
endmodule
