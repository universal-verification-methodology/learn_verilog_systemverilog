/*
 * 2:4 decoder - IEEE 1800-2005 SystemVerilog design subset
 * unique case; default for catch-all.
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
