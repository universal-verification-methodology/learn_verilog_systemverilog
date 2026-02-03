# Build and run summary (1364-2005 checklist) example

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): summary_2005.v
	iverilog -o $(TOP) summary_2005.v

clean:
	rm -f $(TOP)
