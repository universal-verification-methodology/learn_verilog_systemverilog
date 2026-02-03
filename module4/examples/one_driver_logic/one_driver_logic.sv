/*
 * One driver per logic - IEEE 1800-2005
 * logic must have exactly one driver (one assign, or one always block).
 */

module one_driver_demo (
    input  logic       a,
    input  logic       b,
    input  logic       clk,
    input  logic       rst_n,
    output logic       y_comb,
    output logic       q_reg
);
    /* One driver: single assign to y_comb */
    assign y_comb = a & b;

    /* One driver: single always_ff driving q_reg */
    always_ff @(posedge clk) begin
        if (!rst_n)
            q_reg <= 1'b0;
        else
            q_reg <= y_comb;
    end
endmodule

module top;
    logic clk, rst_n, a, b, y_comb, q_reg;

    one_driver_demo u_dut (.a(a), .b(b), .clk(clk), .rst_n(rst_n), .y_comb(y_comb), .q_reg(q_reg));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("One driver per logic (1800-2005): single assign, single always_ff per output");
        rst_n = 0; a = 1; b = 1;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(3) @(posedge clk) $display("  y_comb=%b q_reg=%b", y_comb, q_reg);
        $finish;
    end
endmodule
