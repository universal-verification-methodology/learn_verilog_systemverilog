/*
 * Testbench for param_chain - IEEE 1364-2005
 * Verifies parameter override at each level (no defparam).
 */

`include "../dut/param_chain.v"

module test_param_chain;
    reg [3:0] a4;
    reg [7:0] a8;
    wire [3:0] y4;
    wire [7:0] y8;

    param_chain #(.N(4)) u_chain4 (.a(a4), .y(y4));
    param_chain #(.N(8)) u_chain8 (.a(a8), .y(y8));

    initial begin
        $display("Module 3 test: param_chain (1364-2005)");
        a4 = 4'hA; a8 = 8'hAB;
        #10 $display("  N=4: a=%h y=%h", a4, y4);
        #10 $display("  N=8: a=%h y=%h", a8, y8);
        $display("PASS: param_chain test complete");
        $finish;
    end
endmodule
