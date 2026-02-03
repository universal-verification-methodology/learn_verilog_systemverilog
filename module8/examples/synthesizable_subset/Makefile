# Module 8: Synthesizable subset (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): synthesizable_subset.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) synthesizable_subset.sv

clean:
	rm -f $(TOP)
