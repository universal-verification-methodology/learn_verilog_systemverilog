/*
 * Module 7: 2:4 decoder - 1800-2005/2017
 * logic, always_comb, unique case.
 */

module decoder_1800 (
    input  logic [1:0] sel,
    output logic [3:0] y
);
    always_comb begin
        unique case (sel)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
            default: y = 4'b0000;
        endcase
    end
endmodule
