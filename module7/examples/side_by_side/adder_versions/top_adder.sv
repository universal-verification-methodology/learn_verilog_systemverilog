/*
 * Module 7: Top - run all adder versions and compare
 */

module top;
    logic [7:0] a, b, sum1995, sum2001, sum2005, sum1800;

    adder_1995 u1995 (.a(a), .b(b), .sum(sum1995));
    adder_2001 u2001 (.a(a), .b(b), .sum(sum2001));
    adder_2005 u2005 (.a(a), .b(b), .sum(sum2005));
    adder_1800 u1800 (.a(a), .b(b), .sum(sum1800));

    initial begin
        $display("Module 7: Side-by-side 8-bit adder (1995, 2001, 2005, 1800)");
        a = 8'd10; b = 8'd20;
        #10 $display("  a=%d b=%d sum1995=%d sum2001=%d sum2005=%d sum1800=%d", a, b, sum1995, sum2001, sum2005, sum1800);
        a = 8'd100; b = 8'd200;
        #10 $display("  a=%d b=%d sum1995=%d sum2001=%d sum2005=%d sum1800=%d", a, b, sum1995, sum2001, sum2005, sum1800);
        if (sum1995 === sum2001 && sum2001 === sum2005 && sum2005 === sum1800)
            $display("  PASS: all versions match");
        else
            $display("  FAIL: mismatch");
        $finish;
    end
endmodule
