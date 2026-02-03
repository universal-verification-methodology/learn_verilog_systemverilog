/*
 * Testbench for mem_array_sv - IEEE 1800-2009/2012
 */

`include "../dut/mem_array_sv.sv"

module test_mem_array;
    logic clk, we;
    logic [7:0] addr, din, dout;

    mem_array_sv #(.DEPTH(256), .WIDTH(8)) u_mem (.clk(clk), .we(we), .addr(addr), .din(din), .dout(dout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 5 test: mem_array_sv (1800-2009/2012)");
        we = 0; addr = 0; din = 0;
        @(posedge clk);
        #2 we = 1; addr = 8'd10; din = 8'hA5;
        @(posedge clk);
        #2 we = 1; addr = 8'd20; din = 8'hB2;
        @(posedge clk);
        #2 we = 0; addr = 8'd10;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  addr=10 dout=%h", dout);
        #2 addr = 8'd20;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  addr=20 dout=%h", dout);
        $display("PASS: mem_array_sv test complete");
        $finish;
    end
endmodule
