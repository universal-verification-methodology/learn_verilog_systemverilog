/*
 * Module 8: Version selection quick reference
 * Match tools/IP; state one revision and subset; document. See MODULE7 for full checklist.
 */

module top;
    initial begin
        $display("=== Module 8: Version selection quick reference ===");
        $display("  Match: project standard to simulator, synthesis, and IP support");
        $display("  State: one revision (e.g. IEEE 1800-2017) and subset (e.g. design only, no SVA in RTL)");
        $display("  Document: in style guide or README; reference LRM and tool manuals");
        $display("  Verilog-only: use when tools or IP require 1364; 1364-2005 as reference");
        $display("  SystemVerilog design: use when flow supports 1800; 1800-2017 as reference");
        $display("  Full checklist: docs/MODULE7.md (version-selection checklist)");
        $display("=== End version selection ===");
        $finish;
    end
endmodule
