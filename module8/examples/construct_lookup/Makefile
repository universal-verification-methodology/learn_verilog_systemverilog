# Module 8: Construct lookup (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): construct_lookup.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) construct_lookup.sv

clean:
	rm -f $(TOP)
