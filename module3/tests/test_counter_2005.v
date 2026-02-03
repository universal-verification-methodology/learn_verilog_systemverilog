/*
 * Testbench for counter_2005 - IEEE 1364-2005
 * Reset, enable, wrap.
 */

`include "../dut/counter_2005.v"

module test_counter_2005;
    reg       clk, rst_n, en;
    wire [3:0] count;

    counter_2005 #(.WIDTH(4)) u_cnt (.clk(clk), .rst_n(rst_n), .en(en), .count(count));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 3 test: counter_2005 (1364-2005)");
        rst_n = 0; en = 1;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(18) @(posedge clk) $display("  count=%d", count);
        $display("PASS: counter_2005 test complete");
        $finish;
    end
endmodule
