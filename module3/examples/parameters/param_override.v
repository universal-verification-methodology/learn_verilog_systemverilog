/*
 * Parameter override at instantiation - IEEE 1364-2005
 * No defparam (deprecated); use #(.PARAM(value)) at instantiation only.
 */

module adder #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output wire [WIDTH-1:0] y
);
    assign y = a + b;
endmodule

module top;
    reg [3:0] a4, b4;
    reg [7:0] a8, b8;
    wire [3:0] y4;
    wire [7:0] y8;

    /* Override at instantiation only (no defparam) */
    adder #(.WIDTH(4)) u_add4 (.a(a4), .b(b4), .y(y4));
    adder #(.WIDTH(8)) u_add8 (.a(a8), .b(b8), .y(y8));

    initial begin
        $display("Parameter override at instantiation (1364-2005): no defparam");
        a4 = 4'd3; b4 = 4'd5; a8 = 8'd10; b8 = 8'd20;
        #10 $display("  4-bit: %d + %d = %d", a4, b4, y4);
        #10 $display("  8-bit: %d + %d = %d", a8, b8, y8);
        $finish;
    end
endmodule
