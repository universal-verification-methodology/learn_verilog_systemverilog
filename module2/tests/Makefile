# Module 2 tests - IEEE 1364-2001

IVERILOG ?= iverilog
VVP ?= vvp

TESTS = test_mux_param test_shift_reg_gen test_counter_param

.PHONY: all clean $(TESTS)

all: $(addsuffix _sim,$(TESTS))
	@for t in $(TESTS); do $(VVP) $${t}_sim; done

test_mux_param_sim: test_mux_param.v
	$(IVERILOG) -o $@ $<

test_shift_reg_gen_sim: test_shift_reg_gen.v
	$(IVERILOG) -o $@ $<

test_counter_param_sim: test_counter_param.v
	$(IVERILOG) -o $@ $<

clean:
	rm -f $(addsuffix _sim,$(TESTS))
