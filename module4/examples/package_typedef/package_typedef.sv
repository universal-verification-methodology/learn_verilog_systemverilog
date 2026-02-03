/*
 * Package with typedef and function - IEEE 1800-2005
 * Shared types and helper; import in multiple modules.
 */

package pkg_common;
    parameter int W = 8;
    typedef logic [W-1:0] word_t;

    function automatic word_t min_word(input word_t a, input word_t b);
        min_word = (a < b) ? a : b;
    endfunction
endpackage

module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum,
    output logic [7:0] min_out
);
    import pkg_common::*;

    assign sum = a + b;
    assign min_out = min_word(a, b);
endmodule

module top;
    logic [7:0] a, b, sum, min_out;

    alu u_alu (.a(a), .b(b), .sum(sum), .min_out(min_out));

    initial begin
        $display("Package with typedef and function (1800-2005)");
        a = 8'd50; b = 8'd30; #10 $display("  a=%d b=%d sum=%d min=%d", a, b, sum, min_out);
        a = 8'd10; b = 8'd90; #10 $display("  a=%d b=%d sum=%d min=%d", a, b, sum, min_out);
        $finish;
    end
endmodule
