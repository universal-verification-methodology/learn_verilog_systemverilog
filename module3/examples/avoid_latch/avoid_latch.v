/*
 * Avoid latch - IEEE 1364-2005 synthesizable subset
 * Combinational always: assign in all branches or use default before case.
 */

module mux_with_default (
    input  wire [1:0] sel,
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [3:0] c,
    input  wire [3:0] d,
    output reg  [3:0] y
);
    /* Default first: no latch; then case overwrites when needed */
    always @* begin
        y = a;
        case (sel)
            2'd0: y = a;
            2'd1: y = b;
            2'd2: y = c;
            2'd3: y = d;
            default: y = a;
        endcase
    end
endmodule

module top;
    reg [1:0] sel;
    reg [3:0] a, b, c, d;
    wire [3:0] y;

    mux_with_default u_mux (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y));

    initial begin
        $display("Avoid latch (1364-2005): default + case so all paths assign y");
        a = 4'h1; b = 4'h2; c = 4'h4; d = 4'h8;
        sel = 2'd0; #10 $display("  sel=%d y=%h", sel, y);
        sel = 2'd2; #10 $display("  sel=%d y=%h", sel, y);
        sel = 2'd3; #10 $display("  sel=%d y=%h", sel, y);
        $finish;
    end
endmodule
