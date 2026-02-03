# Build and run assert_invariant example (1800-2009/2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): assert_invariant.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) assert_invariant.sv

clean:
	rm -f $(TOP)
