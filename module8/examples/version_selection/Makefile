# Module 8: Version selection (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): version_selection.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) version_selection.sv

clean:
	rm -f $(TOP)
