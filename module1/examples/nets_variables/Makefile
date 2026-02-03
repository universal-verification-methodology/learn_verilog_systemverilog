# Build and run nets_variables example (1364-1995)

SIM ?= iverilog
TOP ?= data_types

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): data_types.v
	iverilog -o $(TOP) data_types.v

clean:
	rm -f $(TOP)
