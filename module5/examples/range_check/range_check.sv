/*
 * Range check - IEEE 1800-2009/2012
 * 2009/2012: "x inside [0:15]" when tool supports; fallback: explicit (x >= 0 && x <= 15).
 */

module range_demo (
    input  logic [7:0] val,
    output logic       in_range
);
    /* 2009/2012: "val inside [0:127]" when tool supports inside */
    always_comb
        in_range = (val >= 8'd0 && val <= 8'd127);
endmodule

module top;
    logic [7:0] val;
    logic       in_range;

    range_demo u_dut (.val(val), .in_range(in_range));

    initial begin
        $display("Range check (1800-2009/2012): val inside [0:127] style");
        val = 8'd50;  #10 $display("  val=%d in_range=%b", val, in_range);
        val = 8'd127; #10 $display("  val=%d in_range=%b", val, in_range);
        val = 8'd200; #10 $display("  val=%d in_range=%b", val, in_range);
        $finish;
    end
endmodule
