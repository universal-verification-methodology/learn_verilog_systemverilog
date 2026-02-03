/*
 * generate if/else - IEEE 1364-2001
 * Conditional logic at elaboration; different implementations by parameter.
 */

module adder_sel #(parameter WIDTH = 8, parameter USE_CLIP = 0) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output wire [WIDTH-1:0] y
);
    generate
        if (USE_CLIP == 1) begin : clip
            /* Saturate at max (no overflow) */
            wire [WIDTH:0] sum;
            assign sum = a + b;
            assign y = sum[WIDTH] ? {WIDTH{1'b1}} : sum[WIDTH-1:0];
        end else begin : wrap
            assign y = a + b;
        end
    endgenerate
endmodule

module top;
    reg [3:0] a, b;
    wire [3:0] y_wrap, y_clip;

    adder_sel #(.WIDTH(4), .USE_CLIP(0)) u_wrap (.a(a), .b(b), .y(y_wrap));
    adder_sel #(.WIDTH(4), .USE_CLIP(1)) u_clip (.a(a), .b(b), .y(y_clip));

    initial begin
        $display("generate if/else (1364-2001): USE_CLIP selects implementation");
        a = 4'd10; b = 4'd5;  #10 $display("  a=%d b=%d wrap=%d clip=%d", a, b, y_wrap, y_clip);
        a = 4'd12; b = 4'd8;  #10 $display("  a=%d b=%d wrap=%d clip=%d", a, b, y_wrap, y_clip);
        $finish;
    end
endmodule
