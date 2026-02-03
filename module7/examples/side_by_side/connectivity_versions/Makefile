# Module 7: Connectivity - 1364 (many ports)

IVERILOG ?= iverilog
IVFLAGS ?= -g2012

.PHONY: run clean

run: top_1364
	vvp top_1364

top_1364: bus_1364.v
	$(IVERILOG) -o top_1364 bus_1364.v

clean:
	rm -f top_1364
