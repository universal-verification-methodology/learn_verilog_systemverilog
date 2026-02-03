# logic single driver (1800-2017)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): logic_single_driver.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) logic_single_driver.sv

clean:
	rm -f $(TOP)
