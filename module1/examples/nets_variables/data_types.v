/*
 * wire and reg - IEEE 1364-1995 style
 *
 * Demonstrates: wire (nets), reg (variables), 4-state, vectors.
 */

module data_types;
    wire w;
    wire [7:0] bus;
    reg  r;
    reg  [7:0] counter;

    assign w = 1'b1;
    assign bus = 8'hFF;

    initial begin
        r = 0;
        counter = 8'b0;
        #10 r = 1;
        #10 counter = 8'd42;
        #10 $display("w=%b bus=%b r=%b counter=%d", w, bus, r, counter);
        $finish;
    end
endmodule
