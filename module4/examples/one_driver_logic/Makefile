# Build and run one_driver_logic example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): one_driver_logic.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) one_driver_logic.sv

clean:
	rm -f $(TOP)
