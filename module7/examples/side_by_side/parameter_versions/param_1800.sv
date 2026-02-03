/*
 * Module 7: Parameterized width - 1800-2005/2017
 * parameter int, localparam int; same behavior.
 */

module shift_1800 #(parameter int WIDTH = 8) (
    input  logic [WIDTH-1:0] d,
    input  logic             sh,
    output logic [WIDTH-1:0] q
);
    localparam int MSB = WIDTH - 1;
    always_comb begin
        if (sh)
            q = {d[MSB-1:0], 1'b0};
        else
            q = d;
    end
endmodule
