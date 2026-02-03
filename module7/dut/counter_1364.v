/*
 * Module 7 DUT: Counter - 1364-1995, 1364-2001, 1364-2005
 */

module counter_1995(clk, rst_n, en, count);
    parameter WIDTH = 4;
    input  clk, rst_n, en;
    output [WIDTH-1:0] count;
    wire   clk, rst_n, en;
    reg    [WIDTH-1:0] count;
    always @(posedge clk) begin
        if (!rst_n) count <= 0;
        else if (en) count <= count + 1;
    end
endmodule

module counter_2001 #(parameter WIDTH = 4) (
    input  wire clk, rst_n, en,
    output reg  [WIDTH-1:0] count
);
    localparam MAX = (1 << WIDTH) - 1;
    always @(posedge clk) begin
        if (!rst_n) count <= 0;
        else if (en) count <= (count == MAX) ? 0 : count + 1;
    end
endmodule

module counter_2005 #(parameter WIDTH = 4) (
    input  wire clk, rst_n, en,
    output reg  [WIDTH-1:0] count
);
    localparam MAX = (1 << WIDTH) - 1;
    always @(posedge clk) begin
        if (!rst_n) count <= 0;
        else if (en) count <= (count == MAX) ? 0 : count + 1;
    end
endmodule
