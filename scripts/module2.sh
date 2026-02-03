#!/usr/bin/env bash
#
# Module 2: IEEE 1364-2001 - Run examples and tests
# Requires: iverilog (Icarus Verilog) or compatible simulator
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE2_DIR="$ROOT_DIR/module2"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 2 examples and tests."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 2: IEEE 1364-2001 (Verilog-2001) ==="

# Examples
echo ""
echo "--- examples/ansi_ports ---"
cd "$MODULE2_DIR/examples/ansi_ports" && make run

echo ""
echo "--- examples/procedural ---"
cd "$MODULE2_DIR/examples/procedural" && make run

echo ""
echo "--- examples/generate ---"
cd "$MODULE2_DIR/examples/generate" && make run

echo ""
echo "--- examples/generate_if ---"
cd "$MODULE2_DIR/examples/generate_if" && make run

echo ""
echo "--- examples/generate_ripple_adder ---"
cd "$MODULE2_DIR/examples/generate_ripple_adder" && make run

echo ""
echo "--- examples/signed ---"
cd "$MODULE2_DIR/examples/signed" && make run

echo ""
echo "--- examples/signed_compare ---"
cd "$MODULE2_DIR/examples/signed_compare" && make run

echo ""
echo "--- examples/decoder ---"
cd "$MODULE2_DIR/examples/decoder" && make run

echo ""
echo "--- examples/arrays ---"
cd "$MODULE2_DIR/examples/arrays" && make run

echo ""
echo "--- examples/multi_dim_arrays ---"
cd "$MODULE2_DIR/examples/multi_dim_arrays" && make run

echo ""
echo "--- examples/parameters ---"
cd "$MODULE2_DIR/examples/parameters" && make run

echo ""
echo "--- examples/tasks_functions ---"
cd "$MODULE2_DIR/examples/tasks_functions" && make run

echo ""
echo "--- examples/task_ansi ---"
cd "$MODULE2_DIR/examples/task_ansi" && make run

# Tests
echo ""
echo "--- tests (mux_param, shift_reg_gen, counter_param) ---"
cd "$MODULE2_DIR/tests" && make all

echo ""
echo "=== Module 2 complete ==="
