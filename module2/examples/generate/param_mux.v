/*
 * Parameterized mux with generate if - IEEE 1364-2001
 * generate for / generate if; elaboration-time logic.
 */

module mux_wide #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             sel,
    output wire [WIDTH-1:0] y
);
    generate
        if (WIDTH == 1)
            assign y = sel ? b : a;
        else
            assign y = sel ? b : a;
    endgenerate
endmodule

/* N-bit mux using generate for: bit-by-bit or single assign (both valid) */
module mux_nbit #(parameter N = 4) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire         sel,
    output wire [N-1:0] y
);
    wire [N-1:0] sel_bus;
    assign sel_bus = {N{sel}};
    assign y = (a & ~sel_bus) | (b & sel_bus);
endmodule

module top;
    reg [3:0] a, b;
    reg       sel;
    wire [3:0] y;

    mux_nbit #(.N(4)) u_mux (.a(a), .b(b), .sel(sel), .y(y));

    initial begin
        $display("Generate (1364-2001): parameterized mux");
        a = 4'b1010; b = 4'b0101; sel = 0; #10 $display("  sel=%b a=%b b=%b y=%b", sel, a, b, y);
        sel = 1; #10 $display("  sel=%b a=%b b=%b y=%b", sel, a, b, y);
        $finish;
    end
endmodule
