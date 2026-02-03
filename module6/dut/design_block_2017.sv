/*
 * Design block - IEEE 1800-2017 design subset
 * logic, always_comb, package, no interface (portable with iverilog).
 * Represents current-standard RTL style in one place.
 */

package pkg_block_2017;
    parameter int AW = 4;
    parameter int DW = 8;
    typedef logic [AW-1:0] addr_t;
    typedef logic [DW-1:0] data_t;
endpackage

module design_block_2017 (
    input  logic       clk,
    input  logic       we,
    input  logic [3:0] addr,
    input  logic [7:0]  wdata,
    output logic [7:0] rdata
);
    import pkg_block_2017::*;

    data_t mem [0:15];

    always_ff @(posedge clk) begin
        if (we)
            mem[addr] <= wdata;
    end

    always_comb begin
        rdata = mem[addr];
    end
endmodule
