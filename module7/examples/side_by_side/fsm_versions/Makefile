# Module 7: Side-by-side FSM (1364 vs 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): fsm_1364.v fsm_1800.sv top_fsm.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) fsm_1364.v fsm_1800.sv top_fsm.sv

clean:
	rm -f $(TOP)
