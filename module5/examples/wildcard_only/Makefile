# Build and run wildcard_only example (1800-2009/2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): wildcard_only.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) wildcard_only.sv

clean:
	rm -f $(TOP)
