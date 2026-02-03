# Module 7: Version table (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): version_table.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) version_table.sv

clean:
	rm -f $(TOP)
