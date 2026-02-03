# Module 8: Course map (reference)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): course_map.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) course_map.sv

clean:
	rm -f $(TOP)
