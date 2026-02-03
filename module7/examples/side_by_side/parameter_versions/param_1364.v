/*
 * Module 7: Parameterized width - 1364-2001/2005
 * parameter, localparam; same behavior.
 */

module shift_1364 #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] d,
    input  wire             sh,
    output reg  [WIDTH-1:0] q
);
    localparam MSB = WIDTH - 1;
    always @* begin
        if (sh)
            q = {d[MSB-1:0], 1'b0};
        else
            q = d;
    end
endmodule
