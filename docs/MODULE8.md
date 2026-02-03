# Module 8: Quick Reference and Course Summary

**Goal**: Provide a single quick reference and course summary for Verilog and SystemVerilog across IEEE versions (1364-1995 through 1800-2017).

## Overview

This module is a **reference and summary** for the version-centric Verilog/SystemVerilog course (Modules 1–7). It does not introduce new language features. It consolidates the version timeline, construct-by-standard tables, design-subset quick reference, migration quick reference, tool-support summary, and course map in one place. Use this module when you need to look up which standard introduced a construct, which subset to use for a project, or how to migrate between versions without re-reading the full module docs.

### Learning Resources

**Course Modules** (detailed content):
- **Module 1**: [MODULE1.md](MODULE1.md) — IEEE 1364-1995 (Verilog-95)
- **Module 2**: [MODULE2.md](MODULE2.md) — IEEE 1364-2001 (Verilog-2001)
- **Module 3**: [MODULE3.md](MODULE3.md) — IEEE 1364-2005 (Verilog-2005)
- **Module 4**: [MODULE4.md](MODULE4.md) — IEEE 1800-2005 (SystemVerilog design subset)
- **Module 5**: [MODULE5.md](MODULE5.md) — IEEE 1800-2009 and 1800-2012
- **Module 6**: [MODULE6.md](MODULE6.md) — IEEE 1800-2017 (current standard)
- **Module 7**: [MODULE7.md](MODULE7.md) — Version comparison and migration

**When to Use This Module**:
- When you need a quick “which standard has X?”
- When you need a one-page migration or version-selection reminder
- When you want a course map (what each module covers)
- When you finish the course and want a single reference to keep

## Topics Covered

### 1. Version Timeline (One Table)

| Standard     | Year | Role / focus                               | Module |
|-------------|------|--------------------------------------------|--------|
| IEEE 1364-1995 | 1995 | First Verilog standard; base language      | 1      |
| IEEE 1364-2001 | 2001 | Major Verilog update; ANSI, @*, generate, signed | 2 |
| IEEE 1364-2005 | 2005 | Last Verilog-only standard; clarifications, defparam deprecated | 3 |
| IEEE 1800-2005 | 2005 | First SystemVerilog; logic, always_comb/always_ff, interfaces, packages | 4 |
| IEEE 1800-2009 | 2009 | Interface refinements; type/assertion clarifications | 5 |
| IEEE 1800-2012 | 2012 | Checker; array/string methods; compilation unit | 5 |
| IEEE 1800-2017 | 2017 | Unified LRM (Verilog + SystemVerilog); current standard | 6 |

- **Verilog-only**: 1364-1995, 1364-2001, 1364-2005 (Module 1–3).
- **SystemVerilog**: 1800-2005 through 1800-2017 (Module 4–6).
- **Comparison and migration**: Module 7; **Quick reference**: this module (Module 8).

### 2. Construct-by-Standard Table

Use this table to see **when a construct was introduced** (or clarified). “Introduced” = first standard that defines it; “Clarified” = later standard refines it.

| Construct / topic           | 1364-1995 | 1364-2001 | 1364-2005 | 1800-2005 | 1800-2009 | 1800-2012 | 1800-2017 |
|----------------------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
| Non-ANSI ports             | ✓         |           |           |           |           |           |           |
| ANSI ports                 |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| wire, reg                  | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| logic                      |           |           |           | ✓         | ✓         | ✓         | ✓         |
| always @*                  |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| always_comb, always_ff     |           |           |           | ✓         | ✓         | ✓         | ✓         |
| generate                   |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| signed                     |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| localparam                 |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| defparam                   | ✓         | ✓         | deprecated| —         | —         | —         | —         |
| Multi-dim arrays           |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| interface, modport        |           |           |           | ✓         | ✓         | ✓         | ✓         |
| package, import           |           |           |           | ✓         | ✓         | ✓         | ✓         |
| unique case, priority case |           |           |           | ✓         | ✓         | ✓         | ✓         |
| Virtual interface          |           |           |           |           | ✓         | ✓         | ✓         |
| Checker                    |           |           |           |           |           | ✓         | ✓         |
| Unified LRM (1364+1800)    |           |           |           |           |           |           | ✓         |

- **Use**: To decide “minimum standard” for a construct or to check “is X in 1364-2005?”.

### 3. Design Subset Quick Reference

#### Verilog-only (1364 subset, e.g. 1364-2005)

- **Ports**: ANSI (2001+) or non-ANSI (1995).
- **Types**: wire, reg (no logic).
- **Combinational**: always @* or always @(inputs).
- **Sequential**: always @(posedge clk) with nonblocking <=.
- **No**: logic, always_comb/always_ff, interfaces, packages, unique/priority case, classes, SVA (unless added explicitly).
- **Use when**: Tools or IP require Verilog only.

#### SystemVerilog design (1800 subset)

- **Ports**: ANSI; logic typical.
- **Types**: logic (single driver), bit/int etc. where useful.
- **Combinational**: always_comb.
- **Sequential**: always_ff with nonblocking <=.
- **Connectivity**: interface + modport for reused bundles.
- **Shared code**: package + import.
- **Case**: unique case, priority case.
- **Use when**: Flow supports 1800; preferred for new RTL.

#### Synthesizable subset (both)

- **Do**: assign, always_comb or always @*, always_ff or always @(posedge clk), generate, parameter, localparam, single driver per net.
- **Avoid in RTL**: Delays (#), initial (except FPGA init per tool), fork/join, system tasks in RTL, defparam, multiple drivers (unless tri-state), unintended latches.
- **Check**: Tool manual for exact synthesizable subset and revision.

### 4. Migration Quick Reference

#### 1364-1995 → 1364-2001

1. Ports → ANSI. 2. Combinational → always @*. 3. Add generate/signed/localparam if needed. 4. Test.

#### 1364-2001/2005 → 1800 (design subset)

1. wire/reg → logic (single driver). 2. always @* → always_comb. 3. always @(posedge clk) → always_ff. 4. Optional: interfaces, packages, unique/priority case. 5. Remove defparam. 6. Test.

#### 1800-2005 → 1800-2009/2012/2017

1. Run regression (usually compatible). 2. Optionally adopt 2009/2012/2017 features where supported. 3. Set project standard (e.g. 1800-2017).

#### Rules of thumb

- One block (or one feature) at a time; test after each step.
- Keep external interface (ports or interface modport) unchanged during internal migration.
- One project standard and one subset; document in style guide.

**Full checklists**: See [MODULE7.md](MODULE7.md) (migration checklist, version-selection checklist).

### 5. Tool Support Summary

| Tool type   | Typical support (summary)                    | Check |
|------------|-----------------------------------------------|-------|
| Simulators | 1364-2001/2005; 1800 subset (design + verification) varies by tool | Vendor / release notes |
| Synthesis  | Synthesizable subset of 1364 and/or 1800; revision varies | Vendor manual |
| Lint       | 1364 and 1800; often selectable revision     | Vendor manual |
| Formal     | Assertions/checkers (1800); revision varies   | Vendor manual |

- **Icarus Verilog**: Primarily 1364-2001/2005; limited SystemVerilog.
- **Verilator**: 1364 and growing 1800 subset; see release notes for 1800-2017.
- **Commercial (VCS, Questa, Xcelium)**: Typically 1800-2005 through 1800-2017; confirm revision and options.

**Version selection**: Match project standard to simulator, synthesis, and IP support. See Module 7 version-selection checklist.

### 6. Course Map (Modules 1–8)

| Module | Title                    | Content summary                                      |
|--------|--------------------------|------------------------------------------------------|
| 1      | IEEE 1364-1995           | Verilog-95: modules, wire/reg, assign, always/initial, explicit sensitivity |
| 2      | IEEE 1364-2001           | ANSI ports, always @*, generate, signed, arrays, localparam |
| 3      | IEEE 1364-2005           | Clarifications, synthesizable subset, defparam deprecated, blocking/nonblocking |
| 4      | IEEE 1800-2005           | SystemVerilog design: logic, always_comb/always_ff, interfaces, packages, unique/priority case |
| 5      | IEEE 1800-2009/2012      | Interface refinements, checkers, array/string methods, assertions in context |
| 6      | IEEE 1800-2017           | Unified LRM, Verilog as subset of 1800, current standard |
| 7      | Version comparison and migration | Side-by-side comparison, migration patterns, tool support, checklists |
| 8      | Quick reference and course summary | This module: tables, quick reference, course map |

- **Learning path**: 1 → 2 → 3 → 4 → 5 → 6 (version order); then 7 (comparison and migration); use 8 as reference anytime.

### 7. Where to Go Next

- **Project**: Apply version selection and migration (Module 7); use this module (8) as quick reference.
- **LRM**: IEEE 1800-2017 for authoritative syntax and semantics; earlier standards for historical or tool-specific reference.
- **Tools**: Simulator, synthesis, and lint manuals for supported revision and synthesizable subset.
- **Related courses**: RTL design patterns, verification methodology (e.g. UVM), assertion writing (SVA), or tool-specific training.
- **New revisions**: When IEEE 1800-2024 (or later) is published, add a new module (same format as 1–6), update Module 7 (comparison and migration), and extend the tables in this module (8).

### 8. One-Page Cheat Sheet (Printable)

**Version timeline**: 1364-1995 → 1364-2001 → 1364-2005 → 1800-2005 → 1800-2009 → 1800-2012 → 1800-2017.

**Verilog-only (1364)**: wire/reg, always @* or @(inputs), always @(posedge clk), ANSI ports (2001+), generate, signed, localparam; no logic, no interfaces, no packages.

**SystemVerilog design (1800)**: logic, always_comb, always_ff, interface+modport, package+import, unique/priority case; single driver per logic.

**Migration 1364→1800**: wire/reg→logic, always @*→always_comb, always @(posedge clk)→always_ff, optional interface/package, remove defparam, test.

**Version selection**: Match tools and IP; state one revision (e.g. 1800-2017) and subset (e.g. design only); document in style guide.

**Full details**: Modules 1–7; IEEE 1800-2017 LRM.

## Examples

### Module 8 Examples (Reference Only)

**Reference files** (module8/docs/):

- **version_table.md**: The construct-by-standard table (Section 2) for search or script use.
- **migration_cheat_sheet.md**: The migration quick reference (Section 4) and one-page cheat sheet (Section 8).
- **course_map.md**: The course map (Section 6) with links to each module doc.

**Runnable reference examples** (module8/examples/; each prints a slice of the quick reference):

1. **quick_ref** — One-page cheat sheet (version timeline, subsets, migration, version selection).
2. **version_timeline** — Version timeline (standard, year, role, module).
3. **design_subset** — Verilog-only vs SystemVerilog design subset (ports, types, comb/seq, when to use).
4. **tool_support** — Tool support summary (simulators, synthesis, lint, formal; Icarus, Verilator, commercial).
5. **construct_lookup** — "Which standard has X?" for key constructs (logic, always_comb, interface, etc.).
6. **course_map** — Course map (Modules 1–8 with title and content summary).

No new DUT or testbench is required; use examples from Modules 1–7 for design/tests.

## Design Under Test (DUT)

See Modules 1–7 for DUTs. Module 8 does not add new DUTs; it references the side-by-side and migration examples in Module 7.

## Tests

See Modules 1–7 for tests. Module 8 does not add new tests; it references the version-comparison tests in Module 7.

## Learning Outcomes

By the end of this module (and the course), you should be able to:

- ✓ Use the version timeline and construct-by-standard table to look up “which standard has X?”
- ✓ Use the design-subset quick reference to choose Verilog-only vs SystemVerilog design
- ✓ Use the migration quick reference and Module 7 checklists for migration and version selection
- ✓ Use the course map to find which module covers a given standard or topic
- ✓ Use this module as a single reference after completing the course

## Key Concepts

### Version timeline

- **1364**: 1995 (base) → 2001 (ANSI, @*, generate, signed) → 2005 (last Verilog-only).
- **1800**: 2005 (first SystemVerilog) → 2009 → 2012 → 2017 (unified LRM).
- **New revisions**: Add new module; update Module 7 and this module (8).

### Construct by standard

- Use the construct-by-standard table to decide minimum revision for a construct or to check compatibility with a target (e.g. 1364-2005 only).

### Design subset

- **Verilog-only**: wire/reg, always @*, always @(posedge clk); no logic/interfaces/packages.
- **SystemVerilog design**: logic, always_comb/always_ff, interfaces, packages, unique/priority case.

### Migration and version selection

- **Migration**: Incremental; keep interface stable; test after each step; see Module 7.
- **Version selection**: One revision; match tools and IP; document subset; see Module 7.

## Exercises

1. **Lookup**: For each of logic, always_comb, interface, and unique case, use the construct-by-standard table to state the first standard that introduced it.
2. **Subset**: Write one paragraph that states “this project uses the Verilog-only subset of 1364-2005” or “this project uses the SystemVerilog design subset of 1800-2017”; list three constructs that are allowed and three that are not.
3. **Migration**: Using the migration quick reference only, list the steps to migrate one 1364-2005 module to 1800-2017 design subset (no implementation).
4. **Course map**: From the course map, name the module that covers (a) generate, (b) always_comb, (c) version comparison and migration, (d) quick reference.
5. **Cheat sheet**: Print or save the one-page cheat sheet (Section 8) and the version timeline (Section 1); use them when reading or writing RTL.

## Common Pitfalls and How to Avoid Them

1. **Assuming a construct is in an older standard**: Use the construct-by-standard table (Section 2) before using a feature in “1364-only” or “2005-only” code.
2. **Mixing subsets without a rule**: Define one project subset (Verilog-only or SystemVerilog design) and one revision; document in the style guide.
3. **Skipping regression after migration**: Use the migration quick reference and Module 7 checklist; run simulation (and synthesis) after every migration step.
4. **Forgetting tool support**: Match project standard to tool-supported revision and synthesizable subset; see Section 5 and Module 7.
5. **Treating this module as a replacement for Modules 1–7**: Use Module 8 as quick reference; refer to the relevant module (1–7) for full syntax, examples, and pitfalls.

## Next Steps

You have completed the version-centric Verilog and SystemVerilog course (Modules 1–8).

- **Use this module**: Keep Module 8 (and the one-page cheat sheet) as your quick reference for version timeline, construct table, design subset, and migration.
- **Apply**: In your next project, apply version selection (Module 7) and use the design-subset quick reference (this module) to stay consistent.
- **Reference**: Use Modules 1–7 for detailed coverage of each standard; use Module 8 when you need a fast lookup.
- **Extend**: When a new IEEE 1800 revision is published, add a new module, update Module 7, and extend the tables in this module.

## Additional Resources

### Module Documentation

- **Module 8 README**: [module8/README.md](../module8/README.md) (if present)
- **All modules**: [MODULE1.md](MODULE1.md) through [MODULE7.md](MODULE7.md)

### Reference Materials

- **IEEE Std 1800-2017**: Single LRM for Verilog and SystemVerilog; authoritative reference
- **Tool manuals**: Simulator, synthesis, and lint support for 1364 and 1800 revisions
- **Style guides**: Project-specific standard and subset (e.g. “1800-2017 design only”)

### Learning Path

1. **Completed**: Modules 1–8 (version-centric course).
2. **Reference**: Use Module 8 for quick lookup; use Modules 1–7 for depth.
3. **Apply**: Use version-selection and migration checklists (Module 7) and design-subset quick reference (this module) in real projects.
4. **Extend**: When new 1800 revisions appear, add a module and update Module 7 and Module 8.

---

For questions or issues, refer to the main project documentation, the IEEE 1800-2017 standard, or the appropriate module (1–7) for detailed coverage.
