# Build and run continuous_assign_gates example (1364-1995)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): gates.v
	iverilog -o $(TOP) gates.v

clean:
	rm -f $(TOP)
