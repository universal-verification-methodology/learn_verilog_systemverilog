#!/usr/bin/env python3
"""Generate moduleN/EXAMPLES.md from docs/MODULEN.md and examples/ directories.

The module-to-slides-video outline generator expects EXAMPLES.md sections:

  ## 1. Title (`folder/`)

  ```bash
  cd moduleN/examples/folder && make clean && make run
  ```

Usage (from repo root):

  python3 scripts/generate_examples_md.py
  python3 scripts/generate_examples_md.py --module 3
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

EXAMPLE_LINE = re.compile(
    r"^\s*(\d+)\.\s+\*\*(.+?)\*\*\s+\(`(?:examples/)?([^`/]+)/?`\)",
    re.MULTILINE,
)


def parse_module_examples(doc_path: Path) -> list[tuple[int, str, str]]:
    """Return (number, title, folder) from MODULE*.md numbered example list."""
    text = doc_path.read_text(encoding="utf-8")
    block_m = re.search(
        r"### Module \d+ Examples[^\n]*\n(.*?)(?=\n## |\Z)",
        text,
        re.DOTALL,
    )
    if not block_m:
        block_m = re.search(
            r"### Module \d+ Examples[^\n]*\n(.*?)(?=\n### |\n## |\Z)",
            text,
            re.DOTALL,
        )
    block = block_m.group(1) if block_m else text
    items: list[tuple[int, str, str]] = []
    for m in EXAMPLE_LINE.finditer(block):
        items.append((int(m.group(1)), m.group(2).strip(), m.group(3).strip()))
    return items


def discover_example_dirs(module_dir: Path) -> list[str]:
    ex_root = module_dir / "examples"
    if not ex_root.is_dir():
        return []
    dirs: list[str] = []
    for child in sorted(ex_root.iterdir()):
        if not child.is_dir():
            continue
        if (child / "Makefile").is_file():
            dirs.append(child.name)
    return dirs


def folder_title(name: str) -> str:
    return name.replace("_", " ").strip().title()


def render_examples_md(
    module: int,
    items: list[tuple[int, str, str]],
) -> str:
    title = f"Module {module} Examples"
    lines = [
        f"# {title}",
        "",
        f"Hands-on **Icarus Verilog** demos for Module {module}. "
        "Run from the course repo root unless noted.",
        "",
        "---",
        "",
    ]
    for num, ex_title, folder in items:
        lines.extend(
            [
                f"## {num}. {ex_title} (`{folder}/`)",
                "",
                f"Build and simulate: `module{module}/examples/{folder}/`.",
                "",
                "**Try these** (from repo root):",
                "",
                "```bash",
                f"cd module{module}/examples/{folder}",
                "make clean && make run",
                "```",
                "",
                "---",
                "",
            ]
        )
    return "\n".join(lines).rstrip() + "\n"


def write_module(course_root: Path, module: int, dry_run: bool) -> int:
    doc_path = course_root / "docs" / f"MODULE{module}.md"
    module_dir = course_root / f"module{module}"
    out_path = module_dir / "EXAMPLES.md"

    if not doc_path.is_file():
        print(f"SKIP: missing {doc_path}")
        return 1

    parsed = parse_module_examples(doc_path)
    if parsed:
        items = parsed
    else:
        dirs = discover_example_dirs(module_dir)
        items = [(i + 1, folder_title(d), d) for i, d in enumerate(dirs)]

    if not items:
        print(f"WARN: module {module}: no examples found")
        return 0

    content = render_examples_md(module, items)
    if dry_run:
        print(f"module {module}: {len(items)} examples -> {out_path}")
        return 0

    out_path.write_text(content, encoding="utf-8")
    print(f"OK: {out_path} ({len(items)} examples)")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--course-root",
        type=Path,
        default=Path(__file__).resolve().parent.parent,
    )
    parser.add_argument("--module", type=int, default=0, help="Single module (0 = all)")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    course_root = args.course_root.resolve()
    modules = (
        [args.module]
        if args.module
        else sorted(
            int(p.name.replace("MODULE", "").replace(".md", ""))
            for p in (course_root / "docs").glob("MODULE*.md")
        )
    )
    rc = 0
    for mod in modules:
        if write_module(course_root, mod, args.dry_run) != 0:
            rc = 1
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
