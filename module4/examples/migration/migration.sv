/*
 * Migration 1364-2005 to 1800-2005 - IEEE 1800 design subset
 * Same mux: wire/reg + always @*  vs  logic + always_comb.
 */

/* 1800-2005 style: logic, always_comb */
module mux2_sv (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);
    always_comb
        y = sel ? b : a;
endmodule

module top;
    logic a, b, sel, y;

    mux2_sv u_mux (.a(a), .b(b), .sel(sel), .y(y));

    initial begin
        $display("Migration (1800-2005): logic + always_comb (was wire/reg + always @*)");
        a = 0; b = 1; sel = 0; #10 $display("  sel=%b a=%b b=%b y=%b", sel, a, b, y);
        sel = 1; #10 $display("  sel=%b a=%b b=%b y=%b", sel, a, b, y);
        $finish;
    end
endmodule
