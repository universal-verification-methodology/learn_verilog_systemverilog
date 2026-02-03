# Module 7: Migration 1364 -> 1800 demo

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): migration_steps.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) migration_steps.sv

clean:
	rm -f $(TOP)
