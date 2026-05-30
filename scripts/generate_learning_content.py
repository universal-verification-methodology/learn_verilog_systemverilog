#!/usr/bin/env python3
"""Add learner guides to MODULE*.md and generate moduleN/CHECKLIST.md.

Inserts ``## How to Learn This Module`` when missing and builds a self-assessment
checklist from Learning Outcomes, Exercises, and Assessment sections.

Usage (from repo root):

  python3 scripts/generate_learning_content.py
  python3 scripts/generate_learning_content.py --module 2 --dry-run
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

HOW_TO_LEARN_HEADING = "## How to Learn This Module"
RUNNING_HEADING_RE = re.compile(r"^## Running Module \d+\s*$", re.MULTILINE)


def _section(text: str, start: str, stops: tuple[str, ...]) -> str:
    pos = text.find(start)
    if pos < 0:
        return ""
    start_pos = pos + len(start)
    end = len(text)
    for stop in stops:
        stop_pos = text.find(stop, start_pos)
        if stop_pos >= 0:
            end = min(end, stop_pos)
    return text[start_pos:end]


def _clean_bullets(raw: str) -> list[str]:
    out: list[str] = []
    for line in raw.splitlines():
        m = re.match(r"^\s*-\s+(?:\[[ x]\]\s+)?(.+)$", line)
        if not m:
            continue
        item = re.sub(r"\*\*([^*]+)\*\*", r"\1", m.group(1).strip())
        item = re.sub(r"✓\s*", "", item)
        if item and len(item) < 220:
            out.append(item)
    return out


def _numbered_exercises(raw: str) -> list[str]:
    out: list[str] = []
    for m in re.finditer(r"^\d+\.\s+\*\*(.+?)\*\*", raw, re.MULTILINE):
        out.append(m.group(1).strip())
    return out


def how_to_learn_block(module: int, title_hint: str) -> str:
    """Return markdown for the How to Learn section."""
    steps = [
        f"**Skim this document** — Goal, Overview, and Topics Covered set the "
        f"IEEE scope for Module {module}.",
        "**Study design architecture** — See how DUTs, examples, and testbenches "
        f"fit together under `module{module}/`.",
        f"**Work through labs in order** — Open `module{module}/EXAMPLES.md` and "
        "run each `make clean && make run` from the repo root.",
        f"**Run the full module script** — `./scripts/module{module}.sh` from "
        "the repo root to simulate all examples and tests.",
        "**Complete the exercises** — Try each exercise in this document before "
        "reading solutions or peeking at reference RTL.",
    ]
    if module == 7:
        steps.append(
            "**Compare side-by-side** — Open 1364 and 1800 versions of the "
            "same design and note port style, types, and procedural blocks.",
        )
    elif module == 8:
        steps.append(
            "**Use as reference** — Module 8 summarizes the full course; "
            "run examples to print quick-reference slices, not to learn new RTL.",
        )
    steps.extend(
        [
            "**Review Common Pitfalls** — Can you explain each mistake and the fix?",
            f"**Self-check** — Use `module{module}/CHECKLIST.md` before starting "
            "the next module.",
        ],
    )
    numbered = "\n".join(f"{i}. {step}" for i, step in enumerate(steps, start=1))
    return (
        f"{HOW_TO_LEARN_HEADING}\n\n"
        f"Follow this path to learn **{title_hint}** in order:\n\n"
        f"{numbered}\n\n"
    )


def repair_running_section(text: str) -> str:
    """Move orphaned 'From the repo root' bullets back under Running Module N."""
    m = re.search(
        r"^(## Running Module \d+\s*\n\n)"
        r"^(## How to Learn This Module\s*\n.+?)"
        r"^(From the repo root:.+?)"
        r"^(## .+?\n)",
        text,
        re.MULTILINE | re.DOTALL,
    )
    if not m:
        return text
    replacement = f"{m.group(1)}{m.group(3)}\n\n{m.group(2)}{m.group(4)}"
    return text[: m.start()] + replacement + text[m.end() :]


def insert_how_to_learn(text: str, module: int, title_hint: str) -> tuple[str, bool]:
    """Insert How to Learn section after Running Module N if not present."""
    original = text
    text = repair_running_section(text)
    changed = text != original
    if HOW_TO_LEARN_HEADING in text:
        return text, changed
    block = how_to_learn_block(module, title_hint)
    m = RUNNING_HEADING_RE.search(text)
    if m:
        rest = text[m.end() :]
        next_sec = re.search(r"^## ", rest, re.MULTILINE)
        insert_at = m.end() + next_sec.start() if next_sec else len(text)
    else:
        overview = text.find("## Overview")
        if overview < 0:
            return text + "\n" + block, True
        return text[:overview] + block + text[overview:], True
    while insert_at < len(text) and text[insert_at] in "\n\r":
        insert_at += 1
    return text[:insert_at] + "\n\n" + block + text[insert_at:], True


def build_checklist(module: int, doc_text: str, title: str) -> str:
    """Build CHECKLIST.md from MODULE doc sections."""
    outcomes = _clean_bullets(
        _section(
            doc_text,
            "## Learning Outcomes",
            ("## Key Concepts", "## Exercises", "## Common Pitfalls", "## Next Steps", "---"),
        ),
    )
    exercises = _numbered_exercises(
        _section(doc_text, "## Exercises", ("## Assessment", "## Common Pitfalls", "## Next Steps", "---")),
    )
    assessment = _clean_bullets(
        _section(doc_text, "## Assessment", ("## Next Steps", "## Additional Resources", "---")),
    )

    lines = [
        f"# Module {module} — Learning checklist",
        "",
        f"Use this list to confirm you are ready to leave **{title}**.",
        "",
        "## Concepts I can explain",
        "",
    ]
    if outcomes:
        for item in outcomes:
            lines.append(f"- [ ] {item}")
    else:
        lines.append(f"- [ ] I completed all labs in `module{module}/EXAMPLES.md`")
    lines.extend(["", "## Labs I ran successfully", ""])
    lines.append(f"- [ ] `./scripts/module{module}.sh` completed without errors")
    lines.append(f"- [ ] Each example in `module{module}/EXAMPLES.md` — `make run` passed")
    lines.extend(["", "## Exercises I attempted", ""])
    if exercises:
        for item in exercises[:8]:
            lines.append(f"- [ ] {item}")
    else:
        lines.append(f"- [ ] I worked through the exercises in `docs/MODULE{module}.md`")
    if assessment:
        lines.extend(["", "## Assessment", ""])
        for item in assessment[:6]:
            lines.append(f"- [ ] {item}")
    lines.extend(
        [
            "",
            "## Pitfalls I can avoid",
            "",
            f"- [ ] I reviewed **Common Pitfalls** in `docs/MODULE{module}.md`",
            "",
            "## Ready for next module",
            "",
            f"- [ ] All sections above checked — proceed to the next module in the course.",
            "",
        ]
    )
    return "\n".join(lines)


def process_module(course_root: Path, module: int, dry_run: bool) -> int:
    doc_path = course_root / "docs" / f"MODULE{module}.md"
    module_dir = course_root / f"module{module}"
    checklist_path = module_dir / "CHECKLIST.md"

    if not doc_path.is_file():
        print(f"SKIP: missing {doc_path}")
        return 1

    text = doc_path.read_text(encoding="utf-8")
    title_m = re.search(r"^#\s+Module\s+\d+:\s+(.+)$", text, re.MULTILINE)
    title = title_m.group(1).strip() if title_m else f"Module {module}"

    new_text, doc_changed = insert_how_to_learn(text, module, title)
    repaired = repair_running_section(new_text)
    if repaired != new_text:
        new_text = repaired
        doc_changed = True
    checklist = build_checklist(module, new_text, title)

    if dry_run:
        print(
            f"module {module}: doc={'update' if doc_changed else 'ok'}, "
            f"checklist -> {checklist_path}",
        )
        return 0

    if doc_changed:
        doc_path.write_text(new_text, encoding="utf-8")
        print(f"OK: updated {doc_path}")
    else:
        print(f"OK: {doc_path} (no doc changes)")

    checklist_path.write_text(checklist, encoding="utf-8")
    print(f"OK: {checklist_path}")
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
        if process_module(course_root, mod, args.dry_run) != 0:
            rc = 1
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
