# package and import (1800-2017)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): package_import.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) package_import.sv

clean:
	rm -f $(TOP)
