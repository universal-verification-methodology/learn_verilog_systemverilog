/*
 * Parameterized array - IEEE 1800-2012
 * DEPTH and WIDTH parameters; $clog2(DEPTH) for address width.
 */

module mem_param #(parameter int DEPTH = 32, parameter int WIDTH = 8) (
    input  logic clk,
    input  logic we,
    input  logic [$clog2(DEPTH)-1:0] addr,
    input  logic [WIDTH-1:0] din,
    output logic [WIDTH-1:0] dout
);
    logic [WIDTH-1:0] mem [0:DEPTH-1];

    always_ff @(posedge clk) begin
        dout <= mem[addr];
        if (we)
            mem[addr] <= din;
    end
endmodule

module top;
    logic clk, we;
    logic [3:0] addr;
    logic [7:0] din, dout;

    mem_param #(.DEPTH(16), .WIDTH(8)) u_mem (.clk(clk), .we(we), .addr(addr), .din(din), .dout(dout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Parameterized array (1800-2012): DEPTH=16 WIDTH=8 $clog2(DEPTH)=4");
        we = 0; addr = 0; din = 0;
        @(posedge clk);
        #2 we = 1; addr = 4'd5; din = 8'h55;
        @(posedge clk);
        #2 we = 0; addr = 4'd5;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  addr=5 dout=%h", dout);
        #20 $finish;
    end
endmodule
