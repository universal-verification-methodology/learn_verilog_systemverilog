/*
 * typedef - IEEE 1800-2005
 * User-defined types for clarity; can be in package or module.
 */

module byte_adder (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum
);
    typedef logic [7:0] byte_t;
    byte_t aa, bb;
    assign aa = a;
    assign bb = b;
    assign sum = aa + bb;
endmodule

module top;
    logic [7:0] a, b, sum;

    byte_adder u_add (.a(a), .b(b), .sum(sum));

    initial begin
        $display("typedef (1800-2005): byte_t = logic [7:0]");
        a = 8'd50; b = 8'd30; #10 $display("  a=%d b=%d sum=%d", a, b, sum);
        $finish;
    end
endmodule
