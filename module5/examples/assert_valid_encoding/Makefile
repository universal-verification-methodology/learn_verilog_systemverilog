# Build and run assert_valid_encoding example (1800-2009/2012)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): assert_valid_encoding.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) assert_valid_encoding.sv

clean:
	rm -f $(TOP)
