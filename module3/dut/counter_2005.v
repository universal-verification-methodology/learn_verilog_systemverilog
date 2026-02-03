/*
 * Counter - IEEE 1364-2005 synthesizable subset
 * Parameter and localparam; no defparam. Nonblocking in sequential block.
 */

module counter_2005 #(parameter WIDTH = 8) (
    input  wire clk,
    input  wire rst_n,
    input  wire en,
    output reg  [WIDTH-1:0] count
);
    localparam MAX = (1 << WIDTH) - 1;

    always @(posedge clk) begin
        if (!rst_n)
            count <= 0;
        else if (en)
            count <= (count == MAX) ? 0 : count + 1;
    end
endmodule
