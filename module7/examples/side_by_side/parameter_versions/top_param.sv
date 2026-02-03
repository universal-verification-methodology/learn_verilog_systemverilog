/*
 * Module 7: Top - run parameter versions and compare
 */

module top;
    logic [7:0] d, q1364, q1800;
    logic       sh;

    shift_1364 #(.WIDTH(8)) u1364 (.d(d), .sh(sh), .q(q1364));
    shift_1800 #(.WIDTH(8)) u1800 (.d(d), .sh(sh), .q(q1800));

    initial begin
        $display("Module 7: Side-by-side parameter (1364 vs 1800 parameter int)");
        d = 8'b0000_0001; sh = 0;
        #10 $display("  d=%b sh=%b q1364=%b q1800=%b", d, sh, q1364, q1800);
        sh = 1;
        #10 $display("  d=%b sh=%b q1364=%b q1800=%b", d, sh, q1364, q1800);
        if (q1364 === q1800) $display("  PASS: all versions match");
        else $display("  FAIL: mismatch");
        $finish;
    end
endmodule
