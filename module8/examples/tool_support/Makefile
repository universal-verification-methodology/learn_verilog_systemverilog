# Module 8: Tool support (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): tool_support.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) tool_support.sv

clean:
	rm -f $(TOP)
