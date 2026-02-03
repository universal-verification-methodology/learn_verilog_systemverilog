# Build and run case_styles example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): case_full_parallel.v
	iverilog -o $(TOP) case_full_parallel.v

clean:
	rm -f $(TOP)
