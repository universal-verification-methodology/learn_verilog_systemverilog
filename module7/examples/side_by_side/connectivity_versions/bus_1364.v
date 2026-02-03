/*
 * Module 7: Connectivity - 1364 style (many ports)
 * Master and slave connected by individual wires.
 */

module master_1364 (
    output reg  [31:0] data,
    output reg         valid,
    input  wire        ready,
    input  wire        clk,
    input  wire        rst_n
);
    always @(posedge clk) begin
        if (!rst_n) begin
            data  <= 0;
            valid <= 0;
        end else begin
            data  <= 32'hDEAD;
            valid <= 1;
        end
    end
endmodule

module slave_1364 (
    input  wire [31:0] data,
    input  wire        valid,
    output reg         ready,
    input  wire        clk,
    input  wire        rst_n
);
    always @(posedge clk) begin
        if (!rst_n)
            ready <= 0;
        else
            ready <= valid;
    end
endmodule

module top;
    wire [31:0] data;
    wire        valid, ready, clk, rst_n;
    reg         clk_r, rst_n_r;

    master_1364 u_master (.data(data), .valid(valid), .ready(ready), .clk(clk), .rst_n(rst_n));
    slave_1364  u_slave  (.data(data), .valid(valid), .ready(ready), .clk(clk), .rst_n(rst_n));

    assign clk   = clk_r;
    assign rst_n = rst_n_r;

    initial clk_r = 0;
    always #5 clk_r = ~clk_r;

    initial begin
        $display("Module 7: Connectivity 1364 (many ports)");
        rst_n_r = 0; #20 rst_n_r = 1;
        #30 $display("  data=%h valid=%b ready=%b", data, valid, ready);
        $display("  Same protocol; many ports per module.");
        $finish;
    end
endmodule
