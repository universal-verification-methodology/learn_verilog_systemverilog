/*
 * Simple memory - IEEE 1800-2009/2012
 * Fixed array; synthesis-safe. Array indexing and assignment (2012 clarifications).
 */

module mem_array_sv #(parameter int DEPTH = 256, parameter int WIDTH = 8) (
    input  logic                  clk,
    input  logic                  we,
    input  logic [$clog2(DEPTH)-1:0] addr,
    input  logic [WIDTH-1:0]      din,
    output logic [WIDTH-1:0]      dout
);
    logic [WIDTH-1:0] mem [0:DEPTH-1];

    always_ff @(posedge clk) begin
        dout <= mem[addr];
        if (we)
            mem[addr] <= din;
    end
endmodule
