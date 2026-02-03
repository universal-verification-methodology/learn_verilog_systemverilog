/*
 * Module 8: Quick reference - prints one-page cheat sheet
 * No DUT; reference only. Use docs/ for full tables.
 */

module top;
    initial begin
        $display("=== Module 8: Quick Reference (one-page cheat sheet) ===");
        $display("  Version timeline: 1364-1995 -> 1364-2001 -> 1364-2005 -> 1800-2005 -> 1800-2009 -> 1800-2012 -> 1800-2017");
        $display("  Verilog-only (1364): wire/reg, always @* or @(inputs), always @(posedge clk); no logic, no interfaces, no packages");
        $display("  SystemVerilog design (1800): logic, always_comb, always_ff, interface+modport, package+import, unique/priority case");
        $display("  Migration 1364->1800: wire/reg->logic, @*->always_comb, posedge clk->always_ff, remove defparam, test");
        $display("  Version selection: match tools/IP; state one revision (e.g. 1800-2017) and subset; document in style guide");
        $display("  Full tables and course map: module8/docs/ and docs/MODULE8.md");
        $display("=== End quick reference ===");
        $finish;
    end
endmodule
