/*
 * ALU - IEEE 1800-2017 design subset
 * logic, always_comb, package type, optional immediate assertion.
 */

package pkg_alu_2017;
    typedef enum logic [1:0] { OP_ADD, OP_SUB, OP_AND, OP_OR } op_t;
    parameter int W = 8;
endpackage

module alu_2017 (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [1:0] op,
    output logic [7:0] y
);
    import pkg_alu_2017::*;

    always_comb begin
        unique case (op)
            OP_ADD: y = a + b;
            OP_SUB: y = a - b;
            OP_AND: y = a & b;
            OP_OR:  y = a | b;
            default: y = '0;
        endcase
    end

    /* Immediate assertion: op must be valid encoding (0..3); iverilog: explicit compare */
    always_comb begin
        assert (op == 2'b00 || op == 2'b01 || op == 2'b10 || op == 2'b11)
            else $error("alu_2017: invalid op %b", op);
    end
endmodule
