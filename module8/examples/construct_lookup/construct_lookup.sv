/*
 * Module 8: Construct lookup - "which standard has X?"
 * First standard that introduced each; see module8/docs/version_table.md for full table.
 */

module top;
    initial begin
        $display("=== Module 8: Construct lookup (first standard) ===");
        $display("  logic              -> 1800-2005");
        $display("  always_comb/always_ff -> 1800-2005");
        $display("  interface, modport -> 1800-2005");
        $display("  package, import    -> 1800-2005");
        $display("  unique/priority case -> 1800-2005");
        $display("  always @*          -> 1364-2001");
        $display("  ANSI ports         -> 1364-2001");
        $display("  generate           -> 1364-2001");
        $display("  signed             -> 1364-2001");
        $display("  localparam         -> 1364-2001");
        $display("  defparam           -> 1364-1995 (deprecated in 1364-2005)");
        $display("  Checker            -> 1800-2012");
        $display("  Unified LRM        -> 1800-2017");
        $display("  Full table: module8/docs/version_table.md");
        $display("=== End construct lookup ===");
        $finish;
    end
endmodule
