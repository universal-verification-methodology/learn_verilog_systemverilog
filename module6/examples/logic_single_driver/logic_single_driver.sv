/*
 * IEEE 1800-2017: logic and single driver (2017 clarified)
 * logic must have exactly one driver; comb and seq in separate blocks.
 */

module comb_block (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum,
    output logic       eq
);
    assign sum = a + b;
    always_comb eq = (a == b);
endmodule

module seq_block (
    input  logic       clk,
    input  logic       rst,
    input  logic [7:0] d,
    output logic [7:0] q
);
    always_ff @(posedge clk) begin
        if (rst)
            q <= '0;
        else
            q <= d;
    end
endmodule

module top;
    logic       clk, rst;
    logic [7:0] a, b, sum, d, q;
    logic       eq;

    comb_block u_comb (.a(a), .b(b), .sum(sum), .eq(eq));
    seq_block  u_seq  (.clk(clk), .rst(rst), .d(d), .q(q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("1800-2017: logic single driver (2017 clarified)");
        rst = 1; a = 8'd10; b = 8'd20; d = 8'd55;
        #20 rst = 0;
        #15 $display("  comb: a=%d b=%d sum=%d eq=%b", a, b, sum, eq);
        #15 $display("  seq:  d=%d q=%d", d, q);
        $display("  Each logic has one driver: assign, always_comb, or always_ff.");
        $finish;
    end
endmodule
