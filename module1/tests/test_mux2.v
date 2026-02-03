/*
 * Testbench for 2:1 mux - IEEE 1364-1995 style
 *
 * DUT: mux2_1995 (from examples/continuous_assign or copy).
 * All input combinations; delay-based stimulus.
 */

module test_mux2;
    reg  a, b, sel;
    wire y;

    mux2_1995 u_dut (.a(a), .b(b), .sel(sel), .y(y));

    initial begin
        $display("Module 1 test: mux2_1995 (1364-1995)");
        $display("sel a b | y");
        a = 0; b = 0; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 1; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 0; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 1; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 0; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 1; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 0; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 1; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        $display("PASS: mux2 test complete");
        $finish;
    end
endmodule
