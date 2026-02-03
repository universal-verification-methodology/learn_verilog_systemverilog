/*
 * inside and ==? - IEEE 1800-2009/2012
 * inside: set/range membership. ==?: wildcard equality (X/Z = don't care).
 */

module op_demo (
    input  logic [3:0] op,
    input  logic [3:0] mask,
    output logic       in_set,
    output logic       match_wild
);
    /* 2009/2012: inside {1,2,5,10} when tool supports; fallback: explicit comparison */
    always_comb
        in_set = (op == 4'd1 || op == 4'd2 || op == 4'd5 || op == 4'd10);

    /* ==?: wildcard; X/Z on RHS are don't care */
    always_comb
        match_wild = (mask ==? 4'b1x0z);
endmodule

module top;
    logic [3:0] op, mask;
    logic       in_set, match_wild;

    op_demo u_dut (.op(op), .mask(mask), .in_set(in_set), .match_wild(match_wild));

    initial begin
        $display("inside and ==? (1800-2009/2012)");
        op = 4'd1;  mask = 4'b1100; #10 $display("  op=%d inside{1,2,5,10}=%b", op, in_set);
        op = 4'd3;  mask = 4'b10x0; #10 $display("  op=%d in_set=%b  mask==? 1x0z=%b", op, in_set, match_wild);
        op = 4'd5;  #10 $display("  op=%d in_set=%b", op, in_set);
        $finish;
    end
endmodule
