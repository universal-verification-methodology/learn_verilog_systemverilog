/*
 * Wildcard equality ==? - IEEE 1800-2009/2012
 * X/Z on RHS are don't care in comparison.
 */

module wildcard_demo (
    input  logic [3:0] a,
    input  logic [3:0] pattern,
    output logic       match
);
    /* ==?: pattern 1x0z matches 1000, 1001, 1100, 1101, etc. */
    always_comb
        match = (a ==? pattern);
endmodule

module top;
    logic [3:0] a, pattern;
    logic       match;

    wildcard_demo u_dut (.a(a), .pattern(pattern), .match(match));

    initial begin
        $display("Wildcard ==? (1800-2009/2012): X/Z on RHS = don't care");
        pattern = 4'b1x0z;
        a = 4'b1000; #10 $display("  a=%b pattern=%b match=%b", a, pattern, match);
        a = 4'b1101; #10 $display("  a=%b pattern=%b match=%b", a, pattern, match);
        a = 4'b0100; #10 $display("  a=%b pattern=%b match=%b", a, pattern, match);
        $finish;
    end
endmodule
