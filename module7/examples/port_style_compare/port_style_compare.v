/*
 * Module 7: Port style only - non-ANSI (1995) vs ANSI (2001)
 * Same 2:1 mux; only port declaration style changes.
 */

// Non-ANSI: ports and types declared separately
module mux_non_ansi(a, b, sel, y);
    input  a, b, sel;
    output y;
    wire   a, b, sel;
    reg    y;
    always @(a or b or sel)
        y = sel ? b : a;
endmodule

// ANSI: direction and type in port list
module mux_ansi (
    input  wire a, b, sel,
    output reg  y
);
    always @* y = sel ? b : a;
endmodule

module top;
    reg a, b, sel;
    wire y_na, y_ansi;

    mux_non_ansi u_na (.a(a), .b(b), .sel(sel), .y(y_na));
    mux_ansi     u_a  (.a(a), .b(b), .sel(sel), .y(y_ansi));

    initial begin
        $display("Module 7: Port style - non-ANSI vs ANSI (same mux)");
        a = 0; b = 1; sel = 0;
        #10 $display("  sel=0: y_non_ansi=%b y_ansi=%b", y_na, y_ansi);
        sel = 1;
        #10 $display("  sel=1: y_non_ansi=%b y_ansi=%b", y_na, y_ansi);
        if (y_na === y_ansi) $display("  PASS: same behavior");
        else $display("  FAIL: mismatch");
        $finish;
    end
endmodule
