# Module 8: Quick reference (prints cheat sheet)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): quick_ref.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) quick_ref.sv

clean:
	rm -f $(TOP)
