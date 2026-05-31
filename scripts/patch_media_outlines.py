#!/usr/bin/env python3
"""Patch generated media/moduleN/outline.yaml for this Verilog course.

The shared outline generator assumes Unix-style ``moduleN.sh --check``.
This course uses ``moduleN.sh`` without ``--check``; patch the self-check
demo to verify the Icarus Verilog toolchain instead, then refresh script.md
for per-slide narration.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path
from typing import Any

import yaml

SKILL_SCRIPTS = Path.home() / ".cursor/skills/module-to-slides-video/scripts"

TOOLCHAIN_CMD = (
    'command -v iverilog >/dev/null && '
    'echo "Toolchain ready: $(iverilog -V 2>&1 | head -1)"'
)
TOOLCHAIN_EXPECT = "Icarus Verilog"
MAX_BULLET_CHARS = 140


def _truncate_bullet(text: str, limit: int = MAX_BULLET_CHARS) -> str:
    """Shorten slide bullets so verify_media and pptx layout stay within limits."""
    s = str(text).strip()
    if len(s) <= limit:
        return s
    cut = limit - 3
    chunk = s[:cut]
    if " " in chunk:
        chunk = chunk.rsplit(" ", 1)[0]
    return chunk.rstrip(".,;:") + "..."


def patch_long_bullets(slides: list[dict[str, Any]]) -> int:
    """Truncate bullets/two-column text that exceeds MAX_BULLET_CHARS."""
    changed = 0
    for slide in slides:
        stype = slide.get("type")
        if stype == "bullets":
            bullets = slide.get("bullets")
            if isinstance(bullets, list):
                trimmed = [_truncate_bullet(b) for b in bullets]
                if trimmed != bullets:
                    slide["bullets"] = trimmed
                    changed += 1
        elif stype == "two_column":
            left = slide.get("left")
            if isinstance(left, list):
                trimmed = [_truncate_bullet(b) for b in left]
                if trimmed != left:
                    slide["left"] = trimmed
                    changed += 1
        cap = slide.get("caption")
        if cap and len(str(cap)) > MAX_BULLET_CHARS:
            slide["caption"] = _truncate_bullet(str(cap))
            changed += 1
    return changed


def patch_demo_slides(
    slides: list[dict[str, Any]],
    module: int,
    course_root: Path,
) -> int:
    """Fix demo commands/screenshots with invalid paths or unsafe filename characters."""
    changed = 0
    for slide in slides:
        if slide.get("type") != "demo":
            continue
        command = str(slide.get("command", ""))
        screenshot = str(slide.get("screenshot", ""))
        if '"' in command or '"' in screenshot or "examples/One-page" in command:
            title = str(slide.get("title", ""))
            match = re.search(r"Example\s+(\d+)", title, re.IGNORECASE)
            ex_num = int(match.group(1)) if match else 0
            examples_path = course_root / f"module{module}" / "EXAMPLES.md"
            if examples_path.is_file() and ex_num:
                text = examples_path.read_text(encoding="utf-8")
                sec = re.search(
                    rf"##\s+{ex_num}\.\s+.+?\n+```bash\s*\n(.*?)```",
                    text,
                    re.DOTALL,
                )
                if sec:
                    lines = [
                        ln.strip()
                        for ln in sec.group(1).splitlines()
                        if ln.strip() and not ln.strip().startswith("#")
                    ]
                    if lines:
                        slide["command"] = " && ".join(lines)
                        folder_m = re.search(
                            rf"##\s+{ex_num}\.\s+.+?\(`([^`]+)/`\)",
                            text,
                        )
                        folder = (
                            folder_m.group(1).strip().rstrip("/")
                            if folder_m
                            else f"ex{ex_num:02d}"
                        )
                        folder = re.sub(r"[^a-zA-Z0-9_]+", "_", folder).strip("_")
                        slide["screenshot"] = (
                            f"assets/screenshots/ex{ex_num:02d}_{folder}.png"
                        )
                        changed += 1
        elif '"' in screenshot:
            slide["screenshot"] = screenshot.replace('"', "")
            changed += 1
    return changed


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


def patch_module(media_dir: Path, course_root: Path) -> int:
    outline_path = media_dir / "outline.yaml"
    if not outline_path.is_file():
        return 0
    outline = yaml.safe_load(outline_path.read_text(encoding="utf-8")) or {}
    module = int(outline.get("module") or media_dir.name.replace("module", ""))
    slides: list[dict[str, Any]] = outline.get("slides") or []
    changed = patch_slides(slides, module)
    changed += patch_long_bullets(slides)
    changed += patch_demo_slides(slides, module, course_root)
    outline["slides"] = slides
    outline_path.write_text(
        yaml.dump(outline, sort_keys=False, allow_unicode=True),
        encoding="utf-8",
    )
    patch_manifest(media_dir / "assets" / "manifest.yaml", module)
    refresh_script(course_root, module)
    return max(changed, 1)


def refresh_script(course_root: Path, module: int) -> None:
    """Regenerate script.md with per-slide narration from patched outline."""
    gen = SKILL_SCRIPTS / "generate_outline_from_module.py"
    if not gen.is_file():
        return
    if str(SKILL_SCRIPTS) not in sys.path:
        sys.path.insert(0, str(SKILL_SCRIPTS))
    from generate_outline_from_module import refresh_scripts_for_module

    refresh_scripts_for_module(course_root, module)


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
        n = patch_module(media_dir, course_root)
        if n:
            print(f"OK: patched {media_dir.name} ({n} change(s))")
            total += n
    if total == 0:
        print("No outlines patched (run generate_outline_from_module.py first)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
