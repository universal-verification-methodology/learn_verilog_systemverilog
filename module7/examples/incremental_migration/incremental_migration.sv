/*
 * Module 7: Incremental migration - two steps, same 4:1 mux
 * Step1: 1364 style (wire/reg, always @*). Step2: 1800 (logic, always_comb, unique case).
 * Run both and compare; illustrates migrating one construct at a time.
 */

// Step 1: 1364-2005 style
module mux_step1 (
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

// Step 2: 1800 style (logic, always_comb, unique case)
module mux_step2 (
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
    logic [7:0] a, b, c, d, y1, y2;

    mux_step1 u1 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y1));
    mux_step2 u2 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y2));

    initial begin
        $display("Module 7: Incremental migration (step1=1364, step2=1800)");
        a = 8'h1; b = 8'h2; c = 8'h4; d = 8'h8;
        sel = 2'b11; #10 $display("  sel=%b y_step1=%h y_step2=%h", sel, y1, y2);
        if (y1 === y2) $display("  PASS: same behavior after migration");
        else $display("  FAIL: mismatch");
        $finish;
    end
endmodule
