/*
 * Module 7: D flip-flop / register - 1364-1995, 1364-2001, 1364-2005
 * Same behavior; sequential block style.
 */

module dff_1995(clk, rst_n, d, q);
    parameter W = 8;
    input  clk, rst_n;
    input  [W-1:0] d;
    output [W-1:0] q;
    wire   clk, rst_n;
    wire   [W-1:0] d;
    reg    [W-1:0] q;
    always @(posedge clk)
        if (!rst_n) q <= 0;
        else        q <= d;
endmodule

module dff_2001 #(parameter W = 8) (
    input  wire clk, rst_n,
    input  wire [W-1:0] d,
    output reg  [W-1:0] q
);
    always @(posedge clk)
        if (!rst_n) q <= 0;
        else        q <= d;
endmodule

module dff_2005 #(parameter W = 8) (
    input  wire clk, rst_n,
    input  wire [W-1:0] d,
    output reg  [W-1:0] q
);
    always @(posedge clk)
        if (!rst_n) q <= 0;
        else        q <= d;
endmodule
