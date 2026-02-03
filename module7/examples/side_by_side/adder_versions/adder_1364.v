/*
 * Module 7: 8-bit adder - 1364-1995, 1364-2001, 1364-2005
 * Continuous assign; same behavior.
 */

module adder_1995(a, b, sum);
    input  [7:0] a, b;
    output [7:0] sum;
    wire   [7:0] a, b, sum;
    assign sum = a + b;
endmodule

module adder_2001 (
    input  wire [7:0] a, b,
    output wire [7:0] sum
);
    assign sum = a + b;
endmodule

module adder_2005 (
    input  wire [7:0] a, b,
    output wire [7:0] sum
);
    assign sum = a + b;
endmodule
