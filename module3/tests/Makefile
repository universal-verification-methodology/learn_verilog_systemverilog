# Module 3 tests - IEEE 1364-2005

IVERILOG ?= iverilog
VVP ?= vvp

TESTS = test_counter_2005 test_fsm_2005 test_param_chain

.PHONY: all clean $(TESTS)

all: $(addsuffix _sim,$(TESTS))
	@for t in $(TESTS); do $(VVP) $${t}_sim; done

test_counter_2005_sim: test_counter_2005.v
	$(IVERILOG) -o $@ $<

test_fsm_2005_sim: test_fsm_2005.v
	$(IVERILOG) -o $@ $<

test_param_chain_sim: test_param_chain.v
	$(IVERILOG) -o $@ $<

clean:
	rm -f $(addsuffix _sim,$(TESTS))
