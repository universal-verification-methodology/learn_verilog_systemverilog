# Module 8: Learning path (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): learning_path.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) learning_path.sv

clean:
	rm -f $(TOP)
