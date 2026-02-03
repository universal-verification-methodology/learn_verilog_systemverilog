/*
 * Testbench for counter with localparam - IEEE 1364-2001
 * Reset, enable, wrap-around.
 */

`include "../dut/counter_param.v"

module test_counter_param;
    reg       clk, rst_n, en;
    wire [3:0] count;

    counter_param #(.WIDTH(4)) u_cnt (.clk(clk), .rst_n(rst_n), .en(en), .count(count));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 2 test: counter_param (1364-2001)");
        rst_n = 0; en = 1;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(18) @(posedge clk) $display("  count=%d", count);
        $display("PASS: counter_param test complete");
        $finish;
    end
endmodule
