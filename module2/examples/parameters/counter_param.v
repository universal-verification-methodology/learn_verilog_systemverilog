/*
 * Counter with parameter and localparam - IEEE 1364-2001
 * parameter WIDTH overridable; localparam MAX derived, not overridable.
 */

module counter_param #(parameter WIDTH = 8) (
    input  wire clk,
    input  wire rst_n,
    input  wire en,
    output reg  [WIDTH-1:0] count
);
    localparam MAX = (1 << WIDTH) - 1;

    always @(posedge clk) begin
        if (!rst_n)
            count <= 0;
        else if (en)
            count <= (count == MAX) ? 0 : count + 1;
    end
endmodule

module top;
    reg clk, rst_n, en;
    wire [3:0] count;

    counter_param #(.WIDTH(4)) u_cnt (.clk(clk), .rst_n(rst_n), .en(en), .count(count));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("parameter and localparam (1364-2001): WIDTH=4, MAX=15");
        rst_n = 0; en = 1;
        repeat(4) @(posedge clk);
        rst_n = 1;
        repeat(20) @(posedge clk) $display("  count=%d", count);
        $finish;
    end
endmodule
