# Build and run logic_ports example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): logic_ports.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) logic_ports.sv

clean:
	rm -f $(TOP)
