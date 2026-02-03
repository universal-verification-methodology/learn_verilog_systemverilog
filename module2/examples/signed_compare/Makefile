# Build and run signed_compare example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): signed_compare.v
	iverilog -o $(TOP) signed_compare.v

clean:
	rm -f $(TOP)
