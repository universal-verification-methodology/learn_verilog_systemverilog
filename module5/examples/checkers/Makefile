# Build and run checkers (immediate assert) example (1800-2009/2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): immediate_assert.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) immediate_assert.sv

clean:
	rm -f $(TOP)
