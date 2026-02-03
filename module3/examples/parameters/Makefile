# Build and run parameters (param_override) example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): param_override.v
	iverilog -o $(TOP) param_override.v

clean:
	rm -f $(TOP)
