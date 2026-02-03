# Build and run arrays example (1800-2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): array_methods.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) array_methods.sv

clean:
	rm -f $(TOP)
