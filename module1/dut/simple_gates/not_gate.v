/*
 * NOT gate - IEEE 1364-1995 style
 *
 * Port list: names only (non-ANSI).
 * Continuous assignment -> output is wire.
 */

module not_gate(a, y);
    input  a;
    output y;

    wire a, y;

    assign y = ~a;
endmodule
