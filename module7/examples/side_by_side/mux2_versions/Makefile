# Module 7: Side-by-side 2:1 mux (1995, 2001, 2005, 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): mux2_1364.v mux2_1800.sv top_mux2.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) mux2_1364.v mux2_1800.sv top_mux2.sv

clean:
	rm -f $(TOP)
