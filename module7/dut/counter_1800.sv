/*
 * Module 7 DUT: Counter - 1800-2005/2017
 */

module counter_1800 #(parameter int WIDTH = 4) (
    input  logic clk, rst_n, en,
    output logic [WIDTH-1:0] count
);
    localparam int MAX = (1 << WIDTH) - 1;
    always_ff @(posedge clk) begin
        if (!rst_n) count <= '0;
        else if (en) count <= (count == MAX) ? '0 : count + 1;
    end
endmodule
