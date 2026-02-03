/*
 * Testbench for small_fsm_sv - IEEE 1800-2009/2012
 * FSM with immediate assertion (one-hot state).
 */

`include "../dut/small_fsm_sv.sv"

module test_fsm_assert;
    logic clk, rst_n, go, done;
    logic [2:0] state;
    logic       busy;

    small_fsm_sv u_fsm (.clk(clk), .rst_n(rst_n), .go(go), .done(done), .state(state), .busy(busy));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 5 test: small_fsm_sv (1800-2009/2012)");
        rst_n = 0; go = 0; done = 0;
        repeat(2) @(posedge clk);
        rst_n = 1;
        @(posedge clk) $display("  state=%b busy=%b", state, busy);
        go = 1; @(posedge clk) $display("  state=%b busy=%b", state, busy);
        go = 0; repeat(2) @(posedge clk) $display("  state=%b busy=%b", state, busy);
        done = 1; @(posedge clk) $display("  state=%b busy=%b", state, busy);
        done = 0; @(posedge clk) $display("  state=%b busy=%b", state, busy);
        $display("PASS: small_fsm_sv test complete");
        $finish;
    end
endmodule
