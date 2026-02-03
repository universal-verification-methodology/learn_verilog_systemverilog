/*
 * ANSI-style task and function - IEEE 1364-2001
 * Input/output in header; optional automatic.
 */

module demo (
    input  wire [7:0] x,
    input  wire [7:0] y,
    output reg  [7:0] sum,
    output reg  [7:0] prod
);
    function automatic [7:0] add8(input [7:0] a, input [7:0] b);
        add8 = a + b;
    endfunction

    function automatic [15:0] mul8(input [7:0] a, input [7:0] b);
        mul8 = a * b;
    endfunction

    reg [15:0] mul_result;
    always @* begin
        sum = add8(x, y);
        mul_result = mul8(x, y);
        prod = mul_result[7:0];
    end
endmodule

module top;
    reg [7:0] x, y;
    wire [7:0] sum, prod;

    demo u_demo (.x(x), .y(y), .sum(sum), .prod(prod));

    initial begin
        $display("ANSI task/function (1364-2001): input/output in header");
        x = 8'd10; y = 8'd20; #10 $display("  x=%d y=%d add8=%d prod(low8)=%d", x, y, sum, prod);
        x = 8'd5;  y = 8'd6;  #10 $display("  x=%d y=%d add8=%d prod(low8)=%d", x, y, sum, prod);
        $finish;
    end
endmodule
