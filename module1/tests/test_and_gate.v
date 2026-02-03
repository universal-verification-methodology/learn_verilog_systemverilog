/*
 * Testbench for and_gate DUT - IEEE 1364-1995 style
 *
 * Exhaustive input combinations; $display and $finish.
 */

module test_and_gate;
    reg  a, b;
    wire y;

    and_gate u_dut (.a(a), .b(b), .y(y));

    initial begin
        $display("Module 1 test: and_gate (1364-1995)");
        $display("a b y");
        a = 0; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 0; b = 1; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 1; #10 $display("%b %b %b", a, b, y);
        $display("PASS: and_gate test complete");
        $finish;
    end
endmodule
