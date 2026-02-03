/*
 * Module 8: Tool support summary - simulators, synthesis, lint, formal
 * Reference only; see docs/MODULE8.md Section 5.
 */

module top;
    initial begin
        $display("=== Module 8: Tool support summary ===");
        $display("  Simulators: 1364-2001/2005; 1800 subset varies by tool");
        $display("  Synthesis:  Synthesizable subset of 1364 and/or 1800; revision varies");
        $display("  Lint:       1364 and 1800; often selectable revision");
        $display("  Formal:     Assertions/checkers (1800); revision varies");
        $display("  Icarus:     Primarily 1364-2001/2005; limited SystemVerilog");
        $display("  Verilator:  1364 and growing 1800 subset");
        $display("  Commercial (VCS, Questa, Xcelium): Typically 1800-2005 through 1800-2017");
        $display("  Match project standard to simulator, synthesis, and IP support.");
        $display("=== End tool support ===");
        $finish;
    end
endmodule
