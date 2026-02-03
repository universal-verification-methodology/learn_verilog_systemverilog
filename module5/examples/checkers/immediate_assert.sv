/*
 * Immediate assertion - IEEE 1800-2009/2012
 * assert (condition) else $error("..."); checked when executed.
 */

module onehot_check (
    input  logic [3:0] sig,
    output logic       valid
);
    /* Immediate assertion: at most one bit set (one-hot or zero) */
    always_comb begin
        valid = ($countones(sig) <= 1);
        assert (valid) else $error("onehot_check: sig not one-hot or zero: %b", sig);
    end
endmodule

module top;
    logic [3:0] sig;
    logic       valid;

    onehot_check u_check (.sig(sig), .valid(valid));

    initial begin
        $display("Immediate assertion (1800-2009/2012): assert ($countones(sig) <= 1)");
        sig = 4'b0001; #10 $display("  sig=%b valid=%b", sig, valid);
        sig = 4'b0100; #10 $display("  sig=%b valid=%b", sig, valid);
        sig = 4'b0011; #10 $display("  sig=%b valid=%b (assert may fire)", sig, valid);
        $finish;
    end
endmodule
