/*
 * always_latch - IEEE 1800-2005
 * Explicit latch: level-sensitive storage. Use when latch is intended (e.g. transparent latch).
 */

module transparent_latch (
    input  logic clk,
    input  logic en,
    input  logic d,
    output logic q
);
    /* Explicit latch: q holds when en=0; transparent when en=1 */
    always_latch
        if (en)
            q <= d;
endmodule

module top;
    logic clk, en, d, q;

    transparent_latch u_latch (.clk(clk), .en(en), .d(d), .q(q));

    initial begin
        $display("always_latch (1800-2005): explicit latch when en=1");
        en = 0; d = 1; #10 $display("  en=%b d=%b q=%b", en, d, q);
        en = 1; d = 1; #10 $display("  en=%b d=%b q=%b", en, d, q);
        d = 0; #10 $display("  en=%b d=%b q=%b", en, d, q);
        en = 0; d = 1; #10 $display("  en=%b d=%b q=%b (hold)", en, d, q);
        $finish;
    end
endmodule
