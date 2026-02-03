# Module 7: case 1364 vs 1800 unique case

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): case_versions.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) case_versions.sv

clean:
	rm -f $(TOP)
