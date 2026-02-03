/*
 * Module 7: Migration demo - 1364 -> 1800 design subset
 * Before: 1364-2005 style. After: 1800-2017 style. Same behavior.
 */

// ----- BEFORE: 1364-2005 (wire/reg, always @*) -----
module mux_before (
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

// ----- AFTER: 1800-2017 (logic, always_comb, unique case) -----
module mux_after (
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
    logic [7:0] a, b, c, d, y_before, y_after;

    mux_before u_before (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y_before));
    mux_after  u_after  (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y_after));

    initial begin
        $display("Module 7: Migration 1364 -> 1800 (steps: wire/reg->logic, @*->always_comb, unique case)");
        a = 8'h1; b = 8'h2; c = 8'h4; d = 8'h8;
        sel = 2'b10; #10 $display("  sel=%b y_before=%h y_after=%h", sel, y_before, y_after);
        if (y_before === y_after) $display("  PASS: same behavior");
        else $display("  FAIL: mismatch");
        $finish;
    end
endmodule
