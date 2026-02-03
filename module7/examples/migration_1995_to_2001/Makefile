# Module 7: Migration 1995 -> 2001 (ANSI, @*)

IVERILOG ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): migration_1995_2001.v
	$(IVERILOG) -o $(TOP) migration_1995_2001.v

clean:
	rm -f $(TOP)
