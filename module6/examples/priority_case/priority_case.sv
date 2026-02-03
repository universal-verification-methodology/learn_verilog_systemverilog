/*
 * IEEE 1800-2017: priority case (2017 clarified)
 * First match wins; useful for encoders/arbiters.
 */

module encoder_priority (
    input  logic [3:0] in,
    output logic [1:0] enc,
    output logic       valid
);
    always_comb begin
        enc   = 2'b00;
        valid = 1'b0;
        priority case (1'b1)
            in[0]: begin enc = 2'b00; valid = 1'b1; end
            in[1]: begin enc = 2'b01; valid = 1'b1; end
            in[2]: begin enc = 2'b10; valid = 1'b1; end
            in[3]: begin enc = 2'b11; valid = 1'b1; end
            default: ;
        endcase
    end
endmodule

module top;
    logic [3:0] in;
    logic [1:0] enc;
    logic       valid;

    encoder_priority u (.in(in), .enc(enc), .valid(valid));

    initial begin
        $display("1800-2017: priority case (first match wins)");
        in = 4'b0100; #10 $display("  in=%b enc=%b valid=%b (bit 2)", in, enc, valid);
        in = 4'b0011; #10 $display("  in=%b enc=%b valid=%b (bit 0 wins)", in, enc, valid);
        in = 4'b0000; #10 $display("  in=%b enc=%b valid=%b (none)", in, enc, valid);
        $finish;
    end
endmodule
