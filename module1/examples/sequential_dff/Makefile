# Build and run sequential_dff example (1364-1995)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): dff.v
	iverilog -o $(TOP) dff.v

clean:
	rm -f $(TOP)
