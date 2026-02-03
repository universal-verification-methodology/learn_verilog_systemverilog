/*
 * Testbench for mux2_sv - IEEE 1800-2005
 */

`include "../dut/mux2_sv.sv"

module test_mux2_sv;
    logic a, b, sel, y;

    mux2_sv u_dut (.a(a), .b(b), .sel(sel), .y(y));

    initial begin
        $display("Module 4 test: mux2_sv (1800-2005)");
        $display("sel a b | y");
        a = 0; b = 0; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 1; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 0; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 1; sel = 0; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 0; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 0; b = 1; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 0; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        a = 1; b = 1; sel = 1; #10 $display(" %b  %b %b | %b", sel, a, b, y);
        $display("PASS: mux2_sv test complete");
        $finish;
    end
endmodule
