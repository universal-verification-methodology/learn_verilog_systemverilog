/*
 * Multi-dimensional style with 1D array - IEEE 1364-2001
 * reg [7:0] buf [0:7]; index as row*4+col for 2x4 layout.
 * (True 2D unpacked reg [7:0] buf [0:1][0:3] is 1364-2001 but not all tools.)
 */

module buf_2d (
    input  wire        clk,
    input  wire        we,
    input  wire [1:0]  row,
    input  wire [1:0]  col,
    input  wire [7:0]  din,
    output reg  [7:0]  dout
);
    reg [7:0] mem2d [0:7];  /* 2 rows x 4 cols = 8 entries */
    integer i;
    reg [2:0] idx;

    initial begin
        for (i = 0; i < 8; i = i + 1)
            mem2d[i] = 8'b0;
    end

    always @* idx = row * 4 + col;
    always @(posedge clk) begin
        dout <= mem2d[idx];
        if (we)
            mem2d[idx] <= din;
    end
endmodule

module top;
    reg        clk, we;
    reg [1:0]  row, col;
    reg [7:0]  din;
    wire [7:0] dout;

    buf_2d u_buf (.clk(clk), .we(we), .row(row), .col(col), .din(din), .dout(dout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Multi-dimensional style (1364-2001): buf[row*4+col] for 2x4");
        we = 0; row = 0; col = 0; din = 0;
        @(posedge clk);
        #2 we = 1; row = 0; col = 1; din = 8'hA1;
        @(posedge clk);
        #2 we = 1; row = 1; col = 2; din = 8'hB2;
        @(posedge clk);
        #2 we = 0; row = 0; col = 1;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  [0][1]=%h", dout);
        #2 row = 1; col = 2;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  [1][2]=%h", dout);
        #20 $finish;
    end
endmodule
