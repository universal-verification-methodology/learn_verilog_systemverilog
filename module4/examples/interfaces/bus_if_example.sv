/*
 * Interface and modports - IEEE 1800-2005
 * One bundle; modports define direction per role.
 */

interface simple_bus_if;
    logic [7:0] data;
    logic        valid;
    logic        ready;
    logic        clk;
    logic        rst_n;

    modport master (output data, valid, input ready, clk, rst_n);
    modport slave  (input data, valid, output ready, input clk, rst_n);
endinterface

module producer (simple_bus_if.master m);
    always_ff @(posedge m.clk) begin
        if (!m.rst_n) begin
            m.valid <= 1'b0;
            m.data  <= 8'b0;
        end else begin
            m.valid <= 1'b1;
            m.data  <= 8'hA5;
        end
    end
endmodule

module consumer (simple_bus_if.slave s);
    always_comb
        s.ready = s.valid;
endmodule

module top;
    simple_bus_if bus();
    producer u_prod (.m(bus));
    consumer u_cons (.s(bus));

    initial bus.clk = 0;
    always #5 bus.clk = ~bus.clk;

    initial begin
        $display("Interface and modports (1800-2005)");
        bus.rst_n = 0;
        repeat(3) @(posedge bus.clk);
        bus.rst_n = 1;
        repeat(2) @(posedge bus.clk) $display("  data=%h valid=%b ready=%b", bus.data, bus.valid, bus.ready);
        $finish;
    end
endmodule
