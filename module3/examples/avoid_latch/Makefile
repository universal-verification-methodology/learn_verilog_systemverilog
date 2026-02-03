# Build and run avoid_latch example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): avoid_latch.v
	iverilog -o $(TOP) avoid_latch.v

clean:
	rm -f $(TOP)
