# Build and run pipeline example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): pipeline.v
	iverilog -o $(TOP) pipeline.v

clean:
	rm -f $(TOP)
