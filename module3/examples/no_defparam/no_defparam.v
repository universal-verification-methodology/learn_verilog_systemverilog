/*
 * No defparam - IEEE 1364-2005
 * defparam is deprecated; override only at instantiation.
 * This example shows correct hierarchy: parent passes parameter to child at inst.
 */

module child #(parameter W = 4) (
    input  wire [W-1:0] a,
    output wire [W-1:0] y
);
    assign y = a;
endmodule

module parent #(parameter W = 4) (
    input  wire [W-1:0] a,
    output wire [W-1:0] y
);
    /* Correct: override at instantiation; no defparam anywhere */
    child #(.W(W)) u_child (.a(a), .y(y));
endmodule

module top;
    reg [7:0] a;
    wire [7:0] y;

    parent #(.W(8)) u_parent (.a(a), .y(y));

    initial begin
        $display("No defparam (1364-2005): parameter only at instantiation");
        a = 8'hAB; #10 $display("  a=%h y=%h", a, y);
        $finish;
    end
endmodule
