# Build and run data_types example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): logic_bit.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) logic_bit.sv

clean:
	rm -f $(TOP)
