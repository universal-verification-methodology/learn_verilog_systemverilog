/*
 * Decoder using inside - IEEE 1800-2009/2012
 * Set membership with inside; readable opcode/state check.
 */

module decoder_inside (
    input  logic [1:0] sel,
    output logic [3:0] y
);
    /* 2009/2012: "if (sel inside {2'b00,2'b01,2'b10,2'b11})" when tool supports inside */
    always_comb begin
        y = 4'b0000;
        if (sel == 2'b00 || sel == 2'b01 || sel == 2'b10 || sel == 2'b11)
            case (sel)
                2'b00: y = 4'b0001;
                2'b01: y = 4'b0010;
                2'b10: y = 4'b0100;
                2'b11: y = 4'b1000;
                default: y = 4'b0000;
            endcase
    end
endmodule
