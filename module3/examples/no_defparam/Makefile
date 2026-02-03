# Build and run no_defparam example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): no_defparam.v
	iverilog -o $(TOP) no_defparam.v

clean:
	rm -f $(TOP)
