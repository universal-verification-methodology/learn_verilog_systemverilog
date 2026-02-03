# Build and run packages example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): pkg_util.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) pkg_util.sv

clean:
	rm -f $(TOP)
