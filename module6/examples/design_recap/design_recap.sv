/*
 * IEEE 1800-2017 design recap: logic, always_comb, always_ff, package, unique case
 * All constructs in one small design; 2017 is the single LRM reference.
 */

package pkg_recap;
    parameter int W = 8;
    typedef logic [W-1:0] word_t;
endpackage

module counter_recap (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    output logic [7:0] count
);
    import pkg_recap::*;

    always_ff @(posedge clk) begin
        if (rst)
            count <= '0;
        else if (en)
            count <= count + 1;
    end
endmodule

module mux_recap (
    input  logic [1:0] sel,
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] y
);
    always_comb begin
        unique case (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
            default: y = a;
        endcase
    end
endmodule

module top;
    import pkg_recap::*;

    logic       clk, rst, en;
    word_t      count;
    logic [1:0] sel;
    word_t      a, b, c, d, y;

    counter_recap u_cnt (.clk(clk), .rst(rst), .en(en), .count(count));
    mux_recap     u_mux (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("1800-2017 design recap: logic, always_comb, always_ff, package, unique case");
        rst = 1; en = 0; sel = 2'b00; a = 8'd1; b = 8'd2; c = 8'd4; d = 8'd8;
        #20 rst = 0; en = 1;
        #30 sel = 2'b10;
        #10 $display("  count=%d mux_sel=%b y=%d", count, sel, y);
        $finish;
    end
endmodule
