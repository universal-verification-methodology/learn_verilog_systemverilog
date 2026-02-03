# Build and run signed example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): adder_signed.v
	iverilog -o $(TOP) adder_signed.v

clean:
	rm -f $(TOP)
