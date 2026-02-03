/*
 * Module 7: Migration 1995 -> 2001
 * Before: non-ANSI ports, explicit sensitivity. After: ANSI, always @*.
 * Same 2:1 mux.
 */

// ----- BEFORE: 1364-1995 -----
module mux_1995(a, b, sel, y);
    input  a, b, sel;
    output y;
    wire   a, b, sel;
    reg    y;
    always @(a or b or sel)
        y = sel ? b : a;
endmodule

// ----- AFTER: 1364-2001 (ANSI, @*) -----
module mux_2001 (
    input  wire a, b, sel,
    output reg  y
);
    always @* y = sel ? b : a;
endmodule

module top;
    reg a, b, sel;
    wire y1995, y2001;

    mux_1995 u1995 (.a(a), .b(b), .sel(sel), .y(y1995));
    mux_2001 u2001 (.a(a), .b(b), .sel(sel), .y(y2001));

    initial begin
        $display("Module 7: Migration 1995 -> 2001 (ANSI ports, always @*)");
        a = 0; b = 1; sel = 0;
        #10 $display("  sel=0: y1995=%b y2001=%b", y1995, y2001);
        sel = 1;
        #10 $display("  sel=1: y1995=%b y2001=%b", y1995, y2001);
        if (y1995 === y2001) $display("  PASS: same behavior");
        else $display("  FAIL: mismatch");
        $finish;
    end
endmodule
