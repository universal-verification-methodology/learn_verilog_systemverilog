/*
 * Signed adder - IEEE 1364-2001 signed types
 * signed reg/wire; $signed/$unsigned for casts.
 */

module adder_signed (
    input  wire signed [7:0] a,
    input  wire signed [7:0] b,
    output wire signed [8:0] sum_signed,
    output wire [8:0]       sum_unsigned
);
    assign sum_signed   = a + b;
    assign sum_unsigned = $unsigned(a) + $unsigned(b);
endmodule

module top;
    reg signed [7:0] a, b;
    wire signed [8:0] sum_s;
    wire [8:0] sum_u;

    adder_signed u_add (.a(a), .b(b), .sum_signed(sum_s), .sum_unsigned(sum_u));

    initial begin
        $display("Signed (1364-2001): signed reg/wire, $signed/$unsigned");
        a = 8'sd50;  b = 8'sd30;  #10 $display("  a=%d b=%d sum_signed=%d sum_unsigned=%d", a, b, sum_s, sum_u);
        a = -8'sd10; b = 8'sd20;  #10 $display("  a=%d b=%d sum_signed=%d sum_unsigned=%d", a, b, sum_s, sum_u);
        a = -8'sd100; b = -8'sd30; #10 $display("  a=%d b=%d sum_signed=%d sum_unsigned=%d", a, b, sum_s, sum_u);
        $finish;
    end
endmodule
