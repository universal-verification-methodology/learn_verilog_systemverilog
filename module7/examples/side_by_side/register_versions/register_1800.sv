/*
 * Module 7: D flip-flop / register - 1800-2005/2017
 * logic, always_ff; same behavior.
 */

module dff_1800 #(parameter int W = 8) (
    input  logic clk, rst_n,
    input  logic [W-1:0] d,
    output logic [W-1:0] q
);
    always_ff @(posedge clk)
        if (!rst_n) q <= '0;
        else        q <= d;
endmodule
