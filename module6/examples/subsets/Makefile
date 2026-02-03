# Verilog vs SystemVerilog subset (1800-2017)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): verilog_vs_sv.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) verilog_vs_sv.sv

clean:
	rm -f $(TOP)
