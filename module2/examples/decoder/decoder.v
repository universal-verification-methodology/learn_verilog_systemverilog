/*
 * 2:4 decoder - IEEE 1364-2001 ANSI ports and always @*
 * One-hot output from 2-bit select.
 */

module decoder_2to4 (
    input  wire [1:0] sel,
    output reg  [3:0] y
);
    always @*
        case (sel)
            2'd0: y = 4'b0001;
            2'd1: y = 4'b0010;
            2'd2: y = 4'b0100;
            2'd3: y = 4'b1000;
            default: y = 4'b0000;
        endcase
endmodule

module top;
    reg [1:0] sel;
    wire [3:0] y;

    decoder_2to4 u_dec (.sel(sel), .y(y));

    initial begin
        $display("Decoder 2:4 (1364-2001): ANSI ports, always @*");
        $display("sel | y");
        sel = 2'd0; #10 $display(" %d  | %b", sel, y);
        sel = 2'd1; #10 $display(" %d  | %b", sel, y);
        sel = 2'd2; #10 $display(" %d  | %b", sel, y);
        sel = 2'd3; #10 $display(" %d  | %b", sel, y);
        $finish;
    end
endmodule
