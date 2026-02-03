#!/usr/bin/env bash
#
# Module 6: IEEE 1800-2017 - Run examples and tests
# Requires: Simulator with SystemVerilog support (iverilog -g2012, Verilator)
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE6_DIR="$ROOT_DIR/module6"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 6."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 6: IEEE 1800-2017 ==="

# Examples
echo ""
echo "--- examples/subsets ---"
cd "$MODULE6_DIR/examples/subsets" && make run

echo ""
echo "--- examples/design_recap ---"
cd "$MODULE6_DIR/examples/design_recap" && make run

echo ""
echo "--- examples/assertions ---"
cd "$MODULE6_DIR/examples/assertions" && make run

echo ""
echo "--- examples/version_summary ---"
cd "$MODULE6_DIR/examples/version_summary" && make run

echo ""
echo "--- examples/migration ---"
cd "$MODULE6_DIR/examples/migration" && make run

echo ""
echo "--- examples/logic_single_driver ---"
cd "$MODULE6_DIR/examples/logic_single_driver" && make run

echo ""
echo "--- examples/priority_case ---"
cd "$MODULE6_DIR/examples/priority_case" && make run

echo ""
echo "--- examples/package_import ---"
cd "$MODULE6_DIR/examples/package_import" && make run

echo ""
echo "--- examples/unique_case ---"
cd "$MODULE6_DIR/examples/unique_case" && make run

# Tests
echo ""
echo "--- tests (alu_2017) ---"
cd "$MODULE6_DIR/tests" && make all

echo ""
echo "=== Module 6 complete ==="
