/*
 * Synthesizable function - IEEE 1364-2005
 * Function without delays; used in always @* for combinational helper.
 */

module min2 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output reg  [7:0] y
);
    function [7:0] min8(input [7:0] x, input [7:0] z);
        min8 = (x < z) ? x : z;
    endfunction

    always @*
        y = min8(a, b);
endmodule

module top;
    reg [7:0] a, b;
    wire [7:0] y;

    min2 u_min (.a(a), .b(b), .y(y));

    initial begin
        $display("Synthesizable function (1364-2005): no delays; used in always @*");
        a = 8'd50; b = 8'd30; #10 $display("  min(%d,%d)=%d", a, b, y);
        a = 8'd10; b = 8'd99; #10 $display("  min(%d,%d)=%d", a, b, y);
        $finish;
    end
endmodule
