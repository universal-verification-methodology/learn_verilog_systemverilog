# Build and run array_param example (1800-2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): array_param.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) array_param.sv

clean:
	rm -f $(TOP)
