# Module 7 tests - version comparison

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
VVP ?= vvp

TESTS = test_mux2_all test_counter_all

.PHONY: all clean $(TESTS)

all: $(addsuffix _sim,$(TESTS))
	@for t in $(TESTS); do $(VVP) $${t}_sim; done

test_mux2_all_sim: test_mux2_all.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

test_counter_all_sim: test_counter_all.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

clean:
	rm -f $(addsuffix _sim,$(TESTS))
