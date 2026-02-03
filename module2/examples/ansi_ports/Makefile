# Build and run ansi_ports example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): mux2.v
	iverilog -o $(TOP) mux2.v

clean:
	rm -f $(TOP)
