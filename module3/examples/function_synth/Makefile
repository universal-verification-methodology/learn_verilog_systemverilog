# Build and run function_synth example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): function_synth.v
	iverilog -o $(TOP) function_synth.v

clean:
	rm -f $(TOP)
