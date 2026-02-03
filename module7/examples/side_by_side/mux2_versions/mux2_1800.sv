/*
 * Module 7: 2:1 mux - 1800-2005/2017 style
 * logic, always_comb; same behavior as 1364 versions.
 */

module mux2_1800 (
    input  logic a, b, sel,
    output logic y
);
    always_comb y = sel ? b : a;
endmodule
