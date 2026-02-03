# Module 7: Side-by-side counter (1995, 2001, 2005, 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): counter_1364.v counter_1800.sv top_counter.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) counter_1364.v counter_1800.sv top_counter.sv

clean:
	rm -f $(TOP)
