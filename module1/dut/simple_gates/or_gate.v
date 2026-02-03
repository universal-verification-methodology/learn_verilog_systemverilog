/*
 * OR gate - IEEE 1364-1995 style
 *
 * Port list: names only (non-ANSI).
 * Output driven by assign -> wire (not reg).
 */

module or_gate(a, b, y);
    input  a;
    input  b;
    output y;

    wire a, b, y;

    assign y = a | b;
endmodule
