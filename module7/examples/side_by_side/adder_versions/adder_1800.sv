/*
 * Module 7: 8-bit adder - 1800-2005/2017
 * logic, assign; same behavior.
 */

module adder_1800 (
    input  logic [7:0] a, b,
    output logic [7:0] sum
);
    assign sum = a + b;
endmodule
