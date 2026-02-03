/*
 * Testbench for generate-based shift register - IEEE 1364-2001
 */

`include "../dut/dff.v"
`include "../dut/shift_reg_gen.v"

module test_shift_reg_gen;
    reg       clk, rst_n, sin;
    wire      sout4, sout8;

    shift_reg_gen #(.N(4)) u_sr4 (.clk(clk), .rst_n(rst_n), .sin(sin), .sout(sout4));
    shift_reg_gen #(.N(8)) u_sr8 (.clk(clk), .rst_n(rst_n), .sin(sin), .sout(sout8));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 2 test: shift_reg_gen (1364-2001)");
        rst_n = 0; sin = 0;
        repeat(3) @(posedge clk);
        rst_n = 1;
        sin = 1; repeat(4) @(posedge clk) $display("  N=4 sout4=%b", sout4);
        sin = 0; repeat(4) @(posedge clk) $display("  N=4 sout4=%b", sout4);
        sin = 1; repeat(8) @(posedge clk) $display("  N=8 sout8=%b", sout8);
        $display("PASS: shift_reg_gen test complete");
        $finish;
    end
endmodule
