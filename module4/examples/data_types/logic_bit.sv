/*
 * logic and 2-state types - IEEE 1800-2005
 * logic: 4-state, single driver. bit: 2-state (0,1).
 */

module logic_bit_demo (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum,
    output logic       gt
);
    /* logic: single driver; 4-state */
    assign sum = a + b;

    /* logic in always_comb */
    always_comb
        gt = a > b;
endmodule

module top;
    logic [7:0] a, b;
    logic [7:0] sum;
    logic       gt;

    logic_bit_demo u_dut (.a(a), .b(b), .sum(sum), .gt(gt));

    initial begin
        $display("logic (1800-2005): 4-state single driver; replaces wire/reg for RTL");
        a = 8'd10; b = 8'd20; #10 $display("  a=%d b=%d sum=%d gt=%b", a, b, sum, gt);
        a = 8'd50; b = 8'd30; #10 $display("  a=%d b=%d sum=%d gt=%b", a, b, sum, gt);
        $finish;
    end
endmodule
