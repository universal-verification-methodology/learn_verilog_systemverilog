#!/usr/bin/env python3
"""Patch generated media/moduleN/outline.yaml for this Verilog course.

The shared outline generator assumes Unix-style ``moduleN.sh --check``.
This course uses ``moduleN.sh`` without ``--check``; patch the self-check
demo to verify the Icarus Verilog toolchain instead.
"""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Any

import yaml

TOOLCHAIN_CMD = (
    'command -v iverilog >/dev/null && '
    'echo "Toolchain ready: $(iverilog -V 2>&1 | head -1)"'
)
TOOLCHAIN_EXPECT = "Icarus Verilog"


def patch_slides(slides: list[dict[str, Any]], module: int) -> int:
    changed = 0
    out: list[dict[str, Any]] = []
    for slide in slides:
        if slide.get("type") == "demo" and "self-check" in slide.get("title", "").lower():
            slide = {
                **slide,
                "title": f"Module {module} toolchain check",
                "command": TOOLCHAIN_CMD,
                "expect_stdout_contains": TOOLCHAIN_EXPECT,
                "notes": "Requires iverilog on PATH (apt install iverilog).",
            }
            changed += 1
        if slide.get("type") == "code" and slide.get("title") == "Exercise scaffold":
            changed += 1
            continue
        out.append(slide)
    slides[:] = out
    return changed


def patch_manifest(manifest_path: Path, module: int) -> None:
    if not manifest_path.is_file():
        return
    data = yaml.safe_load(manifest_path.read_text(encoding="utf-8")) or {}
    assets: list[dict[str, Any]] = data.get("assets") or []
    key = f"module{module}_check"
    for asset in assets:
        if asset.get("id") == key:
            asset["capture_command"] = TOOLCHAIN_CMD
            asset["expect_stdout_contains"] = TOOLCHAIN_EXPECT
            asset["description"] = "Verify iverilog is installed"
            break
    else:
        assets.append(
            {
                "id": key,
                "path": f"assets/screenshots/module{module}_check.png",
                "source": "generated",
                "license": "CC-BY-4.0",
                "capture_command": TOOLCHAIN_CMD,
                "expect_stdout_contains": TOOLCHAIN_EXPECT,
                "description": "Verify iverilog is installed",
            }
        )
    data["assets"] = assets
    manifest_path.write_text(
        yaml.dump(data, sort_keys=False, allow_unicode=True),
        encoding="utf-8",
    )


def patch_module(media_dir: Path) -> int:
    outline_path = media_dir / "outline.yaml"
    if not outline_path.is_file():
        return 0
    outline = yaml.safe_load(outline_path.read_text(encoding="utf-8")) or {}
    module = int(outline.get("module") or media_dir.name.replace("module", ""))
    slides: list[dict[str, Any]] = outline.get("slides") or []
    changed = patch_slides(slides, module)
    outline["slides"] = slides
    outline_path.write_text(
        yaml.dump(outline, sort_keys=False, allow_unicode=True),
        encoding="utf-8",
    )
    patch_manifest(media_dir / "assets" / "manifest.yaml", module)
    return max(changed, 1)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--course-root",
        type=Path,
        default=Path(__file__).resolve().parent.parent,
    )
    args = parser.parse_args()
    course_root = args.course_root.resolve()
    total = 0
    for media_dir in sorted((course_root / "media").glob("module*")):
        n = patch_module(media_dir)
        if n:
            print(f"OK: patched {media_dir.name} ({n} change(s))")
            total += n
    if total == 0:
        print("No outlines patched (run generate_outline_from_module.py first)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
