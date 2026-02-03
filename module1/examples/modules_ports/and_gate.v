/*
 * Module and top - IEEE 1364-1995 style
 *
 * Demonstrates: non-ANSI ports, separate direction/type, named instantiation.
 */

module and_gate(a, b, y);
    input  a;
    input  b;
    output y;

    wire a, b;
    reg  y;

    always @(a or b)
        y = a & b;
endmodule

module top;
    reg  in1, in2;   /* driven in initial -> reg */
    wire out;        /* driven by and_gate output -> wire */

    and_gate u_and (.a(in1), .b(in2), .y(out));

    initial begin
        in1 = 0; in2 = 0; #10 $display("a=%b b=%b y=%b", in1, in2, out);
        in1 = 0; in2 = 1; #10 $display("a=%b b=%b y=%b", in1, in2, out);
        in1 = 1; in2 = 0; #10 $display("a=%b b=%b y=%b", in1, in2, out);
        in1 = 1; in2 = 1; #10 $display("a=%b b=%b y=%b", in1, in2, out);
        $finish;
    end
endmodule
