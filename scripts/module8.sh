#!/usr/bin/env bash
#
# Module 8: Quick Reference and Course Summary
# No new language features; runs quick-ref example and points to reference docs.
#

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE8_DIR="$ROOT_DIR/module8"

if ! command -v iverilog &>/dev/null; then
    echo "Error: iverilog not found. Install Icarus Verilog to run Module 8 quick-ref example."
    echo "  e.g. apt-get install iverilog   (Debian/Ubuntu)"
    exit 1
fi

echo "=== Module 8: Quick Reference and Course Summary ==="

echo ""
echo "--- examples/quick_ref (one-page cheat sheet) ---"
cd "$MODULE8_DIR/examples" && make run

echo ""
echo "--- examples/version_timeline ---"
cd "$MODULE8_DIR/examples/version_timeline" && make run

echo ""
echo "--- examples/design_subset ---"
cd "$MODULE8_DIR/examples/design_subset" && make run

echo ""
echo "--- examples/tool_support ---"
cd "$MODULE8_DIR/examples/tool_support" && make run

echo ""
echo "--- examples/construct_lookup ---"
cd "$MODULE8_DIR/examples/construct_lookup" && make run

echo ""
echo "--- examples/course_map ---"
cd "$MODULE8_DIR/examples/course_map" && make run

echo ""
echo "--- examples/migration_steps ---"
cd "$MODULE8_DIR/examples/migration_steps" && make run

echo ""
echo "--- examples/synthesizable_subset ---"
cd "$MODULE8_DIR/examples/synthesizable_subset" && make run

echo ""
echo "--- examples/version_selection ---"
cd "$MODULE8_DIR/examples/version_selection" && make run

echo ""
echo "--- examples/learning_path ---"
cd "$MODULE8_DIR/examples/learning_path" && make run

echo ""
echo "--- examples/pitfalls ---"
cd "$MODULE8_DIR/examples/pitfalls" && make run

echo ""
echo "--- Reference files: module8/docs/ ---"
echo "  version_table.md         - Construct-by-standard table"
echo "  migration_cheat_sheet.md - Migration quick ref + one-page cheat"
echo "  course_map.md            - Course map (Modules 1-8)"
echo ""
echo "  Full doc: docs/MODULE8.md"
echo ""
echo "=== Module 8 complete ==="
