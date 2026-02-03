/*
 * Parameterized counter with localparam - IEEE 1364-2001
 * localparam MAX derived from WIDTH; wrap at MAX.
 */

module counter_param #(parameter WIDTH = 8) (
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
