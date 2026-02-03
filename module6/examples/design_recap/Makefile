# Design recap (1800-2017): logic, always_comb, always_ff, package, unique case

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): design_recap.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) design_recap.sv

clean:
	rm -f $(TOP)
