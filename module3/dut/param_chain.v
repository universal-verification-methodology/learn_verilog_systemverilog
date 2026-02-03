/*
 * Parameter chain - IEEE 1364-2005
 * Parameter passed through hierarchy via instantiation only (no defparam).
 */

module leaf #(parameter N = 4) (
    input  wire [N-1:0] a,
    output wire [N-1:0] y
);
    assign y = a;
endmodule

module mid #(parameter N = 4) (
    input  wire [N-1:0] a,
    output wire [N-1:0] y
);
    leaf #(.N(N)) u_leaf (.a(a), .y(y));
endmodule

module param_chain #(parameter N = 4) (
    input  wire [N-1:0] a,
    output wire [N-1:0] y
);
    mid #(.N(N)) u_mid (.a(a), .y(y));
endmodule
