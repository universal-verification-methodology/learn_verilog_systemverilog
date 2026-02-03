# Module 6 tests - IEEE 1800-2017

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
VVP ?= vvp

TESTS = test_alu_2017

.PHONY: all clean $(TESTS)

all: $(addsuffix _sim,$(TESTS))
	@for t in $(TESTS); do $(VVP) $${t}_sim; done

test_alu_2017_sim: test_alu_2017.sv
	$(IVERILOG) $(IVFLAGS) -o $@ $<

clean:
	rm -f $(addsuffix _sim,$(TESTS))
