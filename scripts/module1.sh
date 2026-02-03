#!/usr/bin/env bash
#
# Module 1: IEEE 1364-1995 - Run examples and tests
# Requires: iverilog (Icarus Verilog) or compatible simulator
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE1_DIR="$ROOT_DIR/module1"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 1 examples and tests."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 1: IEEE 1364-1995 (Verilog-95) ==="

# Examples
echo ""
echo "--- examples/modules_ports ---"
cd "$MODULE1_DIR/examples/modules_ports" && make run

echo ""
echo "--- examples/nets_variables ---"
cd "$MODULE1_DIR/examples/nets_variables" && make run

echo ""
echo "--- examples/continuous_assign ---"
cd "$MODULE1_DIR/examples/continuous_assign" && make run

echo ""
echo "--- examples/continuous_assign_gates ---"
cd "$MODULE1_DIR/examples/continuous_assign_gates" && make run

echo ""
echo "--- examples/adder ---"
cd "$MODULE1_DIR/examples/adder" && make run

echo ""
echo "--- examples/procedural ---"
cd "$MODULE1_DIR/examples/procedural" && make run

echo ""
echo "--- examples/sequential_dff ---"
cd "$MODULE1_DIR/examples/sequential_dff" && make run

echo ""
echo "--- examples/delays_timing ---"
cd "$MODULE1_DIR/examples/delays_timing" && make run

# Tests
echo ""
echo "--- tests (and_gate, mux2) ---"
cd "$MODULE1_DIR/tests" && make all

echo ""
echo "=== Module 1 complete ==="
