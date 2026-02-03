# Build and run generate example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): param_mux.v
	iverilog -o $(TOP) param_mux.v

clean:
	rm -f $(TOP)
