/*
 * Testbench for decoder_unique - IEEE 1800-2005
 */

`include "../dut/decoder_unique.sv"

module test_decoder_unique;
    logic [1:0] sel;
    logic [3:0] y;

    decoder_unique u_dut (.sel(sel), .y(y));

    initial begin
        $display("Module 4 test: decoder_unique (1800-2005)");
        $display("sel | y");
        sel = 2'd0; #10 $display(" %d  | %b", sel, y);
        sel = 2'd1; #10 $display(" %d  | %b", sel, y);
        sel = 2'd2; #10 $display(" %d  | %b", sel, y);
        sel = 2'd3; #10 $display(" %d  | %b", sel, y);
        $display("PASS: decoder_unique test complete");
        $finish;
    end
endmodule
