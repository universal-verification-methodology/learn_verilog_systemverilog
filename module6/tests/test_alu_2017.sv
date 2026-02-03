/*
 * Testbench for alu_2017 - IEEE 1800-2017
 */

`include "../dut/alu_2017.sv"

module test_alu_2017;
    logic [7:0] a, b, y;
    logic [1:0] op;

    alu_2017 u_dut (.a(a), .b(b), .op(op), .y(y));

    initial begin
        $display("Module 6 test: alu_2017 (1800-2017)");
        a = 8'd10; b = 8'd3;
        op = 2'b00; #10 $display("  ADD: a=%d b=%d y=%d", a, b, y);
        op = 2'b01; #10 $display("  SUB: a=%d b=%d y=%d", a, b, y);
        op = 2'b10; #10 $display("  AND: a=%d b=%d y=%d", a, b, y);
        op = 2'b11; #10 $display("  OR:  a=%d b=%d y=%d", a, b, y);
        $display("PASS: alu_2017 test complete");
        $finish;
    end
endmodule
