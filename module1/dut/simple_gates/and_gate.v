/*
 * AND gate - IEEE 1364-1995 style
 *
 * Port list: names only (non-ANSI).
 * Direction and type declared inside module body.
 * Combinational: always @(a or b) with explicit sensitivity.
 */

module and_gate(a, b, y);
    input  a;
    input  b;
    output y;

    wire a, b;
    reg  y;

    always @(a or b)
        y = a & b;
endmodule
