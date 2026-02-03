/*
 * Module 7: Top - run all decoder versions and compare
 */

module top;
    logic [1:0] sel;
    logic [3:0] y1995, y2001, y2005, y1800;

    decoder_1995 u1995 (.sel(sel), .y(y1995));
    decoder_2001 u2001 (.sel(sel), .y(y2001));
    decoder_2005 u2005 (.sel(sel), .y(y2005));
    decoder_1800 u1800 (.sel(sel), .y(y1800));

    initial begin
        $display("Module 7: Side-by-side 2:4 decoder (1995, 2001, 2005, 1800)");
        sel = 2'b00; #10 $display("  sel=%b y1995=%b y2001=%b y2005=%b y1800=%b", sel, y1995, y2001, y2005, y1800);
        sel = 2'b10; #10 $display("  sel=%b y1995=%b y2001=%b y2005=%b y1800=%b", sel, y1995, y2001, y2005, y1800);
        sel = 2'b11; #10 $display("  sel=%b y1995=%b y2001=%b y2005=%b y1800=%b", sel, y1995, y2001, y2005, y1800);
        if (y1995 === y2001 && y2001 === y2005 && y2005 === y1800)
            $display("  PASS: all versions match");
        else
            $display("  FAIL: mismatch");
        $finish;
    end
endmodule
