/*
 * Module 7: Version table reference (1995 -> 2017)
 * Prints minimal construct-vs-standard reminder; full table in docs.
 */

module top;
    initial begin
        $display("Module 7: Version table (construct vs standard)");
        $display("  Port style:  1995 non-ANSI | 2001+ ANSI");
        $display("  Type:        1364 wire/reg | 1800 logic (single driver)");
        $display("  Combinational: 1995 @(a or b) | 2001 @* | 1800 always_comb");
        $display("  Sequential:  1364 always @(posedge clk) | 1800 always_ff");
        $display("  Connectivity: 1364 many ports | 1800 interface+modport");
        $display("  Case:        1364 case | 1800 unique/priority case");
        $display("  Reference:   1800-2017 single LRM (Verilog + SystemVerilog)");
        $finish;
    end
endmodule
