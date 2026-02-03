# Module 8: Design subset (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): design_subset.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) design_subset.sv

clean:
	rm -f $(TOP)
