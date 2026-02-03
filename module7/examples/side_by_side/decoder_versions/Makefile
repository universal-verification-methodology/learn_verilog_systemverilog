# Module 7: Side-by-side 2:4 decoder (1995, 2001, 2005, 1800)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012
TOP ?= top

.PHONY: run clean

run: $(TOP)
	vvp $(TOP)

$(TOP): decoder_1364.v decoder_1800.sv top_decoder.sv
	$(IVERILOG) $(IVFLAGS) -o $(TOP) decoder_1364.v decoder_1800.sv top_decoder.sv

clean:
	rm -f $(TOP)
