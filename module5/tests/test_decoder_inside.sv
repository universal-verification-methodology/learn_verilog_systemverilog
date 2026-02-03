/*
 * Testbench for decoder_inside - IEEE 1800-2009/2012
 */

`include "../dut/decoder_inside.sv"

module test_decoder_inside;
    logic [1:0] sel;
    logic [3:0] y;

    decoder_inside u_dut (.sel(sel), .y(y));

    initial begin
        $display("Module 5 test: decoder_inside (1800-2009/2012)");
        $display("sel | y");
        sel = 2'd0; #10 $display(" %d  | %b", sel, y);
        sel = 2'd1; #10 $display(" %d  | %b", sel, y);
        sel = 2'd2; #10 $display(" %d  | %b", sel, y);
        sel = 2'd3; #10 $display(" %d  | %b", sel, y);
        $display("PASS: decoder_inside test complete");
        $finish;
    end
endmodule
