/*
 * IEEE 1800-2017: Verilog subset vs SystemVerilog design subset
 * Same 2:1 mux: left = 1364-style (wire/reg, always @*), right = 1800 (logic, always_comb).
 */

// ----- Verilog subset (1364-style): wire/reg, always @* -----
module mux_1364 (
    input  wire      a,
    input  wire      b,
    input  wire      sel,
    output reg       y
);
    always @* begin
        if (sel)
            y = b;
        else
            y = a;
    end
endmodule

// ----- SystemVerilog design subset (1800): logic, always_comb -----
module mux_1800 (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);
    always_comb
        y = sel ? b : a;
endmodule

module top;
    logic a, b, sel, y1364, y1800;

    mux_1364 u_1364 (.a(a), .b(b), .sel(sel), .y(y1364));
    mux_1800 u_1800 (.a(a), .b(b), .sel(sel), .y(y1800));

    initial begin
        $display("1800-2017: Verilog subset vs SystemVerilog subset");
        a = 0; b = 1; sel = 0; #10 $display("  sel=0 y1364=%b y1800=%b", y1364, y1800);
        sel = 1; #10 $display("  sel=1 y1364=%b y1800=%b", y1364, y1800);
        $display("  Same behavior; 1800-2017 LRM defines both.");
        $finish;
    end
endmodule
