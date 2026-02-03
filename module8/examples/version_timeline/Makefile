# Module 8: Version timeline (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): version_timeline.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) version_timeline.sv

clean:
	rm -f $(TOP)
