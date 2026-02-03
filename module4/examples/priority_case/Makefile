# Build and run priority_case example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): priority_case.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) priority_case.sv

clean:
	rm -f $(TOP)
