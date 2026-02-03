/*
 * always_comb and always_ff - IEEE 1800-2005
 * Combinational: always_comb (inferred sensitivity). Sequential: always_ff (one clock).
 */

module always_comb_ff_demo (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       a,
    input  logic       b,
    input  logic       c,
    input  logic       d,
    output logic       y_comb,
    output logic       z_comb,
    output logic       q
);
    /* Combinational: always_comb; no latch */
    always_comb begin
        y_comb = a & b;
        z_comb = y_comb | c;
    end

    /* Sequential: always_ff; nonblocking only */
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule

module top;
    logic clk, rst_n, a, b, c, d;
    logic y_comb, z_comb, q;

    always_comb_ff_demo u_dut (
        .clk(clk), .rst_n(rst_n), .a(a), .b(b), .c(c), .d(d),
        .y_comb(y_comb), .z_comb(z_comb), .q(q)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("always_comb / always_ff (1800-2005)");
        rst_n = 0; a = 1; b = 1; c = 0; d = 1;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(3) @(posedge clk) $display("  y_comb=%b z_comb=%b q=%b", y_comb, z_comb, q);
        $finish;
    end
endmodule
