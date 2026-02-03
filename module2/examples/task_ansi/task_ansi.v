/*
 * ANSI-style task with output - IEEE 1364-2001
 * Task: output in header; used for reset pattern in testbench.
 */

module top;
    reg clk;
    reg rst_n;
    reg [7:0] count;

    initial clk = 0;
    always #5 clk = ~clk;

    task automatic apply_reset(output reg rn);
        begin
            rn = 0;
            #100;
            rn = 1;
            #20;
        end
    endtask

    always @(posedge clk)
        if (!rst_n)
            count <= 0;
        else
            count <= count + 1;

    initial begin
        $display("ANSI task with output (1364-2001): task apply_reset(output reg rn)");
        apply_reset(rst_n);
        repeat(5) @(posedge clk) $display("  t=%0t rst_n=%b count=%d", $time, rst_n, count);
        $finish;
    end
endmodule
