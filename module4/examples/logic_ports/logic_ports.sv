/*
 * logic ports only - IEEE 1800-2005
 * All ports logic; no wire/reg choice. assign and always_comb can drive output logic.
 */

module mux2 (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);
    always_comb
        y = sel ? b : a;
endmodule

module adder (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum
);
    assign sum = a + b;
endmodule

module top;
    logic a, b, sel, y;
    logic [7:0] av, bv, sum;

    mux2 u_mux (.a(a), .b(b), .sel(sel), .y(y));
    adder u_add (.a(av), .b(bv), .sum(sum));

    initial begin
        $display("logic ports (1800-2005): all ports logic; no wire/reg");
        a = 0; b = 1; sel = 1; av = 8'd10; bv = 8'd20;
        #10 $display("  mux: sel=%b a=%b b=%b y=%b", sel, a, b, y);
        #10 $display("  adder: a=%d b=%d sum=%d", av, bv, sum);
        $finish;
    end
endmodule
