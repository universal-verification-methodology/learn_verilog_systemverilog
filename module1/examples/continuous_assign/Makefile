# Build and run continuous_assign example (1364-1995)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): mux2.v
	iverilog -o $(TOP) mux2.v

clean:
	rm -f $(TOP)
