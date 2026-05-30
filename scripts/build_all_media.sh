#!/usr/bin/env bash
#
# Build slides (pptx), PDF, and video for all learn_verilog_systemverilog modules.
#
# Usage (from repo root or anywhere):
#   ./scripts/build_all_media.sh
#   ./scripts/build_all_media.sh --pptx-only
#   ./scripts/build_all_media.sh --module 3
#   ./scripts/build_all_media.sh --regenerate-outlines
#   ./scripts/build_all_media.sh --regenerate-examples   # refresh moduleN/EXAMPLES.md
#   ./scripts/build_all_media.sh --install-deps
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COURSE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILL_ROOT="${SKILL_ROOT:-$HOME/.cursor/skills/module-to-slides-video}"
SKILL_SCRIPTS="$SKILL_ROOT/scripts"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

PPTX_ONLY=0
REGENERATE=0
REGENERATE_EXAMPLES=0
INSTALL_DEPS=0
MODULES_FILTER=""
SECONDS_PER_SLIDE=8
RUN_DEMOS=0
EXTRA_ARGS=()

usage() {
  sed -n '3,15p' "$0" | sed 's/^# \{0,1\}//'
  echo ""
  echo "Options:"
  echo "  --pptx-only              Skip PDF and video"
  echo "  --module N               Only module N or list 1,2,3"
  echo "  --regenerate-outlines    Regenerate outline.yaml from MODULE*.md + EXAMPLES.md"
  echo "  --regenerate-examples    Regenerate moduleN/EXAMPLES.md from docs + examples/"
  echo "  --install-deps           sudo apt install libreoffice ffmpeg poppler-utils iverilog"
  echo "  --seconds-per-slide N    Video timing (default: 8)"
  echo "  --run-demos              Run make demos during verify (slow; needs iverilog)"
  echo "  -h, --help               Show help"
}

log() { echo -e "${CYAN}==>${NC} $*"; }
ok() { echo -e "${GREEN}OK:${NC} $*"; }
warn() { echo -e "${YELLOW}WARN:${NC} $*" >&2; }
die() { echo -e "${RED}ERROR:${NC} $*" >&2; exit 1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pptx-only) PPTX_ONLY=1; shift ;;
    --regenerate-outlines) REGENERATE=1; shift ;;
    --regenerate-examples) REGENERATE_EXAMPLES=1; shift ;;
    --install-deps) INSTALL_DEPS=1; shift ;;
    --module) MODULES_FILTER="$2"; shift 2 ;;
    --seconds-per-slide) SECONDS_PER_SLIDE="$2"; shift 2 ;;
    --run-demos) RUN_DEMOS=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) EXTRA_ARGS+=("$1"); shift ;;
  esac
done

[[ -d "$SKILL_SCRIPTS" ]] || die "Skill not found: $SKILL_SCRIPTS (expected module-to-slides-video skill)"

install_system_deps() {
  log "Installing system packages (sudo required)..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    libreoffice-impress libreoffice-core libreoffice-writer \
    default-jre-headless ffmpeg poppler-utils iverilog
  ok "System dependencies installed"
}

check_system_deps() {
  local missing=0
  if [[ $PPTX_ONLY -eq 0 ]]; then
    command -v soffice >/dev/null 2>&1 || command -v libreoffice >/dev/null 2>&1 || {
      warn "LibreOffice not found — PDF/video will be skipped (run with --install-deps)"
      missing=1
    }
    command -v ffmpeg >/dev/null 2>&1 || {
      warn "ffmpeg not found — video will be skipped (run with --install-deps)"
      missing=1
    }
    command -v pdftoppm >/dev/null 2>&1 || {
      warn "pdftoppm not found — video will be skipped (run with --install-deps)"
      missing=1
    }
  fi
  return $missing
}

log "Course: $COURSE_ROOT"
log "Skill:  $SKILL_ROOT"

if [[ $INSTALL_DEPS -eq 1 ]]; then
  install_system_deps
fi

log "Setting up Python skill venv..."
bash "$SKILL_SCRIPTS/setup.sh" | tail -3

if [[ $REGENERATE_EXAMPLES -eq 1 ]]; then
  log "Regenerating learning content + moduleN/EXAMPLES.md..."
  python3 "$SCRIPT_DIR/generate_learning_content.py"
  python3 "$SCRIPT_DIR/generate_examples_md.py"
fi

if [[ $REGENERATE -eq 1 ]]; then
  log "Regenerating outline.yaml (MODULE*.md + EXAMPLES.md)..."
  bash "$SCRIPT_DIR/regenerate_media_outlines.sh"
fi

if [[ ! -f "$COURSE_ROOT/media/module1/outline.yaml" ]]; then
  if [[ ! -f "$COURSE_ROOT/module1/EXAMPLES.md" ]]; then
    log "Generating EXAMPLES.md for all modules..."
    python3 "$SCRIPT_DIR/generate_examples_md.py"
  fi
  if [[ ! -f "$COURSE_ROOT/media/module1/outline.yaml" ]]; then
    log "Generating initial outlines..."
    bash "$SCRIPT_DIR/regenerate_media_outlines.sh"
  fi
fi

BUILD_ARGS=("$COURSE_ROOT")
[[ -n "$MODULES_FILTER" ]] && BUILD_ARGS+=(--module "$MODULES_FILTER")
[[ $PPTX_ONLY -eq 1 ]] && BUILD_ARGS+=(--pptx-only)
[[ $RUN_DEMOS -eq 1 ]] && BUILD_ARGS+=(--run-demos)
BUILD_ARGS+=(--seconds-per-slide "$SECONDS_PER_SLIDE")
BUILD_ARGS+=("${EXTRA_ARGS[@]}")

check_system_deps || true

log "Building media for all modules..."
bash "$SKILL_SCRIPTS/build_course_media.sh" "${BUILD_ARGS[@]}"

echo ""
log "Outputs:"
for f in "$COURSE_ROOT"/media/module*/slides.pptx; do
  [[ -f "$f" ]] && echo "  pptx: $f"
done
if [[ $PPTX_ONLY -eq 0 ]]; then
  for f in "$COURSE_ROOT"/media/module*/slides.pdf; do
    [[ -f "$f" ]] && echo "  pdf:  $f"
  done
  for f in "$COURSE_ROOT"/media/module*/video.mp4; do
    [[ -f "$f" ]] && echo "  mp4:  $f"
  done
fi

ok "Done. Review under: $COURSE_ROOT/media/"
