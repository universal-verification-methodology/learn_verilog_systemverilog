# Build and run case_unique_priority example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): decoder.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) decoder.sv

clean:
	rm -f $(TOP)
