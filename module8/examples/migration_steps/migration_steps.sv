/*
 * Module 8: Migration steps quick reference
 * 1995->2001, 1364->1800, 1800->1800; rules of thumb. See MODULE7.md for full checklist.
 */

module top;
    initial begin
        $display("=== Module 8: Migration steps quick reference ===");
        $display("  1364-1995 -> 1364-2001:");
        $display("    1. Ports -> ANSI  2. Comb -> always @*  3. generate/signed/localparam if needed  4. Test");
        $display("  1364-2001/2005 -> 1800 (design subset):");
        $display("    1. wire/reg -> logic  2. always @* -> always_comb  3. posedge clk -> always_ff");
        $display("    4. Optional: interfaces, packages, unique/priority case  5. Remove defparam  6. Test");
        $display("  1800-2005 -> 1800-2009/2012/2017:");
        $display("    1. Run regression (usually compatible)  2. Adopt new features if supported  3. Set project standard");
        $display("  Rules: one block/feature at a time; keep external interface unchanged; one standard, document subset");
        $display("  Full checklists: docs/MODULE7.md");
        $display("=== End migration steps ===");
        $finish;
    end
endmodule
