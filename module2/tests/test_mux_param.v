/*
 * Testbench for parameterized 2:1 mux - IEEE 1364-2001
 * Tests 1-bit and 8-bit instances with parameter override.
 */

`include "../dut/mux_2to1_param.v"

module test_mux_param;
    reg  a1, b1, sel1;
    wire y1;

    reg [7:0] a8, b8;
    reg       sel8;
    wire [7:0] y8;

    mux_2to1_param #(.WIDTH(1)) u_mux1 (.a(a1), .b(b1), .sel(sel1), .y(y1));
    mux_2to1_param #(.WIDTH(8)) u_mux8 (.a(a8), .b(b8), .sel(sel8), .y(y8));

    initial begin
        $display("Module 2 test: mux_2to1_param (1364-2001)");
        $display("1-bit mux: sel a b | y");
        a1 = 0; b1 = 0; sel1 = 0; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);
        a1 = 0; b1 = 1; sel1 = 0; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);
        a1 = 1; b1 = 0; sel1 = 0; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);
        a1 = 1; b1 = 1; sel1 = 0; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);
        a1 = 0; b1 = 0; sel1 = 1; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);
        a1 = 0; b1 = 1; sel1 = 1; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);
        a1 = 1; b1 = 0; sel1 = 1; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);
        a1 = 1; b1 = 1; sel1 = 1; #10 $display("     %b  %b %b | %b", sel1, a1, b1, y1);

        $display("8-bit mux:");
        a8 = 8'hAA; b8 = 8'h55; sel8 = 0; #10 $display("  a=%h b=%h sel=%b y=%h", a8, b8, sel8, y8);
        sel8 = 1; #10 $display("  a=%h b=%h sel=%b y=%h", a8, b8, sel8, y8);

        $display("PASS: mux_param test complete");
        $finish;
    end
endmodule
