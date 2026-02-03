/*
 * Basic gates with assign - IEEE 1364-1995 style
 *
 * XOR, NAND, NOR using continuous assignment.
 * Left-hand side must be wire; expression on right.
 */

module xor_gate(a, b, y);
    input  a;
    input  b;
    output y;
    wire a, b, y;
    assign y = a ^ b;
endmodule

module nand_gate(a, b, y);
    input  a;
    input  b;
    output y;
    wire a, b, y;
    assign y = ~(a & b);
endmodule

module nor_gate(a, b, y);
    input  a;
    input  b;
    output y;
    wire a, b, y;
    assign y = ~(a | b);
endmodule

module top;
    reg  a, b;
    wire xor_y, nand_y, nor_y;

    xor_gate  u_xor  (.a(a), .b(b), .y(xor_y));
    nand_gate u_nand (.a(a), .b(b), .y(nand_y));
    nor_gate  u_nor  (.a(a), .b(b), .y(nor_y));

    initial begin
        $display("a b | xor nand nor");
        a = 0; b = 0; #10 $display("%b %b |  %b   %b   %b", a, b, xor_y, nand_y, nor_y);
        a = 0; b = 1; #10 $display("%b %b |  %b   %b   %b", a, b, xor_y, nand_y, nor_y);
        a = 1; b = 0; #10 $display("%b %b |  %b   %b   %b", a, b, xor_y, nand_y, nor_y);
        a = 1; b = 1; #10 $display("%b %b |  %b   %b   %b", a, b, xor_y, nand_y, nor_y);
        $finish;
    end
endmodule
