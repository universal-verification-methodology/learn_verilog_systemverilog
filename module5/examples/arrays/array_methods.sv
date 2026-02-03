/*
 * Array usage - IEEE 1800-2012 clarifications
 * Fixed array in RTL; indexing and assignment. (Methods like .size() are for dynamic arrays in testbenches.)
 */

module mem_simple #(parameter int DEPTH = 16, parameter int WIDTH = 8) (
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

    mem_simple #(.DEPTH(16), .WIDTH(8)) u_mem (.clk(clk), .we(we), .addr(addr), .din(din), .dout(dout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Array (1800-2012): fixed array; parameterized DEPTH/WIDTH");
        we = 0; addr = 0; din = 0;
        @(posedge clk);
        #2 we = 1; addr = 4'd3; din = 8'hA3;
        @(posedge clk);
        #2 we = 0; addr = 4'd3;
        @(posedge clk);
        @(posedge clk);
        #1 $display("  addr=3 dout=%h", dout);
        #20 $finish;
    end
endmodule
