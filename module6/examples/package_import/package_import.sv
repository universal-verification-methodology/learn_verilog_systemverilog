/*
 * IEEE 1800-2017: package and import (2017 clarified)
 * Shared types and constants; explicit namespace.
 */

package pkg_2017;
    parameter int W = 8;
    typedef logic [W-1:0] word_t;
    parameter word_t ZERO = '0;
endpackage

module adder_2017 (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum
);
    import pkg_2017::*;
    assign sum = a + b;
endmodule

module top;
    import pkg_2017::*;

    word_t a, b, sum;

    adder_2017 u (.a(a), .b(b), .sum(sum));

    initial begin
        $display("1800-2017: package and import (2017 clarified)");
        a = 8'd40; b = 8'd60;
        #10 $display("  a=%d b=%d sum=%d", a, b, sum);
        $display("  Shared types/params in package; import where needed.");
        $finish;
    end
endmodule
