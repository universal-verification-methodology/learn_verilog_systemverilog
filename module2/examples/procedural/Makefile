# Build and run procedural (always @*) example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): always_star.v
	iverilog -o $(TOP) always_star.v

clean:
	rm -f $(TOP)
