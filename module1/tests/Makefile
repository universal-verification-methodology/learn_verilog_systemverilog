# Module 1 tests - IEEE 1364-1995
# Requires: iverilog (or compatible simulator)

IVERILOG ?= iverilog
VVP ?= vvp
DUT_DIR = ../dut/simple_gates

.PHONY: all test_and_gate test_mux2 clean

all: test_and_gate test_mux2

# Test and_gate DUT
test_and_gate: test_and_gate_sim
	$(VVP) test_and_gate_sim

test_and_gate_sim: test_and_gate.v $(DUT_DIR)/and_gate.v
	$(IVERILOG) -o test_and_gate_sim -I $(DUT_DIR) $(DUT_DIR)/and_gate.v test_and_gate.v

# Test mux2 (uses local mux2_1995.v)
test_mux2: test_mux2_sim
	$(VVP) test_mux2_sim

test_mux2_sim: test_mux2.v mux2_1995.v
	$(IVERILOG) -o test_mux2_sim test_mux2.v mux2_1995.v

clean:
	rm -f test_and_gate_sim test_mux2_sim
