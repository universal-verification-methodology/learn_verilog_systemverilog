# Version summary (1800-2017 timeline)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): version_summary.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) version_summary.sv

clean:
	rm -f $(TOP)
