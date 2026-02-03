# Build and run tasks_functions (ANSI) example (1364-2001)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): ansi_task_func.v
	iverilog -o $(TOP) ansi_task_func.v

clean:
	rm -f $(TOP)
