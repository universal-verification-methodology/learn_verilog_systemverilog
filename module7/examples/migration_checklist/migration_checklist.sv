/*
 * Module 7: Migration checklist reminder (1364 -> 1800 design subset)
 * Prints steps; full checklist in MODULE7.md.
 */

module top;
    initial begin
        $display("Module 7: Migration checklist (1364 -> 1800 design subset)");
        $display("  Pre: target standard, baseline sim/synth, list files/hierarchy");
        $display("  Per-module: ports wire/reg->logic, @*->always_comb, posedge clk->always_ff");
        $display("  Per-module: case->unique/priority case, optional interface/package, no defparam");
        $display("  Post: full regression, update style guide, document 1364-only blocks");
        $display("  See MODULE7.md for full migration checklist.");
        $finish;
    end
endmodule
