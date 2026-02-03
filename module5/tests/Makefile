# Module 5 tests - IEEE 1800-2009/2012

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
VVP ?= vvp

TESTS = test_decoder_inside test_fsm_assert test_mem_array

.PHONY: all clean $(TESTS)

all: $(addsuffix _sim,$(TESTS))
	@for t in $(TESTS); do $(VVP) $${t}_sim; done

test_decoder_inside_sim: test_decoder_inside.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

test_fsm_assert_sim: test_fsm_assert.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

test_mem_array_sim: test_mem_array.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

clean:
	rm -f $(addsuffix _sim,$(TESTS))
