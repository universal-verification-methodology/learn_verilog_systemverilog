# Build and run range_check example (1800-2009/2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): range_check.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) range_check.sv

clean:
	rm -f $(TOP)
