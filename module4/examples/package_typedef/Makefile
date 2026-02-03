# Build and run package_typedef example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): package_typedef.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) package_typedef.sv

clean:
	rm -f $(TOP)
