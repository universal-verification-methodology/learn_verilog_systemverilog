# Build testbench - requires and_gate.v from dut
# Run from module1 root or set DUT path

IVERILOG ?= iverilog
DUT_DIR ?= ../../dut/simple_gates

.PHONY: run clean

run: test_and_gate
	vvp test_and_gate

test_and_gate: test_and_gate.v $(DUT_DIR)/and_gate.v
	$(IVERILOG) -o test_and_gate -I $(DUT_DIR) $(DUT_DIR)/and_gate.v test_and_gate.v

clean:
	rm -f test_and_gate
