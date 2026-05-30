#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COURSE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILL="${SKILL_ROOT:-$HOME/.cursor/skills/module-to-slides-video}"

log() { echo "==> $*"; }

log "Learning guides + checklists (MODULE*.md, CHECKLIST.md)..."
python3 "$SCRIPT_DIR/generate_learning_content.py" --course-root "$COURSE_ROOT"

log "Hands-on labs (moduleN/EXAMPLES.md)..."
python3 "$SCRIPT_DIR/generate_examples_md.py" --course-root "$COURSE_ROOT"

"$SKILL/scripts/run_python.sh" \
  "$SKILL/scripts/generate_outline_from_module.py" \
  "$COURSE_ROOT" "$@"
python3 "$SCRIPT_DIR/patch_media_outlines.py" --course-root "$COURSE_ROOT"

"$SKILL/scripts/run_python.sh" \
  "$SKILL/scripts/print_slide_summary.py" \
  "$COURSE_ROOT"
