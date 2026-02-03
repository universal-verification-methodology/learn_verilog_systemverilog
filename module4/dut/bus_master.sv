/*
 * Bus master - IEEE 1800-2005
 * Uses bus_if.master; drives data and valid; reads ready.
 */

module bus_master (bus_if.master bus);
    always_ff @(posedge bus.clk) begin
        if (!bus.rst_n) begin
            bus.valid <= 1'b0;
            bus.data  <= 32'b0;
        end else begin
            bus.valid <= 1'b1;
            bus.data  <= 32'hDEAD_BEEF;
        end
    end
endmodule
