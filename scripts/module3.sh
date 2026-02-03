#!/usr/bin/env bash
#
# Module 3: IEEE 1364-2005 - Run examples and tests
# Requires: iverilog (Icarus Verilog) or compatible simulator
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE3_DIR="$ROOT_DIR/module3"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 3 examples and tests."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 3: IEEE 1364-2005 (Verilog-2005) ==="

# Examples
echo ""
echo "--- examples/parameters ---"
cd "$MODULE3_DIR/examples/parameters" && make run

echo ""
echo "--- examples/no_defparam ---"
cd "$MODULE3_DIR/examples/no_defparam" && make run

echo ""
echo "--- examples/synthesizable ---"
cd "$MODULE3_DIR/examples/synthesizable" && make run

echo ""
echo "--- examples/one_driver ---"
cd "$MODULE3_DIR/examples/one_driver" && make run

echo ""
echo "--- examples/procedural ---"
cd "$MODULE3_DIR/examples/procedural" && make run

echo ""
echo "--- examples/pipeline ---"
cd "$MODULE3_DIR/examples/pipeline" && make run

echo ""
echo "--- examples/case_styles ---"
cd "$MODULE3_DIR/examples/case_styles" && make run

echo ""
echo "--- examples/avoid_latch ---"
cd "$MODULE3_DIR/examples/avoid_latch" && make run

echo ""
echo "--- examples/function_synth ---"
cd "$MODULE3_DIR/examples/function_synth" && make run

echo ""
echo "--- examples/summary ---"
cd "$MODULE3_DIR/examples/summary" && make run

# Tests
echo ""
echo "--- tests (counter_2005, fsm_2005, param_chain) ---"
cd "$MODULE3_DIR/tests" && make all

echo ""
echo "=== Module 3 complete ==="
