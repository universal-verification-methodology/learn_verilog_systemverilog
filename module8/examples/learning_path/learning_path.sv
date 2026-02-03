/*
 * Module 8: Learning path and where to go next
 * 1->2->3->4->5->6 then 7; use 8 as reference. See docs/MODULE8.md Section 7.
 */

module top;
    initial begin
        $display("=== Module 8: Learning path and next steps ===");
        $display("  Learning path: 1 -> 2 -> 3 -> 4 -> 5 -> 6 (version order)");
        $display("  Then: Module 7 (comparison and migration); use Module 8 as reference anytime");
        $display("  Where to go next:");
        $display("    Project: Apply version selection and migration (Module 7); use Module 8 as quick reference");
        $display("    LRM: IEEE 1800-2017 for authoritative syntax and semantics");
        $display("    Tools: Simulator, synthesis, lint manuals for supported revision and synthesizable subset");
        $display("    Related: RTL design patterns, UVM, SVA, tool-specific training");
        $display("    New revisions: Add new module; update Module 7 and Module 8 tables");
        $display("=== End learning path ===");
        $finish;
    end
endmodule
