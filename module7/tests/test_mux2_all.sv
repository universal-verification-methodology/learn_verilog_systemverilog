/*
 * Module 7: Test all mux versions - same stimulus, compare outputs
 */

`include "../dut/mux2_1364.v"
`include "../dut/mux2_1800.sv"

module test_mux2_all;
    logic a, b, sel;
    logic y1995, y2001, y2005, y1800;

    mux2_1995 u1995 (.a(a), .b(b), .sel(sel), .y(y1995));
    mux2_2001 u2001 (.a(a), .b(b), .sel(sel), .y(y2001));
    mux2_2005 u2005 (.a(a), .b(b), .sel(sel), .y(y2005));
    mux2_1800 u1800 (.a(a), .b(b), .sel(sel), .y(y1800));

    initial begin
        $display("Module 7 test: mux2 all versions (1995, 2001, 2005, 1800)");
        a = 0; b = 1; sel = 0;
        #10 $display("  sel=0: y1995=%b y2001=%b y2005=%b y1800=%b", y1995, y2001, y2005, y1800);
        sel = 1;
        #10 $display("  sel=1: y1995=%b y2001=%b y2005=%b y1800=%b", y1995, y2001, y2005, y1800);
        if (y1995 === y2001 && y2001 === y2005 && y2005 === y1800) begin
            $display("PASS: mux2 all versions match");
        end else begin
            $display("FAIL: mux2 version mismatch");
        end
        $finish;
    end
endmodule
