# Module 7: Side-by-side parameter (1364 vs 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): param_1364.v param_1800.sv top_param.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) param_1364.v param_1800.sv top_param.sv

clean:
	rm -f $(TOP)
