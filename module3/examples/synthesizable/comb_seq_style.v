/*
 * Synthesizable combinational + sequential style - IEEE 1364-2005
 * Combinational: always @* and blocking =; sequential: always @(posedge clk) and nonblocking <=.
 * One driver per net; no latches (default or full case).
 */

module comb_seq_demo (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       a,
    input  wire       b,
    input  wire       c,
    output reg        y_comb,
    output reg        q_seq
);
    /* Combinational: always @*, blocking = */
    always @* begin
        y_comb = (a & b) | c;
    end

    /* Sequential: always @(posedge clk), nonblocking <= */
    always @(posedge clk) begin
        if (!rst_n)
            q_seq <= 0;
        else
            q_seq <= y_comb;
    end
endmodule

module top;
    reg clk, rst_n, a, b, c;
    wire y_comb, q_seq;

    comb_seq_demo u_dut (.clk(clk), .rst_n(rst_n), .a(a), .b(b), .c(c), .y_comb(y_comb), .q_seq(q_seq));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Synthesizable style (1364-2005): combo @* blocking, seq posedge nonblocking");
        rst_n = 0; a = 0; b = 0; c = 0;
        repeat(2) @(posedge clk);
        rst_n = 1;
        a = 1; b = 1; c = 0;
        repeat(3) @(posedge clk) $display("  y_comb=%b q_seq=%b", y_comb, q_seq);
        $finish;
    end
endmodule
