/*
 * N-bit shift register - IEEE 1364-2001 generate
 * generate for with genvar; uses dff instances.
 */

module shift_reg_gen #(parameter N = 8) (
    input  wire clk,
    input  wire rst_n,
    input  wire sin,
    output wire sout
);
    wire [N-1:0] q;

    assign q[0] = sin;
    assign sout = q[N-1];

    generate
        genvar i;
        for (i = 1; i < N; i = i + 1) begin : gen_ff
            dff u_ff (
                .clk(clk),
                .rst_n(rst_n),
                .d(q[i-1]),
                .q(q[i])
            );
        end
    endgenerate
endmodule
