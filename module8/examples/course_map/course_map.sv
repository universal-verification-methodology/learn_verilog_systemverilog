/*
 * Module 8: Course map - module number, title, content summary
 * Reference only; see module8/docs/course_map.md for links.
 */

module top;
    initial begin
        $display("=== Module 8: Course map (Modules 1-8) ===");
        $display("  1 | IEEE 1364-1995    | Verilog-95: wire/reg, assign, always/initial, explicit sensitivity");
        $display("  2 | IEEE 1364-2001    | ANSI ports, always @*, generate, signed, arrays, localparam");
        $display("  3 | IEEE 1364-2005    | Clarifications, synthesizable subset, defparam deprecated");
        $display("  4 | IEEE 1800-2005    | logic, always_comb/always_ff, interfaces, packages, unique/priority case");
        $display("  5 | IEEE 1800-2009/12 | Interface refinements, checkers, array/string methods, assertions");
        $display("  6 | IEEE 1800-2017    | Unified LRM, Verilog as subset of 1800, current standard");
        $display("  7 | Version comparison| Side-by-side, migration patterns, tool support, checklists");
        $display("  8 | Quick reference   | This module: tables, cheat sheet, course map");
        $display("  Learning path: 1->2->3->4->5->6 (version order); then 7; use 8 as reference");
        $display("  Links: module8/docs/course_map.md");
        $display("=== End course map ===");
        $finish;
    end
endmodule
