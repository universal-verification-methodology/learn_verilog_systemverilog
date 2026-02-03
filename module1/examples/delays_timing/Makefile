# Build and run delays_timing example (1364-1995)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): timing.v
	iverilog -o $(TOP) timing.v

clean:
	rm -f $(TOP)
