/*
 * Module 7: 2:1 mux - 1364-1995, 1364-2001, 1364-2005 styles
 * Same behavior; port style and sensitivity change.
 */

// ----- 1364-1995: non-ANSI ports, explicit sensitivity -----
module mux2_1995(a, b, sel, y);
    input  a, b, sel;
    output y;
    wire   a, b, sel;
    reg    y;
    always @(a or b or sel)
        y = sel ? b : a;
endmodule

// ----- 1364-2001: ANSI ports, always @* -----
module mux2_2001 (
    input  wire a, b, sel,
    output reg  y
);
    always @* y = sel ? b : a;
endmodule

// ----- 1364-2005: same as 2001; nonblocking/blocking discipline -----
module mux2_2005 (
    input  wire a, b, sel,
    output reg  y
);
    always @* y = sel ? b : a;
endmodule
