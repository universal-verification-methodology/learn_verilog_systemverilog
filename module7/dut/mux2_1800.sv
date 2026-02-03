/*
 * Module 7 DUT: 2:1 mux - 1800-2005/2017
 */

module mux2_1800 (
    input  logic a, b, sel,
    output logic y
);
    always_comb y = sel ? b : a;
endmodule
