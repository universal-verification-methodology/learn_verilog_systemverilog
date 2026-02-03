#!/usr/bin/env bash
#
# Module 4: IEEE 1800-2005 SystemVerilog design subset - Run examples and tests
# Requires: Simulator with SystemVerilog support (iverilog -g2012, Verilator, or ModelSim)
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE4_DIR="$ROOT_DIR/module4"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 4."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 4: IEEE 1800-2005 (SystemVerilog Design Subset) ==="

# Examples
echo ""
echo "--- examples/data_types ---"
cd "$MODULE4_DIR/examples/data_types" && make run

echo ""
echo "--- examples/logic_ports ---"
cd "$MODULE4_DIR/examples/logic_ports" && make run

echo ""
echo "--- examples/procedural ---"
cd "$MODULE4_DIR/examples/procedural" && make run

echo ""
echo "--- examples/always_latch ---"
cd "$MODULE4_DIR/examples/always_latch" && make run

echo ""
echo "--- examples/one_driver_logic ---"
cd "$MODULE4_DIR/examples/one_driver_logic" && make run

echo ""
echo "--- examples/typedef_sv ---"
cd "$MODULE4_DIR/examples/typedef_sv" && make run

echo ""
echo "--- examples/interfaces ---"
cd "$MODULE4_DIR/examples/interfaces" && make run || true

echo ""
echo "--- examples/packages ---"
cd "$MODULE4_DIR/examples/packages" && make run

echo ""
echo "--- examples/package_typedef ---"
cd "$MODULE4_DIR/examples/package_typedef" && make run

echo ""
echo "--- examples/case_unique_priority ---"
cd "$MODULE4_DIR/examples/case_unique_priority" && make run

echo ""
echo "--- examples/priority_case ---"
cd "$MODULE4_DIR/examples/priority_case" && make run

echo ""
echo "--- examples/migration ---"
cd "$MODULE4_DIR/examples/migration" && make run

# Tests (bus_master_slave may fail with iverilog - interface ports not fully supported)
echo ""
echo "--- tests (mux2_sv, counter_sv, decoder_unique) ---"
cd "$MODULE4_DIR/tests" && make test_mux2_sv_sim test_counter_sv_sim test_decoder_unique_sim
cd "$MODULE4_DIR/tests" && vvp test_mux2_sv_sim && vvp test_counter_sv_sim && vvp test_decoder_unique_sim
echo ""
echo "--- test_bus_master_slave (optional; may fail with iverilog) ---"
cd "$MODULE4_DIR/tests" && (make test_bus_master_slave_sim 2>/dev/null && vvp test_bus_master_slave_sim) || echo "  Skip: interface ports not supported by iverilog"

echo ""
echo "=== Module 4 complete ==="
