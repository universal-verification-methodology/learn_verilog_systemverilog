# Build and run modules_ports example (1364-1995)
# Requires: iverilog (or compatible simulator)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): and_gate.v
	iverilog -o $(TOP) and_gate.v

clean:
	rm -f $(TOP)
