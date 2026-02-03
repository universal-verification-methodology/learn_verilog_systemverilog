# Build and run decoder example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): decoder.v
	iverilog -o $(TOP) decoder.v

clean:
	rm -f $(TOP)
