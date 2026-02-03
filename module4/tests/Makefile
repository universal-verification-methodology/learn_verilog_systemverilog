# Module 4 tests - IEEE 1800-2005 SystemVerilog

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
VVP ?= vvp

TESTS = test_mux2_sv test_counter_sv test_decoder_unique test_bus_master_slave

.PHONY: all clean $(TESTS)

all: $(addsuffix _sim,$(TESTS))
	@for t in $(TESTS); do $(VVP) $${t}_sim; done

test_mux2_sv_sim: test_mux2_sv.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

test_counter_sv_sim: test_counter_sv.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

test_decoder_unique_sim: test_decoder_unique.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

test_bus_master_slave_sim: test_bus_master_slave.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

clean:
	rm -f $(addsuffix _sim,$(TESTS))
