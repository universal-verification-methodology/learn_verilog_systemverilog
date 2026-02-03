# Immediate assertion in RTL (1800-2017)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): immediate_in_rtl.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) immediate_in_rtl.sv

clean:
	rm -f $(TOP)
