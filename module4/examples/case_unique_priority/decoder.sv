/*
 * unique case and priority case - IEEE 1800-2005
 * unique: at most one match. priority: first match wins.
 */

module decoder_unique (
    input  logic [1:0] sel,
    output logic [3:0] y
);
    always_comb begin
        y = 4'b0000;
        unique case (sel)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
            default: y = 4'b0000;
        endcase
    end
endmodule

module grant_priority (
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
    logic [1:0] sel;
    logic [3:0] y;
    logic [3:0] req, grant;

    decoder_unique u_dec (.sel(sel), .y(y));
    grant_priority u_gr (.req(req), .grant(grant));

    initial begin
        $display("unique case / priority case (1800-2005)");
        sel = 2'b10; req = 4'b0110; #10 $display("  decoder sel=%b y=%b", sel, y);
        #10 $display("  grant req=%b grant=%b", req, grant);
        $finish;
    end
endmodule
