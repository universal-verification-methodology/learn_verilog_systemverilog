# Build and run generate_ripple_adder example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): ripple_adder.v
	iverilog -o $(TOP) ripple_adder.v

clean:
	rm -f $(TOP)
