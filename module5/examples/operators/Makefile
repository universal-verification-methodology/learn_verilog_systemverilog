# Build and run operators (inside, ==?) example (1800-2009/2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): inside_wildcard.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) inside_wildcard.sv

clean:
	rm -f $(TOP)
