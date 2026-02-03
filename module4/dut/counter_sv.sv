/*
 * Counter - IEEE 1800-2005 SystemVerilog design subset
 * logic; always_ff; nonblocking only.
 */

module counter_sv #(parameter int WIDTH = 8) (
    input  logic clk,
    input  logic rst_n,
    input  logic en,
    output logic [WIDTH-1:0] count
);
    localparam logic [WIDTH-1:0] MAX = (1 << WIDTH) - 1;

    always_ff @(posedge clk) begin
        if (!rst_n)
            count <= '0;
        else if (en)
            count <= (count == MAX) ? '0 : count + 1;
    end
endmodule
