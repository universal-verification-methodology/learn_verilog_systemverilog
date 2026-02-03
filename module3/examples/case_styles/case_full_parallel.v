/*
 * Case with full coverage and default - IEEE 1364-2005
 * full_case/parallel_case are tool attributes; 1364-2005 has no unique/priority case.
 * Use default to avoid latch; tool may support (* full_case *) or similar.
 */

module mux4 (
    input  wire [1:0] sel,
    input  wire [3:0] d0,
    input  wire [3:0] d1,
    input  wire [3:0] d2,
    input  wire [3:0] d3,
    output reg  [3:0] y
);
    /* Default before case ensures no latch; all cases covered */
    always @* begin
        y = d0;
        case (sel)
            2'd0: y = d0;
            2'd1: y = d1;
            2'd2: y = d2;
            2'd3: y = d3;
            default: y = d0;
        endcase
    end
endmodule

module top;
    reg [1:0] sel;
    reg [3:0] d0, d1, d2, d3;
    wire [3:0] y;

    mux4 u_mux (.sel(sel), .d0(d0), .d1(d1), .d2(d2), .d3(d3), .y(y));

    initial begin
        $display("Case full coverage (1364-2005): default to avoid latch");
        d0 = 4'h1; d1 = 4'h2; d2 = 4'h4; d3 = 4'h8;
        sel = 2'd0; #10 $display("  sel=%d y=%h", sel, y);
        sel = 2'd1; #10 $display("  sel=%d y=%h", sel, y);
        sel = 2'd2; #10 $display("  sel=%d y=%h", sel, y);
        sel = 2'd3; #10 $display("  sel=%d y=%h", sel, y);
        $finish;
    end
endmodule
