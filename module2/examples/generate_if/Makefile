# Build and run generate_if example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): gen_if.v
	iverilog -o $(TOP) gen_if.v

clean:
	rm -f $(TOP)
