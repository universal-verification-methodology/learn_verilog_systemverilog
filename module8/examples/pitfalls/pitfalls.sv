/*
 * Module 8: Common pitfalls quick reference
 * See docs/MODULE8.md Common Pitfalls section.
 */

module top;
    initial begin
        $display("=== Module 8: Common pitfalls (quick reference) ===");
        $display("  1. Assuming a construct is in an older standard -> Use construct-by-standard table (Section 2)");
        $display("  2. Mixing subsets without a rule -> Define one project subset and revision; document in style guide");
        $display("  3. Skipping regression after migration -> Run sim/synth after every step; use Module 7 checklist");
        $display("  4. Forgetting tool support -> Match project standard to tool-supported revision and synthesizable subset");
        $display("  5. Treating Module 8 as replacement for 1-7 -> Use Module 8 for quick lookup; refer to Modules 1-7 for depth");
        $display("  Full pitfalls: docs/MODULE8.md Common Pitfalls and How to Avoid Them");
        $display("=== End pitfalls ===");
        $finish;
    end
endmodule
