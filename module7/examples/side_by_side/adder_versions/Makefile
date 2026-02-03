# Module 7: Side-by-side 8-bit adder (1995, 2001, 2005, 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): adder_1364.v adder_1800.sv top_adder.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) adder_1364.v adder_1800.sv top_adder.sv

clean:
	rm -f $(TOP)
