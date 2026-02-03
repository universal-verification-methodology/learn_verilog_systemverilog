/*
 * Testbench for counter_sv - IEEE 1800-2005
 */

`include "../dut/counter_sv.sv"

module test_counter_sv;
    logic clk, rst_n, en;
    logic [3:0] count;

    counter_sv #(.WIDTH(4)) u_cnt (.clk(clk), .rst_n(rst_n), .en(en), .count(count));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 4 test: counter_sv (1800-2005)");
        rst_n = 0; en = 1;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(18) @(posedge clk) $display("  count=%d", count);
        $display("PASS: counter_sv test complete");
        $finish;
    end
endmodule
