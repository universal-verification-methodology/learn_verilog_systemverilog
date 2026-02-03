/*
 * Signed vs unsigned comparison - IEEE 1364-2001
 * signed reg/wire; $signed() cast in expressions.
 */

module compare_demo (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output reg        lt_unsigned,
    output reg        lt_signed
);
    always @* begin
        lt_unsigned = a < b;
        lt_signed   = $signed(a) < $signed(b);
    end
endmodule

module top;
    reg [7:0] a, b;
    wire      lt_u, lt_s;

    compare_demo u_cmp (.a(a), .b(b), .lt_unsigned(lt_u), .lt_signed(lt_s));

    initial begin
        $display("Signed vs unsigned comparison (1364-2001): $signed() in expressions");
        a = 8'd200; b = 8'd50;  #10 $display("  a=%d b=%d  lt_unsigned=%b lt_signed=%b", a, b, lt_u, lt_s);
        a = 8'hF0;  b = 8'd10; #10 $display("  a=0x%h b=%d  lt_unsigned=%b lt_signed=%b", a, b, lt_u, lt_s);
        $finish;
    end
endmodule
