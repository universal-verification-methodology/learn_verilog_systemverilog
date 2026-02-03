/*
 * Module 8: Design subset quick reference - Verilog-only vs SystemVerilog design
 * Reference only; see docs/MODULE8.md Section 3.
 */

module top;
    initial begin
        $display("=== Module 8: Design subset quick reference ===");
        $display("  Verilog-only (1364):");
        $display("    Ports: ANSI (2001+) or non-ANSI (1995)");
        $display("    Types: wire, reg (no logic)");
        $display("    Comb: always @* or always @(inputs)");
        $display("    Seq:  always @(posedge clk) with <=");
        $display("    No: logic, always_comb/always_ff, interfaces, packages, unique/priority case");
        $display("  SystemVerilog design (1800):");
        $display("    Ports: ANSI; logic typical");
        $display("    Types: logic (single driver)");
        $display("    Comb: always_comb");
        $display("    Seq:  always_ff with <=");
        $display("    Connectivity: interface+modport; package+import; unique/priority case");
        $display("  Use 1364 when: tools or IP require Verilog only");
        $display("  Use 1800 when: flow supports 1800; preferred for new RTL");
        $display("=== End design subset ===");
        $finish;
    end
endmodule
