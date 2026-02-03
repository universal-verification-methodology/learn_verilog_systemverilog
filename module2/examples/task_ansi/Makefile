# Build and run task_ansi example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): task_ansi.v
	iverilog -o $(TOP) task_ansi.v

clean:
	rm -f $(TOP)
