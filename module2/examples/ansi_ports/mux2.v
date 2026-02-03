/*
 * 2:1 multiplexer - IEEE 1364-2001 ANSI style
 *
 * Port direction and type in port list (no separate declarations).
 */

module mux2_2001 (
    input  wire a,
    input  wire b,
    input  wire sel,
    output reg  y
);
    always @(a or b or sel)
        y = sel ? b : a;
endmodule

module top;
    reg  a, b, sel;
    wire y;

    mux2_2001 u_mux (.a(a), .b(b), .sel(sel), .y(y));

    initial begin
        $display("ANSI ports (1364-2001): direction and type in port list");
        $display("sel a b | y");
        a = 0; b = 0; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 1; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 0; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 1; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 0; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 1; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 0; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 1; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        $finish;
    end
endmodule
