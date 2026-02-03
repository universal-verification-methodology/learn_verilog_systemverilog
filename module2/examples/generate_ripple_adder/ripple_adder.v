/*
 * N-bit ripple-carry adder with generate for - IEEE 1364-2001
 * genvar loop; full_adder instances replicated by parameter N.
 */

module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module ripple_adder #(parameter N = 4) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire         cin,
    output wire [N-1:0] sum,
    output wire         cout
);
    wire [N:0] carry;
    assign carry[0] = cin;
    assign cout = carry[N];

    generate
        genvar i;
        for (i = 0; i < N; i = i + 1) begin : gen_fa
            full_adder u_fa (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate
endmodule

module top;
    reg [3:0] a, b;
    reg       cin;
    wire [3:0] sum;
    wire       cout;

    ripple_adder #(.N(4)) u_add (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        $display("generate for: N-bit ripple-carry adder (1364-2001)");
        a = 4'd3; b = 4'd5; cin = 0; #10 $display("  %d + %d + %d = %d cout=%b", a, b, cin, sum, cout);
        a = 4'd15; b = 4'd1; cin = 0; #10 $display("  %d + %d + %d = %d cout=%b", a, b, cin, sum, cout);
        a = 4'd7; b = 4'd7; cin = 1; #10 $display("  %d + %d + %d = %d cout=%b", a, b, cin, sum, cout);
        $finish;
    end
endmodule
