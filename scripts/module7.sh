#!/usr/bin/env bash
#
# Module 7: Version Comparison and Migration - Run examples and tests
# Requires: iverilog (Verilog + SystemVerilog -g2012)
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE7_DIR="$ROOT_DIR/module7"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 7."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 7: Version Comparison and Migration ==="

# Side-by-side examples
echo ""
echo "--- examples/side_by_side/mux2_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/mux2_versions" && make run

echo ""
echo "--- examples/side_by_side/counter_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/counter_versions" && make run

echo ""
echo "--- examples/side_by_side/decoder_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/decoder_versions" && make run

echo ""
echo "--- examples/side_by_side/adder_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/adder_versions" && make run

echo ""
echo "--- examples/side_by_side/parameter_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/parameter_versions" && make run

echo ""
echo "--- examples/side_by_side/register_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/register_versions" && make run

echo ""
echo "--- examples/side_by_side/fsm_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/fsm_versions" && make run

echo ""
echo "--- examples/side_by_side/connectivity_versions ---"
cd "$MODULE7_DIR/examples/side_by_side/connectivity_versions" && make run

# Migration and version/selection
echo ""
echo "--- examples/migration ---"
cd "$MODULE7_DIR/examples/migration" && make run

echo ""
echo "--- examples/migration_1995_to_2001 ---"
cd "$MODULE7_DIR/examples/migration_1995_to_2001" && make run

echo ""
echo "--- examples/case_versions ---"
cd "$MODULE7_DIR/examples/case_versions" && make run

echo ""
echo "--- examples/version_table ---"
cd "$MODULE7_DIR/examples/version_table" && make run

echo ""
echo "--- examples/version_selection ---"
cd "$MODULE7_DIR/examples/version_selection" && make run

echo ""
echo "--- examples/migration_checklist ---"
cd "$MODULE7_DIR/examples/migration_checklist" && make run

echo ""
echo "--- examples/incremental_migration ---"
cd "$MODULE7_DIR/examples/incremental_migration" && make run

echo ""
echo "--- examples/port_style_compare ---"
cd "$MODULE7_DIR/examples/port_style_compare" && make run

echo ""
echo "--- examples/no_defparam ---"
cd "$MODULE7_DIR/examples/no_defparam" && make run

# Tests
echo ""
echo "--- tests (mux2 all, counter all) ---"
cd "$MODULE7_DIR/tests" && make all

echo ""
echo "=== Module 7 complete ==="
