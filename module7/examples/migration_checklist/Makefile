# Module 7: Migration checklist reminder

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): migration_checklist.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) migration_checklist.sv

clean:
	rm -f $(TOP)
