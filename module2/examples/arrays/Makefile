# Build and run arrays (RAM) example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): ram_simple.v
	iverilog -o $(TOP) ram_simple.v

clean:
	rm -f $(TOP)
