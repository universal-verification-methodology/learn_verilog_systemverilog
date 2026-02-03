/*
 * One driver per net - IEEE 1364-2005 synthesizable subset
 * Single assign to a wire; single always driving a reg. No multiple drivers.
 */

module one_driver_demo (
    input  wire       a,
    input  wire       b,
    input  wire       clk,
    input  wire       rst_n,
    output wire       y_assign,
    output reg        q_reg
);
    /* One driver: single assign to y_assign */
    assign y_assign = a & b;

    /* One driver: single always block driving q_reg */
    always @(posedge clk) begin
        if (!rst_n)
            q_reg <= 0;
        else
            q_reg <= y_assign;
    end
endmodule

module top;
    reg a, b, clk, rst_n;
    wire y_assign, q_reg;

    one_driver_demo u_dut (.a(a), .b(b), .clk(clk), .rst_n(rst_n), .y_assign(y_assign), .q_reg(q_reg));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("One driver per net (1364-2005): single assign, single always per output");
        rst_n = 0; a = 1; b = 1;
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(3) @(posedge clk) $display("  y_assign=%b q_reg=%b", y_assign, q_reg);
        $finish;
    end
endmodule
