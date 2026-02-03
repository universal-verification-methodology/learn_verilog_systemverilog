/*
 * Module 7: Version selection checklist reminder
 * Prints decision steps; full checklist in MODULE7.md.
 */

module top;
    initial begin
        $display("Module 7: Version selection checklist (reminder)");
        $display("  Constraints: tools (sim/synth), IP/legacy, team, target (FPGA/ASIC)");
        $display("  Verilog-only (1364): wire/reg, always @*, no logic/interfaces/packages");
        $display("  SystemVerilog design (1800): logic, always_comb/always_ff, packages, unique/priority case");
        $display("  Decision: state one revision (e.g. IEEE 1800-2017); define subset if needed");
        $display("  Document: style guide or README; reference LRM and tool manuals");
        $display("  See MODULE7.md for full version-selection checklist.");
        $finish;
    end
endmodule
