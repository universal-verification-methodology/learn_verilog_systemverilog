/*
 * Delays and timing - IEEE 1364-1995 style
 *
 * #n = delay by n time units
 * @(event) = wait for event (e.g. @(posedge clk))
 * wait(condition) = wait until condition is true
 */

module timing_demo;
    reg clk;
    reg rst_n;
    reg start;
    reg [3:0] count;
    reg ready;

    /* Clock: period 10 time units */
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    /* Reset: sync to first posedge, hold 2 cycles, release */
    initial begin
        rst_n = 1;
        start = 0;
        #3 rst_n = 0;
        @(posedge clk);
        repeat(2) @(posedge clk);
        rst_n = 1;
        #20 start = 1;
        #10 start = 0;
    end

    /* Counter: only when rst_n and start */
    initial begin
        count = 0;
        ready = 0;
        wait(rst_n == 1);
        wait(start == 1);
        ready = 1;
        repeat(4) begin
            @(posedge clk);
            count = count + 1;
            $display("  t=%0t clk=%b rst_n=%b count=%d", $time, clk, rst_n, count);
        end
        ready = 0;
        #50 $finish;
    end

    /* Monitor first few cycles */
    initial begin
        $display("Delays and timing (1364-1995): #, @(posedge clk), wait(condition)");
        $display("  t   clk rst_n start count ready");
    end
endmodule
