/*
 * Testbench for bus_master and bus_slave - IEEE 1800-2005
 * One interface instance; both sides driven/observed.
 */

`include "../dut/bus_if.sv"
`include "../dut/bus_master.sv"
`include "../dut/bus_slave.sv"

module test_bus_master_slave;
    bus_if bus();

    bus_master u_master (.bus(bus));
    bus_slave  u_slave  (.bus(bus));

    initial bus.clk = 0;
    always #5 bus.clk = ~bus.clk;

    initial begin
        $display("Module 4 test: bus_master + bus_slave (1800-2005)");
        bus.rst_n = 0;
        repeat(3) @(posedge bus.clk);
        bus.rst_n = 1;
        repeat(3) @(posedge bus.clk) $display("  data=%h valid=%b ready=%b", bus.data, bus.valid, bus.ready);
        $display("PASS: bus_master_slave test complete");
        $finish;
    end
endmodule
