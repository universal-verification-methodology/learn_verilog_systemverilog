/*
 * Two-stage pipeline - IEEE 1364-2005
 * Sequential blocks only; nonblocking <=. q2 gets old q1 (previous cycle).
 */

module pipeline_2stage (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] d,
    output reg  [3:0] q1,
    output reg  [3:0] q2
);
    always @(posedge clk) begin
        if (!rst_n) begin
            q1 <= 0;
            q2 <= 0;
        end else begin
            q1 <= d;
            q2 <= q1;
        end
    end
endmodule

module top;
    reg clk, rst_n;
    reg [3:0] d;
    wire [3:0] q1, q2;

    pipeline_2stage u_pipe (.clk(clk), .rst_n(rst_n), .d(d), .q1(q1), .q2(q2));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Two-stage pipeline (1364-2005): nonblocking only; q2 <= q1 (old value)");
        rst_n = 0; d = 4'd0;
        repeat(2) @(posedge clk);
        rst_n = 1;
        d = 4'd1; @(posedge clk) $display("  d=%d q1=%d q2=%d", d, q1, q2);
        d = 4'd2; @(posedge clk) $display("  d=%d q1=%d q2=%d", d, q1, q2);
        d = 4'd3; @(posedge clk) $display("  d=%d q1=%d q2=%d", d, q1, q2);
        $finish;
    end
endmodule
