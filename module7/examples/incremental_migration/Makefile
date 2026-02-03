# Module 7: Incremental migration (step1 1364, step2 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): incremental_migration.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) incremental_migration.sv

clean:
	rm -f $(TOP)
