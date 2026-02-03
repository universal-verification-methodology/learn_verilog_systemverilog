/*
 * 2:1 multiplexer - IEEE 1364-1995 style
 *
 * Combinational logic with assign; all ports wire.
 */

module mux2_1995(a, b, sel, y);
    input  a;
    input  b;
    input  sel;
    output y;

    wire a, b, sel, y;

    assign y = sel ? b : a;
endmodule

module top;
    reg  a, b, sel;
    wire y;

    mux2_1995 u_mux (.a(a), .b(b), .sel(sel), .y(y));

    initial begin
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
