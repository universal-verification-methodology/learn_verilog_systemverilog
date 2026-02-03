/*
 * IEEE 1800-2017: Immediate assertion in RTL
 * Simple invariant (one-hot grant); 2017 semantics.
 */

module arbiter (
    input  logic [2:0] req,
    output logic [2:0] grant
);
    /* Priority: req[0] > req[1] > req[2] */
    always_comb begin
        grant = 3'b000;
        if (req[0])      grant = 3'b001;
        else if (req[1]) grant = 3'b010;
        else if (req[2]) grant = 3'b100;
    end

    /* Immediate assertion: grant must be one-hot or zero */
    always_comb begin
        assert ($countones(grant) <= 1)
            else $error("arbiter: grant not one-hot: %b", grant);
    end
endmodule

module top;
    logic [2:0] req, grant;

    arbiter u_arb (.req(req), .grant(grant));

    initial begin
        $display("1800-2017: Immediate assertion in RTL (one-hot invariant)");
        req = 3'b001; #10 $display("  req=%b grant=%b", req, grant);
        req = 3'b110; #10 $display("  req=%b grant=%b (priority)", req, grant);
        req = 3'b000; #10 $display("  req=%b grant=%b", req, grant);
        $display("  Assertion passes when grant is one-hot or zero.");
        $finish;
    end
endmodule
