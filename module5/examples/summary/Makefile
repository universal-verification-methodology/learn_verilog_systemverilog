# Build and run summary (2005 vs 2009/2012) example

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): summary_2012.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) summary_2012.sv

clean:
	rm -f $(TOP)
