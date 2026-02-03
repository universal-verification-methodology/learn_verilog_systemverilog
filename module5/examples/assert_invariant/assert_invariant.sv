/*
 * Immediate assertion for invariant - IEEE 1800-2009/2012
 * grant must be one-hot when any req is high.
 */

module arb_onehot (
    input  logic [3:0] req,
    output logic [3:0] grant
);
    always_comb begin
        grant = 4'b0000;
        priority case (1'b1)
            req[3]: grant = 4'b1000;
            req[2]: grant = 4'b0100;
            req[1]: grant = 4'b0010;
            req[0]: grant = 4'b0001;
            default: grant = 4'b0000;
        endcase
    end

    /* Invariant: grant is one-hot or zero */
    always_comb
        assert ($countones(grant) <= 1) else $error("arb_onehot: grant not one-hot %b", grant);
endmodule

module top;
    logic [3:0] req, grant;

    arb_onehot u_arb (.req(req), .grant(grant));

    initial begin
        $display("Immediate assertion for invariant (1800-2009/2012): grant one-hot");
        req = 4'b0100; #10 $display("  req=%b grant=%b", req, grant);
        req = 4'b0011; #10 $display("  req=%b grant=%b (priority)", req, grant);
        $finish;
    end
endmodule
