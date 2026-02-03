/*
 * Blocking vs nonblocking - IEEE 1364-2005 clarified
 * Combinational: blocking = (order can matter in same time step).
 * Sequential: nonblocking <= (order does not matter; update at end of time step).
 */

module blocking_nonblocking_demo (
    input  wire       clk,
    input  wire       a,
    input  wire       b,
    input  wire       c,
    input  wire       d1,
    input  wire       d2,
    output reg        y_comb,
    output reg        z_comb,
    output reg        q1,
    output reg        q2
);
    /* Combinational: blocking; z uses updated y in same time step */
    always @* begin
        y_comb = a & b;
        z_comb = y_comb | c;
    end

    /* Sequential: nonblocking; q2 gets OLD q1 (previous cycle) */
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= q1;
    end
endmodule

module top;
    reg clk, a, b, c, d1, d2;
    wire y_comb, z_comb, q1, q2;

    blocking_nonblocking_demo u_dut (
        .clk(clk), .a(a), .b(b), .c(c), .d1(d1), .d2(d2),
        .y_comb(y_comb), .z_comb(z_comb), .q1(q1), .q2(q2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Blocking vs nonblocking (1364-2005): = in combo, <= in seq");
        a = 1; b = 1; c = 0; d1 = 1; d2 = 0;
        #10 $display("  combo: y=%b z=%b", y_comb, z_comb);
        repeat(3) @(posedge clk) $display("  seq: q1=%b q2=%b (q2 gets old q1)", q1, q2);
        $finish;
    end
endmodule
