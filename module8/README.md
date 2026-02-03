# Module 8: Quick Reference and Course Summary

This directory provides **quick reference** and **course summary** for the version-centric Verilog/SystemVerilog course (Modules 1–7). No new language features; use this module when you need a fast lookup.

## Structure

```
module8/
├── docs/                        # Reference files (searchable / printable)
│   ├── version_table.md         # Construct-by-standard table
│   ├── migration_cheat_sheet.md # Migration quick ref + one-page cheat
│   └── course_map.md            # Course map with links to modules
├── examples/
│   ├── quick_ref.sv             # One-page cheat sheet
│   ├── version_timeline/        # Version timeline (standard, year, module)
│   ├── design_subset/           # Verilog-only vs SystemVerilog design subset
│   ├── tool_support/            # Tool support summary (sim, synth, lint, formal)
│   ├── construct_lookup/        # "Which standard has X?" (first standard)
│   ├── course_map/              # Course map (Modules 1-8 summary)
│   ├── migration_steps/         # Migration steps (1995->2001, 1364->1800, 1800->1800)
│   ├── synthesizable_subset/    # Synthesizable do/avoid (both 1364 and 1800)
│   ├── version_selection/       # Version selection (match tools, state revision, document)
│   ├── learning_path/           # Learning path and where to go next
│   └── pitfalls/                # Common pitfalls quick reference
└── README.md
```

## Quick Start

**Full documentation**: [docs/MODULE8.md](../docs/MODULE8.md)

```bash
# Print one-page cheat sheet (from repo root)
./scripts/module8.sh

# Or run the quick-ref example directly
cd module8/examples && make run
```

## Reference Files

- **docs/version_table.md** — When each construct was introduced (1364-1995 through 1800-2017).
- **docs/migration_cheat_sheet.md** — Migration steps and one-page cheat sheet.
- **docs/course_map.md** — What each module (1–8) covers; links to module docs.

## When to Use Module 8

- Quick “which standard has X?”
- One-page migration or version-selection reminder
- Course map (what each module covers)
- Single reference after completing the course

## Learning Path

1 → 2 → 3 → 4 → 5 → 6 (version order); then 7 (comparison and migration); use 8 as reference anytime.
