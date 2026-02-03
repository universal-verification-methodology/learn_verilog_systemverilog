# Module 8: Quick Reference and Course Summary

This directory provides **quick reference** and **course summary** for the version-centric Verilog/SystemVerilog course (Modules 1–7). No new language features; use this module when you need a fast lookup.

## What you'll find here

- **Version timeline**: One table (1364-1995 through 1800-2017) and which module covers each standard.
- **Construct-by-standard table**: When each construct was introduced (ports, logic, always_comb, interface, etc.).
- **Design subset quick reference**: Verilog-only (1364) vs SystemVerilog design (1800); synthesizable do/avoid.
- **Migration quick reference**: 1995→2001, 1364→1800, 1800→1800; rules of thumb; link to Module 7 checklists.
- **Tool support summary**: Simulators, synthesis, lint, formal; Icarus, Verilator, commercial.
- **Course map**: Modules 1–8 with title and content summary; learning path.
- **One-page cheat sheet**: Printable version timeline, subsets, migration, version selection.

## Structure

```
module8/
├── docs/                        # Reference files (searchable / printable)
│   ├── version_table.md         # Construct-by-standard table
│   ├── migration_cheat_sheet.md # Migration quick ref + one-page cheat
│   └── course_map.md            # Course map with links to modules
├── examples/                    # Runnable reference (each dir has Makefile)
│   ├── quick_ref.sv             # One-page cheat sheet (run via examples/Makefile)
│   ├── version_timeline/        # Version timeline (standard, year, module)
│   ├── design_subset/           # Verilog-only vs SystemVerilog design subset
│   ├── tool_support/            # Tool support summary (sim, synth, lint, formal)
│   ├── construct_lookup/        # "Which standard has X?" (first standard)
│   ├── course_map/              # Course map (Modules 1–8 summary)
│   ├── migration_steps/         # Migration steps (1995→2001, 1364→1800, 1800→1800)
│   ├── synthesizable_subset/   # Synthesizable do/avoid (both 1364 and 1800)
│   ├── version_selection/       # Version selection (match tools, state revision, document)
│   ├── learning_path/           # Learning path and where to go next
│   └── pitfalls/                # Common pitfalls quick reference
└── README.md
```

## File map (topic → location)

| Topic / resource    | Path / key files |
|---------------------|------------------|
| Version table       | `docs/version_table.md` |
| Migration cheat sheet | `docs/migration_cheat_sheet.md` |
| Course map (doc)    | `docs/course_map.md` |
| One-page cheat sheet | `examples/quick_ref.sv` |
| Version timeline    | `examples/version_timeline/version_timeline.sv` |
| Design subset       | `examples/design_subset/design_subset.sv` |
| Tool support        | `examples/tool_support/tool_support.sv` |
| Construct lookup   | `examples/construct_lookup/construct_lookup.sv` |
| Course map (run)    | `examples/course_map/course_map.sv` |
| Migration steps     | `examples/migration_steps/migration_steps.sv` |
| Synthesizable subset | `examples/synthesizable_subset/synthesizable_subset.sv` |
| Version selection   | `examples/version_selection/version_selection.sv` |
| Learning path       | `examples/learning_path/learning_path.sv` |
| Pitfalls            | `examples/pitfalls/pitfalls.sv` |

## Quick start

**Full module guide**: [docs/MODULE8.md](../docs/MODULE8.md) — tables, quick reference, course map, one-page cheat sheet, exercises.

```bash
# From repo root: run module8 reference examples (e.g. one-page cheat sheet)
./scripts/module8.sh

# Or run examples from module8
cd module8/examples
make run

# Run a single reference example (e.g. version timeline)
cd module8/examples/version_timeline
make run
```

Each `examples/*/` directory has a `Makefile`; use `make run` (or `make` where applicable). The top-level `examples/Makefile` may run all or the main quick-ref.

## Reference files (docs/)

- **version_table.md** — When each construct was introduced (1364-1995 through 1800-2017).
- **migration_cheat_sheet.md** — Migration steps and one-page cheat sheet.
- **course_map.md** — What each module (1–8) covers; links to module docs.

## When to use Module 8

- Quick “which standard has X?” (construct-by-standard table).
- One-page migration or version-selection reminder.
- Course map (what each module covers).
- Single reference after completing the course.

## Learning path

1 → 2 → 3 → 4 → 5 → 6 (version order); then 7 (comparison and migration); use 8 as reference anytime.

## Tips

- **Bookmark this module**: Use Module 8 (and the one-page cheat sheet) for fast lookup instead of re-reading full module docs.
- **Check construct table first**: Before using a feature in “1364-only” or “2005-only” code, confirm it exists in that standard.
- **One subset, one revision**: Define one project subset (Verilog-only or SystemVerilog design) and one revision; document in the style guide.
- **After migration**: Use the migration quick reference and Module 7 checklist; run regression after every step.
- **Print or save**: Keep `docs/migration_cheat_sheet.md` and the version timeline table handy when reading or writing RTL.
