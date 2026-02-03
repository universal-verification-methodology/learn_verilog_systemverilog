# Build and run migration example (1800-2005)

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
