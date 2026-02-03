/*
 * IEEE 1800-2017: Migration 1364 -> 1800 design subset
 * Same 4:1 mux: left = 1364-2005 style, right = 1800-2017 style.
 */

// ----- 1364-2005 style: wire/reg, always @* -----
module mux_1364 (
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

// ----- 1800-2017 style: logic, always_comb, unique case -----
module mux_1800 (
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

    mux_1364 u_1364 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y1364));
    mux_1800 u_1800 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y1800));

    initial begin
        $display("1800-2017: Migration 1364 -> 1800 design subset");
        a = 8'h1; b = 8'h2; c = 8'h4; d = 8'h8;
        sel = 2'b10; #10 $display("  sel=%b y1364=%h y1800=%h (same)", sel, y1364, y1800);
        $display("  Steps: wire/reg->logic, always @*->always_comb, add unique case");
        $finish;
    end
endmodule
