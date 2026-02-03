/*
 * priority case - IEEE 1800-2005
 * First matching item wins; use for arbiter, interrupt mask.
 */

module arbiter (
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
endmodule

module top;
    logic [3:0] req, grant;

    arbiter u_arb (.req(req), .grant(grant));

    initial begin
        $display("priority case (1800-2005): first match wins");
        req = 4'b0101; #10 $display("  req=%b grant=%b (req[2] wins)", req, grant);
        req = 4'b0010; #10 $display("  req=%b grant=%b", req, grant);
        req = 4'b1000; #10 $display("  req=%b grant=%b (req[3] wins)", req, grant);
        $finish;
    end
endmodule
