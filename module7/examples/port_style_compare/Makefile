# Module 7: Port style - non-ANSI vs ANSI

IVERILOG ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): port_style_compare.v
	$(IVERILOG) -o $(TOP) port_style_compare.v

clean:
	rm -f $(TOP)
