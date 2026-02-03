# Build and run one_driver example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): one_driver.v
	iverilog -o $(TOP) one_driver.v

clean:
	rm -f $(TOP)
