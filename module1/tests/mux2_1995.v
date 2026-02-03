/*
 * 2:1 mux - IEEE 1364-1995 style (copy for tests)
 * Used by test_mux2.v so tests/ can run without pulling from examples.
 */

module mux2_1995(a, b, sel, y);
    input  a, b, sel;
    output y;
    wire a, b, sel, y;
    assign y = sel ? b : a;
endmodule
