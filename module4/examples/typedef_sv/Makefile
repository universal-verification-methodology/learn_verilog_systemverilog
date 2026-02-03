# Build and run typedef_sv example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): typedef_sv.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) typedef_sv.sv

clean:
	rm -f $(TOP)
