/*
 * Task and function - IEEE 1364-1995 style (non-ANSI)
 *
 * Ports declared inside body, not in header.
 */

module task_func_1995;
    reg [7:0] sum;
    reg [7:0] x, y;
    reg rst_n;

    /* 1995 function: input/output inside body */
    function [7:0] add8;
        input [7:0] a;
        input [7:0] b;
        begin
            add8 = a + b;
        end
    endfunction

    /* 1995 task: no ports in header */
    task apply_reset;
        begin
            rst_n = 0;
            #100;
            rst_n = 1;
            #20;
        end
    endtask

    initial begin
        x = 8'd10;
        y = 8'd20;
        sum = add8(x, y);
        $display("add8(10, 20) = %d", sum);

        rst_n = 1;
        apply_reset;
        $display("rst_n after task = %b", rst_n);

        $finish;
    end
endmodule
