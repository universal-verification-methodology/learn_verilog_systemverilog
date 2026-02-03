/*
 * Module 7: case style - 1364 vs 1800 unique/priority
 * Same 4:1 mux: 1364 case+default vs 1800 unique case.
 */

// ----- 1364: case with default (no unique) -----
module mux_case_1364 (
    input  wire [1:0] sel,
    input  wire [7:0] a, b, c, d,
    output reg  [7:0] y
);
    always @* begin
        case (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
            default: y = a;
        endcase
    end
endmodule

// ----- 1800: unique case (tool can check at most one match) -----
module mux_case_1800 (
    input  logic [1:0] sel,
    input  logic [7:0] a, b, c, d,
    output logic [7:0] y
);
    always_comb begin
        unique case (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
            default: y = a;
        endcase
    end
endmodule

module top;
    logic [1:0] sel;
    logic [7:0] a, b, c, d, y1364, y1800;

    mux_case_1364 u1364 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y1364));
    mux_case_1800 u1800 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y1800));

    initial begin
        $display("Module 7: case 1364 (case+default) vs 1800 (unique case)");
        a = 8'h1; b = 8'h2; c = 8'h4; d = 8'h8;
        sel = 2'b01; #10 $display("  sel=%b y1364=%h y1800=%h", sel, y1364, y1800);
        sel = 2'b11; #10 $display("  sel=%b y1364=%h y1800=%h", sel, y1364, y1800);
        if (y1364 === y1800) $display("  PASS: same behavior");
        else $display("  FAIL: mismatch");
        $finish;
    end
endmodule
