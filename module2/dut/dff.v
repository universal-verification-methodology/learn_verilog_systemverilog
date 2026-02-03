/*
 * D flip-flop - IEEE 1364-2001 ANSI style
 * Used by shift_reg_gen.
 */

module dff (
    input  wire clk,
    input  wire rst_n,
    input  wire d,
    output reg  q
);
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            q <= 0;
        else
            q <= d;
endmodule
