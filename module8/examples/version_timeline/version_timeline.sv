/*
 * Module 8: Version timeline - prints standard, year, role, module
 * Reference only; see docs/MODULE8.md and module8/docs/
 */

module top;
    initial begin
        $display("=== Module 8: Version timeline ===");
        $display("  1364-1995 | 1995 | First Verilog; base language           | Module 1");
        $display("  1364-2001 | 2001 | ANSI, @*, generate, signed             | Module 2");
        $display("  1364-2005 | 2005 | Last Verilog-only; defparam deprecated  | Module 3");
        $display("  1800-2005 | 2005 | First SystemVerilog; logic, always_comb/ff | Module 4");
        $display("  1800-2009 | 2009 | Interface refinements; clarifications   | Module 5");
        $display("  1800-2012 | 2012 | Checker; array/string methods           | Module 5");
        $display("  1800-2017 | 2017 | Unified LRM; current standard           | Module 6");
        $display("  Comparison and migration                                   | Module 7");
        $display("  Quick reference and summary                                | Module 8");
        $display("  Path: 1->2->3->4->5->6 (version order); 7 (comparison); 8 (reference)");
        $display("=== End version timeline ===");
        $finish;
    end
endmodule
