# Module 7: No defparam - parameter at instantiation (1364-2005)

IVERILOG ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): no_defparam.v
	$(IVERILOG) -o $(TOP) no_defparam.v

clean:
	rm -f $(TOP)
