/*
 * IEEE 1800-2017: unique case (2017 clarified)
 * At most one match; runtime check possible; no latch when full.
 */

module decoder_unique (
    input  logic [1:0] sel,
    output logic [3:0] y
);
    always_comb begin
        y = 4'b0000;
        unique case (sel)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
            default: y = 4'b0000;
        endcase
    end
endmodule

module top;
    logic [1:0] sel;
    logic [3:0] y;

    decoder_unique u (.sel(sel), .y(y));

    initial begin
        $display("1800-2017: unique case (at most one match)");
        sel = 2'b00; #10 $display("  sel=%b y=%b", sel, y);
        sel = 2'b10; #10 $display("  sel=%b y=%b", sel, y);
        sel = 2'b11; #10 $display("  sel=%b y=%b", sel, y);
        $display("  unique case: no overlap; default avoids latch.");
        $finish;
    end
endmodule
