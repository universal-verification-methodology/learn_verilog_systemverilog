/*
 * Module 7: Test all counter versions - same stimulus, compare
 */

`include "../dut/counter_1364.v"
`include "../dut/counter_1800.sv"

module test_counter_all;
    logic clk, rst_n, en;
    logic [3:0] c1995, c2001, c2005, c1800;

    counter_1995 u1995 (.clk(clk), .rst_n(rst_n), .en(en), .count(c1995));
    counter_2001 u2001 (.clk(clk), .rst_n(rst_n), .en(en), .count(c2001));
    counter_2005 u2005 (.clk(clk), .rst_n(rst_n), .en(en), .count(c2005));
    counter_1800 u1800 (.clk(clk), .rst_n(rst_n), .en(en), .count(c1800));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 7 test: counter all versions (1995, 2001, 2005, 1800)");
        rst_n = 0; en = 1;
        #20 rst_n = 1;
        #80 $display("  count: c1995=%d c2001=%d c2005=%d c1800=%d", c1995, c2001, c2005, c1800);
        if (c1995 === c2001 && c2001 === c2005 && c2005 === c1800) begin
            $display("PASS: counter all versions match");
        end else begin
            $display("FAIL: counter version mismatch");
        end
        $finish;
    end
endmodule
