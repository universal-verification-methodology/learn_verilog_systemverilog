/*
 * Minimal testbench - IEEE 1364-1995 style
 *
 * DUT: and_gate. Stimulus: initial with # delays. Output: $display, $finish.
 */

module test_and_gate;
    reg  a, b;
    wire y;

    and_gate u_dut (.a(a), .b(b), .y(y));

    initial begin
        $display("a b y");
        a = 0; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 0; b = 1; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 1; #10 $display("%b %b %b", a, b, y);
        $finish;
    end
endmodule
