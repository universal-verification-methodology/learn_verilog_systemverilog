# Build and run multi_dim_arrays example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): multi_dim.v
	iverilog -o $(TOP) multi_dim.v

clean:
	rm -f $(TOP)
