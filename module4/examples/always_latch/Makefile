# Build and run always_latch example (1800-2005)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): always_latch.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) always_latch.sv

clean:
	rm -f $(TOP)
