/*
 * Simple bus interface - IEEE 1800-2005
 * Bundles data, valid, ready; modports for master and slave.
 */

interface bus_if;
    logic [31:0] data;
    logic        valid;
    logic        ready;
    logic        clk;
    logic        rst_n;

    modport master (output data, valid, input ready, clk, rst_n);
    modport slave  (input data, valid, output ready, input clk, rst_n);
endinterface
