/*
 * Bus slave - IEEE 1800-2005
 * Uses bus_if.slave; drives ready; reads data and valid.
 */

module bus_slave (bus_if.slave bus);
    always_comb
        bus.ready = bus.valid;
endmodule
