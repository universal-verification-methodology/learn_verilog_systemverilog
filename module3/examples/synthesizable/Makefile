# Build and run synthesizable example (1364-2005)

SIM ?= iverilog
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): comb_seq_style.v
	iverilog -o $(TOP) comb_seq_style.v

clean:
	rm -f $(TOP)
