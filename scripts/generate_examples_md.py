#!/usr/bin/env python3
"""Generate moduleN/EXAMPLES.md from docs/MODULEN.md and examples/ directories.

Produces learner-oriented lab sections with "What you'll learn", run commands,
and expected outcomes for the module-to-slides-video pipeline.

Usage (from repo root):

  python3 scripts/generate_examples_md.py
  python3 scripts/generate_examples_md.py --module 3
"""

from __future__ import annotations

import argparse
import re
from dataclasses import dataclass, field
from pathlib import Path

EXAMPLE_HEADER = re.compile(
    r"^(\d+)\.\s+\*\*(.+?)\*\*"
    r"(?:\s+\(`(?:examples/)?([^`)]+)`\))?"
    r"(?:\s+—|\s+-)\s*(.*)?$",
    re.MULTILINE,
)
MODULE_EXAMPLES_BLOCK = re.compile(
    r"### Module \d+ Examples[^\n]*\n(.*?)(?=\n## |\Z)",
    re.DOTALL,
)


@dataclass
class ParsedExample:
    """One hands-on lab extracted from MODULE*.md."""

    number: int
    title: str
    folder: str
    learn_bullets: list[str] = field(default_factory=list)


def _clean_bullet(text: str) -> str:
    item = re.sub(r"\*\*([^*]+)\*\*", r"\1", text.strip())
    item = re.sub(r"`([^`]+)`", r"\1", item)
    return item


def resolve_example_folder(
    module_dir: Path,
    slug: str,
    backtick_folder: str | None,
) -> str:
    """Map MODULE*.md example entry to an existing examples/ directory name."""
    ex_root = module_dir / "examples"
    if backtick_folder:
        cand = backtick_folder.strip().rstrip("/").strip('"').split("/")[0]
        if cand in ("examples", ".") and (ex_root / "Makefile").is_file():
            return "quick_ref"
        if cand and (ex_root / cand).is_dir():
            return cand

    key = slug.strip().lower().replace(" ", "_").replace("-", "_")
    if key == "quick_ref" and (ex_root / "Makefile").is_file():
        return "quick_ref"
    if key and (ex_root / key).is_dir():
        return key

    snake = re.sub(r"[^a-z0-9_]+", "_", key).strip("_")
    if snake and (ex_root / snake).is_dir():
        return snake
    return key or slug


def example_run_directory(module: int, folder: str) -> str:
    """Return repo-relative path for ``cd`` in lab commands."""
    if folder == "quick_ref":
        return f"module{module}/examples"
    return f"module{module}/examples/{folder}"


def _parse_example_body(body: str) -> list[str]:
    """Collect sub-bullets and Key Concepts lines under one example item."""
    bullets: list[str] = []
    for line in body.splitlines():
        m = re.match(r"^\s+-\s+(.+)$", line)
        if not m:
            continue
        raw = m.group(1).strip()
        if raw.startswith("**Key Concepts**:"):
            concept = raw.split(":", 1)[-1].strip()
            if concept:
                bullets.append(concept)
            continue
        if raw.startswith("**Example**:"):
            continue
        cleaned = _clean_bullet(raw)
        if cleaned and len(cleaned) < 200:
            bullets.append(cleaned)
    return bullets[:6]


def parse_module_examples(doc_path: Path, module_dir: Path) -> list[ParsedExample]:
    """Return parsed examples from MODULE*.md numbered example list."""
    text = doc_path.read_text(encoding="utf-8")
    block_m = MODULE_EXAMPLES_BLOCK.search(text)
    block = block_m.group(1) if block_m else ""
    if not block.strip():
        return []

    examples: list[ParsedExample] = []
    headers = list(EXAMPLE_HEADER.finditer(block))
    for i, hm in enumerate(headers):
        num = int(hm.group(1))
        slug = hm.group(2).strip()
        backtick = hm.group(3).strip() if hm.group(3) else None
        description = (hm.group(4) or "").strip()
        folder = resolve_example_folder(module_dir, slug, backtick)
        title = description.rstrip(".") if description else slug.replace("_", " ").title()
        start = hm.end()
        end = headers[i + 1].start() if i + 1 < len(headers) else len(block)
        learn_bullets = _parse_example_body(block[start:end])
        examples.append(ParsedExample(num, title, folder, learn_bullets))
    return examples


def discover_example_dirs(module_dir: Path) -> list[ParsedExample]:
    """Fallback: enumerate Makefile-backed example folders."""
    ex_root = module_dir / "examples"
    if not ex_root.is_dir():
        return []
    items: list[ParsedExample] = []
    for idx, child in enumerate(sorted(ex_root.iterdir()), start=1):
        if not child.is_dir():
            continue
        if not (child / "Makefile").is_file():
            continue
        title = child.name.replace("_", " ").strip().title()
        items.append(ParsedExample(idx, title, child.name, []))
    return items


def render_examples_md(module: int, examples: list[ParsedExample]) -> str:
    """Render EXAMPLES.md with learner-facing sections."""
    lines = [
        f"# Module {module} — Hands-on labs",
        "",
        f"Generated from `docs/MODULE{module}.md` for slides, PDF, and video.",
        "Run commands from the **course repository root** unless noted.",
        "",
        f"**Before you start:** Read `docs/MODULE{module}.md` → "
        f"**How to Learn This Module**, then work through each lab in order.",
        "",
    ]
    for ex in examples:
        lines.extend(
            [
                f"## {ex.number}. {ex.title} (`{ex.folder}/`)",
                "",
                f"**Folder:** `module{module}/examples/{ex.folder}/`",
                "",
            ]
        )
        if ex.learn_bullets:
            lines.append("**What you'll learn:**")
            for bullet in ex.learn_bullets:
                lines.append(f"- {bullet}")
            lines.append("")
        lines.extend(
            [
                "**Run:**",
                "",
                "```bash",
                f"cd {example_run_directory(module, ex.folder)}",
                "make clean && make run",
                "```",
                "",
                "**You should see:** Simulation completes without errors; "
                "check `$display` output or PASS messages in the log.",
                "",
                f"**Go deeper:** Full context in `docs/MODULE{module}.md` "
                f"and RTL under `module{module}/examples/{ex.folder}/`.",
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

    parsed = parse_module_examples(doc_path, module_dir)
    if not parsed:
        parsed = discover_example_dirs(module_dir)

    if not parsed:
        print(f"WARN: module {module}: no examples found")
        return 0

    content = render_examples_md(module, parsed)
    if dry_run:
        print(f"module {module}: {len(parsed)} examples -> {out_path}")
        return 0

    out_path.write_text(content, encoding="utf-8")
    print(f"OK: {out_path} ({len(parsed)} examples)")
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
        if not (course_root / f"module{mod}").is_dir():
            continue
        if write_module(course_root, mod, args.dry_run) != 0:
            rc = 1
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
