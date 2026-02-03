# Build and run procedural (blocking_nonblocking) example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): blocking_nonblocking.v
	iverilog -o $(TOP) blocking_nonblocking.v

clean:
	rm -f $(TOP)
