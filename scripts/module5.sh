#!/usr/bin/env bash
#
# Module 5: IEEE 1800-2009/2012 - Run examples and tests
# Requires: Simulator with SystemVerilog support (iverilog -g2012, Verilator)
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE5_DIR="$ROOT_DIR/module5"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 5."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 5: IEEE 1800-2009 / 1800-2012 ==="

# Examples
echo ""
echo "--- examples/operators ---"
cd "$MODULE5_DIR/examples/operators" && make run

echo ""
echo "--- examples/wildcard_only ---"
cd "$MODULE5_DIR/examples/wildcard_only" && make run

echo ""
echo "--- examples/range_check ---"
cd "$MODULE5_DIR/examples/range_check" && make run

echo ""
echo "--- examples/arrays ---"
cd "$MODULE5_DIR/examples/arrays" && make run

echo ""
echo "--- examples/array_param ---"
cd "$MODULE5_DIR/examples/array_param" && make run

echo ""
echo "--- examples/checkers ---"
cd "$MODULE5_DIR/examples/checkers" && make run

echo ""
echo "--- examples/assert_valid_encoding ---"
cd "$MODULE5_DIR/examples/assert_valid_encoding" && make run

echo ""
echo "--- examples/assert_invariant ---"
cd "$MODULE5_DIR/examples/assert_invariant" && make run

echo ""
echo "--- examples/summary ---"
cd "$MODULE5_DIR/examples/summary" && make run

# Tests
echo ""
echo "--- tests (decoder_inside, small_fsm_sv, mem_array_sv) ---"
cd "$MODULE5_DIR/tests" && make all

echo ""
echo "=== Module 5 complete ==="
