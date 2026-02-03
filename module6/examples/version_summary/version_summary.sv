/*
 * IEEE 1800-2017: Version timeline summary (1995 -> 2017)
 * Small design using 2017 subset; display reminds which standard added what.
 */

module mux_2017 (
    input  logic [1:0] sel,
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] y
);
    always_comb begin
        unique case (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
            default: y = a;
        endcase
    end
endmodule

module top;
    logic [1:0] sel;
    logic [7:0] a, b, c, d, y;

    mux_2017 u (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y));

    initial begin
        $display("1800-2017: Version timeline (1364-1995 -> 1800-2017)");
        $display("  1364-1995: wire/reg, always, initial");
        $display("  1364-2001: ANSI ports, always @*, generate");
        $display("  1364-2005: last Verilog-only");
        $display("  1800-2005: logic, always_comb/always_ff, interfaces, packages");
        $display("  1800-2009/2012: inside/==?, checkers, array methods");
        $display("  1800-2017: unified LRM (Verilog + SystemVerilog in one standard)");
        a = 8'h1; b = 8'h2; c = 8'h4; d = 8'h8;
        sel = 2'b11; #10 $display("  sel=%b y=%h", sel, y);
        $finish;
    end
endmodule
