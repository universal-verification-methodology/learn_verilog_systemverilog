# Build and run adder example (1364-1995)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): adder.v
	iverilog -o $(TOP) adder.v

clean:
	rm -f $(TOP)
