# Migration 1364 -> 1800 (1800-2017)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): migration.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) migration.sv

clean:
	rm -f $(TOP)
