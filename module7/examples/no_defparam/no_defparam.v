/*
 * Module 7: 1364-2005 - no defparam; parameter override at instantiation
 * defparam deprecated in 2005; use #(.WIDTH(16)) at instantiation.
 */

module counter_param #(parameter WIDTH = 8) (
    input  wire clk, rst_n, en,
    output reg  [WIDTH-1:0] count
);
    always @(posedge clk) begin
        if (!rst_n)
            count <= 0;
        else if (en)
            count <= count + 1;
    end
endmodule

module top;
    reg clk, rst_n, en;
    wire [7:0]  count8;
    wire [15:0] count16;

    // Parameter override at instantiation (2005 style; no defparam)
    counter_param #(.WIDTH(8))  u8  (.clk(clk), .rst_n(rst_n), .en(en), .count(count8));
    counter_param #(.WIDTH(16)) u16 (.clk(clk), .rst_n(rst_n), .en(en), .count(count16));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Module 7: No defparam - parameter override at instantiation (1364-2005)");
        rst_n = 0; en = 1;
        #20 rst_n = 1;
        #50 $display("  count8=%d count16=%d", count8, count16);
        $display("  Use #(.WIDTH(n)) at instantiation; avoid defparam.");
        $finish;
    end
endmodule
