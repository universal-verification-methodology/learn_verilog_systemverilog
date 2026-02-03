/*
 * always and initial - IEEE 1364-1995 style
 *
 * Combinational: always @(a or b or c) with explicit sensitivity.
 * Sequential: always @(posedge clk) with nonblocking <=.
 * Testbench: initial with # delays and $finish.
 */

module procedural_demo;
    reg a, b, c;
    reg y_comb;
    reg q;
    reg clk;
    reg d;

    /* Combinational: explicit sensitivity list (no always @* in 1995) */
    always @(a or b or c)
        y_comb = (a & b) | c;

    /* Sequential: flip-flop with nonblocking */
    always @(posedge clk)
        q <= d;

    /* Clock generation */
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    /* Stimulus */
    initial begin
        a = 0; b = 0; c = 0; d = 0;
        #10 a = 1; b = 1; c = 0; d = 1;
        #10 $display("y_comb=%b q=%b", y_comb, q);
        #20 $finish;
    end
endmodule
