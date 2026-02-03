/*
 * Module 8: Synthesizable subset quick reference
 * Do / avoid in RTL; see docs/MODULE8.md Section 3.
 */

module top;
    initial begin
        $display("=== Module 8: Synthesizable subset (both 1364 and 1800) ===");
        $display("  Do: assign, always_comb or always @*, always_ff or always @(posedge clk)");
        $display("  Do: generate, parameter, localparam, single driver per net");
        $display("  Avoid: Delays (#), initial (except FPGA init per tool), fork/join");
        $display("  Avoid: system tasks in RTL, defparam, multiple drivers (unless tri-state), unintended latches");
        $display("  Check: Tool manual for exact synthesizable subset and revision");
        $display("=== End synthesizable subset ===");
        $finish;
    end
endmodule
