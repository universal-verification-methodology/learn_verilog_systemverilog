# Build and run parameters/localparam example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): counter_param.v
	iverilog -o $(TOP) counter_param.v

clean:
	rm -f $(TOP)
