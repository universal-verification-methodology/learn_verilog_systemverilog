/*
 * Module 7: Top - run FSM versions and compare
 */

module top;
    logic clk, rst_n, go;
    logic [1:0] state1364, state1800;
    logic       done1364, done1800;

    fsm_1364 u1364 (.clk(clk), .rst_n(rst_n), .go(go), .state(state1364), .done(done1364));
    fsm_1800 u1800 (.clk(clk), .rst_n(rst_n), .go(go), .state(state1800), .done(done1800));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 7: Side-by-side FSM (1364 vs 1800)");
        rst_n = 0; go = 0;
        #20 rst_n = 1;
        #15 go = 1;
        #30 $display("  state1364=%b state1800=%b done1364=%b done1800=%b", state1364, state1800, done1364, done1800);
        if (state1364 === state1800 && done1364 === done1800)
            $display("  PASS: all versions match");
        else
            $display("  FAIL: mismatch");
        $finish;
    end
endmodule
