/*
 * Parameterized 2:1 multiplexer - IEEE 1364-2001
 * ANSI ports, parameter for width.
 */

module mux_2to1_param #(parameter WIDTH = 1) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             sel,
    output reg  [WIDTH-1:0] y
);
    always @*
        y = sel ? b : a;
endmodule
