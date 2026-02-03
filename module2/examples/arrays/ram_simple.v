/*
 * Simple synchronous RAM - IEEE 1364-2001 multi-dimensional arrays
 * reg [7:0] mem [0:255]; one read/write port.
 */

module ram_simple (
    input  wire        clk,
    input  wire        we,
    input  wire [7:0]  addr,
    input  wire [7:0]  din,
    output reg  [7:0]  dout
);
    reg [7:0] mem [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 8'b0;
    end

    always @(posedge clk) begin
        dout <= mem[addr];
        if (we)
            mem[addr] <= din;
    end
endmodule

module top;
    reg        clk, we;
    reg [7:0]  addr, din;
    wire [7:0] dout;

    ram_simple u_ram (.clk(clk), .we(we), .addr(addr), .din(din), .dout(dout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Multi-dimensional arrays (1364-2001): reg [7:0] mem [0:255]");
        we = 0; addr = 0; din = 0;
        @(posedge clk);
        #2 we = 1; addr = 8'd10; din = 8'hA5;
        @(posedge clk);
        #2 we = 1; addr = 8'd20; din = 8'hB2;
        @(posedge clk);
        #2 we = 0; addr = 8'd10;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  addr=10 dout=%h", dout);
        #2 addr = 8'd20;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  addr=20 dout=%h", dout);
        #20 $finish;
    end
endmodule
