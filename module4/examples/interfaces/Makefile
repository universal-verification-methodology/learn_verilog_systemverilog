# Build and run interfaces example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): bus_if_example.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) bus_if_example.sv

clean:
	rm -f $(TOP)
