# Module 8: Pitfalls (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): pitfalls.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) pitfalls.sv

clean:
	rm -f $(TOP)
