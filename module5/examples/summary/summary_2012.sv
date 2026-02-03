/*
 * 2005 vs 2009/2012 - IEEE 1800 summary
 * Same small design: 2005 logic/always_comb; 2009/2012 inside for readability.
 */

module mux_2005 (
    input  logic [1:0] sel,
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] y
);
    always_comb begin
        case (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
            default: y = a;
        endcase
    end
endmodule

module mux_2012 (
    input  logic [1:0] sel,
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] y
);
    /* 2009/2012: "if (sel inside {2'b00,...})" when tool supports; fallback: explicit */
    always_comb begin
        y = a;
        if (sel == 2'b00 || sel == 2'b01 || sel == 2'b10 || sel == 2'b11)
            case (sel)
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
    logic [7:0] a, b, c, d, y05, y12;

    mux_2005 u05 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y05));
    mux_2012 u12 (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y12));

    initial begin
        $display("2005 vs 2009/2012: same mux; 2012 uses inside for set check");
        a = 8'h1; b = 8'h2; c = 8'h4; d = 8'h8;
        sel = 2'b10; #10 $display("  sel=%b y05=%h y12=%h", sel, y05, y12);
        $finish;
    end
endmodule
