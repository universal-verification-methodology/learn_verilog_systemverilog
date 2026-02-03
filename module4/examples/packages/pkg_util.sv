/*
 * Package and import - IEEE 1800-2005
 * Shared types, parameters, functions.
 */

package pkg_util;
    parameter int WIDTH = 8;
    typedef logic [WIDTH-1:0] word_t;

    function automatic logic [7:0] parity(input logic [31:0] v);
        parity = ^v;
    endfunction
endpackage

module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] y,
    output logic [7:0] par
);
    import pkg_util::*;

    assign y = a + b;
    assign par = parity(y);
endmodule

module top;
    logic [31:0] a, b;
    logic [31:0] y;
    logic [7:0] par;

    alu u_alu (.a(a), .b(b), .y(y), .par(par));

    initial begin
        $display("Package and import (1800-2005)");
        a = 32'd100; b = 32'd200;
        #10 $display("  a=%d b=%d y=%d par=%d", a, b, y, par);
        $finish;
    end
endmodule
