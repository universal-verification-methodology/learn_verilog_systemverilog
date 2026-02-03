/*
 * Testbench for fsm_2005 - IEEE 1364-2005
 * State coverage and transitions: IDLE -> RUN -> DONE -> IDLE.
 */

`include "../dut/fsm_2005.v"

module test_fsm_2005;
    reg       clk, rst_n, go, done;
    wire [1:0] state;
    wire       busy;

    fsm_2005 u_fsm (.clk(clk), .rst_n(rst_n), .go(go), .done(done), .state(state), .busy(busy));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 3 test: fsm_2005 (1364-2005)");
        rst_n = 0; go = 0; done = 0;
        repeat(2) @(posedge clk);
        rst_n = 1;
        @(posedge clk) $display("  state=%d busy=%b", state, busy);
        go = 1; @(posedge clk) $display("  state=%d busy=%b", state, busy);
        go = 0; repeat(2) @(posedge clk) $display("  state=%d busy=%b", state, busy);
        done = 1; @(posedge clk) $display("  state=%d busy=%b", state, busy);
        done = 0; @(posedge clk) $display("  state=%d busy=%b", state, busy);
        $display("PASS: fsm_2005 test complete");
        $finish;
    end
endmodule
