/*
 * 2:1 mux - IEEE 1800-2005 SystemVerilog design subset
 * logic ports; always_comb.
 */

module mux2_sv (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);
    always_comb
        y = sel ? b : a;
endmodule
