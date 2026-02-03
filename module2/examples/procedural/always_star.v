/*
 * always @* - IEEE 1364-2001 implicit sensitivity
 *
 * Sensitive to every signal read in the block; no manual list.
 */

module comb_demo (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire sel,
    output reg  y_comb,
    output reg  mux_out
);
    /* Implicit sensitivity: tool infers a, b, c and sel, a, b */
    always @* begin
        y_comb = (a & b) | c;
    end

    always @* begin
        mux_out = sel ? b : a;
    end
endmodule

module top;
    reg a, b, c, sel;
    wire y_comb, mux_out;

    comb_demo u_dut (.a(a), .b(b), .c(c), .sel(sel), .y_comb(y_comb), .mux_out(mux_out));

    initial begin
        $display("always @* (1364-2001): implicit sensitivity");
        $display("a b c sel | y_comb mux_out");
        a = 0; b = 0; c = 0; sel = 0; #10 $display("%b %b %b  %b  |    %b      %b", a, b, c, sel, y_comb, mux_out);
        a = 1; b = 1; c = 0; sel = 0; #10 $display("%b %b %b  %b  |    %b      %b", a, b, c, sel, y_comb, mux_out);
        a = 0; b = 1; c = 0; sel = 1; #10 $display("%b %b %b  %b  |    %b      %b", a, b, c, sel, y_comb, mux_out);
        $finish;
    end
endmodule
