/*
 * 1364-2005 summary - Small design using only 1364-2005 (no 1800)
 * Checklist: ANSI ports, @*, parameter at instantiation, blocking/nonblocking, no defparam.
 */

module small_2005 #(parameter W = 4) (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [W-1:0] a,
    input  wire [W-1:0] b,
    output reg  [W-1:0] sum
);
    always @(posedge clk) begin
        if (!rst_n)
            sum <= 0;
        else
            sum <= a + b;
    end
endmodule

module top;
    reg clk, rst_n;
    reg [3:0] a, b;
    wire [3:0] sum;

    small_2005 #(.W(4)) u_dut (.clk(clk), .rst_n(rst_n), .a(a), .b(b), .sum(sum));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("1364-2005 summary: ANSI, param at inst, nonblocking, no defparam");
        rst_n = 0; a = 4'd3; b = 4'd5;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(3) @(posedge clk) $display("  a=%d b=%d sum=%d", a, b, sum);
        $finish;
    end
endmodule
