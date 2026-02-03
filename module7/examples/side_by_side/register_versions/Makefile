# Module 7: Side-by-side register / DFF (1995, 2001, 2005, 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): register_1364.v register_1800.sv top_register.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) register_1364.v register_1800.sv top_register.sv

clean:
	rm -f $(TOP)
