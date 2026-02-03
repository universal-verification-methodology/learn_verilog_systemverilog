/*
 * Half adder and full adder - IEEE 1364-1995 style
 *
 * Combinational logic with assign; sum and carry outputs as wire.
 */

module half_adder(a, b, sum, cout);
    input  a;
    input  b;
    output sum;
    output cout;
    wire a, b, sum, cout;
    assign sum  = a ^ b;
    assign cout = a & b;
endmodule

module full_adder(a, b, cin, sum, cout);
    input  a;
    input  b;
    input  cin;
    output sum;
    output cout;
    wire a, b, cin, sum, cout;
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module top;
    reg  a, b, cin;
    wire ha_sum, ha_cout;
    wire fa_sum, fa_cout;

    half_adder u_ha (.a(a), .b(b), .sum(ha_sum), .cout(ha_cout));
    full_adder u_fa (.a(a), .b(b), .cin(cin), .sum(fa_sum), .cout(fa_cout));

    initial begin
        $display("Half adder: a b | sum cout");
        a = 0; b = 0; #10 $display("        %b %b |  %b   %b", a, b, ha_sum, ha_cout);
        a = 0; b = 1; #10 $display("        %b %b |  %b   %b", a, b, ha_sum, ha_cout);
        a = 1; b = 0; #10 $display("        %b %b |  %b   %b", a, b, ha_sum, ha_cout);
        a = 1; b = 1; #10 $display("        %b %b |  %b   %b", a, b, ha_sum, ha_cout);
        $display("Full adder: a b cin | sum cout");
        a = 0; b = 0; cin = 0; #10 $display("         %b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        a = 1; b = 0; cin = 0; #10 $display("         %b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        a = 0; b = 1; cin = 0; #10 $display("         %b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        a = 1; b = 1; cin = 0; #10 $display("         %b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        a = 1; b = 0; cin = 1; #10 $display("         %b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        a = 1; b = 1; cin = 1; #10 $display("         %b %b  %b  |  %b   %b", a, b, cin, fa_sum, fa_cout);
        $finish;
    end
endmodule
