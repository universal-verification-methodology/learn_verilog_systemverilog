/*
 * Immediate assertion for valid encoding - IEEE 1800-2009/2012
 * assert (valid_op) else $error; use for opcode or state encoding.
 */

module alu_op (
    input  logic [2:0] op,
    output logic [7:0] y
);
    /* Valid opcodes: 0=add, 1=sub, 2=and, 3=or; others invalid */
    logic valid_op;
    always_comb begin
        valid_op = (op == 3'd0 || op == 3'd1 || op == 3'd2 || op == 3'd3);
        assert (valid_op) else $error("alu_op: invalid opcode %d", op);
    end

    always_comb begin
        y = 8'b0;
        case (op)
            3'd0: y = 8'd1;
            3'd1: y = 8'd2;
            3'd2: y = 8'd4;
            3'd3: y = 8'd8;
            default: y = 8'b0;
        endcase
    end
endmodule

module top;
    logic [2:0] op;
    logic [7:0] y;

    alu_op u_alu (.op(op), .y(y));

    initial begin
        $display("Immediate assertion for valid encoding (1800-2009/2012)");
        op = 3'd0; #10 $display("  op=%d y=%d", op, y);
        op = 3'd2; #10 $display("  op=%d y=%d", op, y);
        op = 3'd5; #10 $display("  op=%d y=%d (assert may fire)", op, y);
        $finish;
    end
endmodule
