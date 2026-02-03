# Build and run procedural (always_comb/always_ff) example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): always_comb_ff.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) always_comb_ff.sv

clean:
	rm -f $(TOP)
