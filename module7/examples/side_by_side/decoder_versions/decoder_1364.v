/*
 * Module 7: 2:4 decoder - 1364-1995, 1364-2001, 1364-2005
 * Same behavior; port style and sensitivity.
 */

module decoder_1995(sel, y);
    input  [1:0] sel;
    output [3:0] y;
    wire   [1:0] sel;
    reg    [3:0] y;
    always @(sel) begin
        case (sel)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
            default: y = 4'b0000;
        endcase
    end
endmodule

module decoder_2001 (
    input  wire [1:0] sel,
    output reg  [3:0] y
);
    always @* begin
        case (sel)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
            default: y = 4'b0000;
        endcase
    end
endmodule

module decoder_2005 (
    input  wire [1:0] sel,
    output reg  [3:0] y
);
    always @* begin
        case (sel)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
            default: y = 4'b0000;
        endcase
    end
endmodule
