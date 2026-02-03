# Module 7: Version Comparison and Migration

**Goal**: Compare Verilog and SystemVerilog across IEEE versions side-by-side, plan migration between standards, and choose the right version for your project and tools.

**Prerequisites**: Modules 1–6 — you should have completed the version-centric path (1364-1995 through 1800-2017) and understand each revision’s design subset.

**Estimated time**: 4–6 hours (examples + exercises + checklists). No new language features; focus on comparison and migration practice.

## Table of Contents

- [Overview](#overview)
- [Topics Covered](#topics-covered)
- [Examples](#examples)
- [Design Under Test (DUT)](#design-under-test-dut)
- [Tests](#tests)
- [Learning Outcomes](#learning-outcomes)
- [Key Concepts](#key-concepts)
- [Exercises](#exercises)
- [Common Pitfalls](#common-pitfalls-and-how-to-avoid-them)
- [Next Steps](#next-steps)
- [Additional Resources](#additional-resources)

## Overview

This module ties together Modules 1–6 by comparing the same design across standards (1364-1995 through 1800-2017), outlining migration steps between versions, and providing checklists for choosing a standard and for migrating RTL. You'll learn how to read and write RTL that targets a specific IEEE revision, how to migrate legacy Verilog to SystemVerilog (or between revisions), and how tool support and project constraints influence version selection. This module has no new language features; it is about applying the version-centric knowledge from Modules 1–6 in practice.

### Learning Resources

**Course Modules**:
- **Module 1**: IEEE 1364-1995 — Base Verilog
- **Module 2**: IEEE 1364-2001 — ANSI, @*, generate, signed, arrays
- **Module 3**: IEEE 1364-2005 — Clarifications, synthesizable subset, defparam deprecated
- **Module 4**: IEEE 1800-2005 — SystemVerilog design (logic, always_comb/always_ff, interfaces, packages)
- **Module 5**: IEEE 1800-2009/2012 — Interface refinements, checkers, array/string methods
- **Module 6**: IEEE 1800-2017 — Unified LRM, current standard

**When to Use This Module**:
- When deciding which IEEE version to adopt for a new project
- When migrating existing RTL from one standard to another
- When reading or maintaining code that targets a specific revision
- When evaluating tool support for different standards

## Topics Covered

### 1. Side-by-Side Comparison: Same Design Across Versions

Comparing the same small design (e.g. a 2:1 mux, a counter, or a small FSM) across standards shows exactly what changes from 1995 to 2017.

#### Example: 2:1 Multiplexer

**1364-1995 (Module 1):**
```verilog
module mux2(a, b, sel, y);
    input  a, b, sel;
    output y;
    wire a, b, sel;
    reg  y;
    always @(a or b or sel)
        y = sel ? b : a;
endmodule
```

**1364-2001 (Module 2):**
```verilog
module mux2 (
    input  wire a, b, sel,
    output reg  y
);
    always @* y = sel ? b : a;
endmodule
```

**1364-2005 (Module 3):** Same as 2001; add nonblocking/blocking discipline and avoid defparam if applicable.

**1800-2005 (Module 4):**
```systemverilog
module mux2 (
    input  logic a, b, sel,
    output logic y
);
    always_comb y = sel ? b : a;
endmodule
```

**1800-2017 (Module 6):** Same as 1800-2005 for this simple case; 2017 is the reference LRM.

#### What Changes Across Versions

| Aspect        | 1995     | 2001     | 2005 (1364) | 1800-2005 | 1800-2017 |
|---------------|----------|----------|-------------|-----------|-----------|
| Port style    | Non-ANSI | ANSI     | ANSI        | ANSI      | ANSI      |
| Type          | wire/reg | wire/reg | wire/reg    | logic     | logic     |
| Combinational | @(a or b or sel) | @*   | @*          | always_comb | always_comb |
| Driver rule   | reg for procedural | same | same    | single driver for logic | same |

- **Takeaway**: Same behavior; syntax and intent become clearer and tool-checked as you move to 2001 then 1800.

**Example**: `module7/examples/side_by_side/mux2_versions/` (mux2_1364.v vs mux2_1800.sv; repo uses 1364 vs 1800 as the two styles)

### 2. Comparison: Connectivity (Ports vs Interface)

Connectivity style differs sharply between Verilog (many ports) and SystemVerilog (interface).

#### Verilog: Many Ports (1364)

```verilog
module master (
    output reg [31:0] data,
    output reg        valid,
    input  wire       ready,
    input  wire       clk,
    input  wire       rst_n
);
endmodule

module slave (
    input  wire [31:0] data,
    input  wire        valid,
    output reg         ready,
    input  wire        clk,
    input  wire        rst_n
);
endmodule

module top;
    wire [31:0] data;
    wire valid, ready, clk, rst_n;
    master u_master (.data(data), .valid(valid), .ready(ready), .clk(clk), .rst_n(rst_n));
    slave  u_slave  (.data(data), .valid(valid), .ready(ready), .clk(clk), .rst_n(rst_n));
endmodule
```

#### SystemVerilog: Interface (1800)

```systemverilog
interface bus_if;
    logic [31:0] data;
    logic valid, ready, clk, rst_n;
    modport master (output data, valid, input ready, clk, rst_n);
    modport slave  (input data, valid, output ready, input clk, rst_n);
endinterface

module master (bus_if.master bus);
endmodule
module slave  (bus_if.slave  bus);
endmodule

module top;
    bus_if bus();
    master u_master (.bus(bus));
    slave  u_slave  (.bus(bus));
endmodule
```

- **Comparison**: Same signals; interface reduces repetition and enforces direction via modports. Use interfaces when the flow supports 1800 and the connection is reused.

**Example**: `module7/examples/side_by_side/connectivity_versions/` (bus_1364.v — many ports; 1800 interface style is in Topics code)

### 3. Migration Patterns

Structured migration reduces risk and keeps behavior consistent.

#### 1364-1995 → 1364-2001

1. **Ports**: Convert to ANSI style (direction and type in port list).
2. **Combinational**: Replace explicit sensitivity with `always @*` where appropriate.
3. **Generate**: Use generate for replicated or conditional structure.
4. **Signed**: Add `signed` or $signed/$unsigned where signed arithmetic is needed.
5. **Arrays**: Use multi-dimensional arrays if needed; use localparam for constants.
6. **Test**: Run regression; compare simulation/synthesis with 1995 baseline.

#### 1364-2001/2005 → 1800-2005 (Design Subset)

1. **Types**: Replace wire/reg with logic for single-driver signals (one driver per logic).
2. **Combinational**: Replace `always @*` with `always_comb`.
3. **Sequential**: Replace `always @(posedge clk)` with `always_ff` (and keep nonblocking).
4. **Connectivity**: Introduce interfaces where many ports are repeated; add modports.
5. **Shared code**: Move types/constants/functions into packages; use import.
6. **Case**: Replace full_case/parallel_case attributes with unique case or priority case where semantics match.
7. **Test**: Run full regression; check synthesis and simulation.

#### 1800-2005 → 1800-2009/2012/2017

1. **Compatibility**: Most 2005 RTL is valid in 2009/2012/2017; run regression first.
2. **Optional**: Adopt 2009/2012/2017 features (e.g. modport expressions, checkers, array methods) only where the project and tool support them and there is clear benefit.
3. **Standard**: Set project standard to 1800-2017 (or supported revision) and document subset (e.g. design only, no SVA in RTL).

#### Incremental Migration

- **Per block**: Migrate one module or hierarchy level at a time; keep interfaces stable (e.g. keep ports the same while changing internals to logic/always_comb/always_ff).
- **Per feature**: First convert types (wire/reg → logic), then procedural blocks (@* → always_comb, etc.), then add interfaces/packages where useful.
- **Test after each step**: Regression after each change or small batch to catch regressions early.

**Example**: `module7/examples/migration/` (scripts or notes for 1995→2001, 1364→1800)

### 4. Tool Support and Version Selection

Different tools support different IEEE revisions and subsets. Version selection should match the tool chain and project constraints.

#### Simulators

- **Icarus Verilog**: Primarily 1364-2001/2005; limited SystemVerilog (e.g. some 1800 design features).
- **Verilator**: 1364 and a growing subset of 1800 (design and verification); check release notes for 1800-2017 support.
- **Commercial (VCS, Questa, Xcelium)**: Typically 1800-2005 through 1800-2017; confirm revision and options (e.g. -sv, -std=1800-2017).

#### Synthesis

- **Vendors**: Support a synthesizable subset of 1364 and/or 1800; exact subset and revision vary (e.g. 1364-2005, 1800-2005, 1800-2012).
- **Check**: Tool manual for “supported Verilog/SystemVerilog” and “synthesizable constructs”; align RTL with that subset.

#### Lint and Formal

- **Lint**: Often supports 1364 and 1800; may allow selecting revision (e.g. 1800-2017).
- **Formal**: Assertions and checkers (1800); confirm supported revision and SVA/checker subset.

#### Choosing a Project Standard

- **Legacy or Verilog-only flow**: Use “1364-2005 subset” (or 2001) and avoid SystemVerilog-only constructs.
- **New RTL with SystemVerilog**: Use “1800-2017” (or latest revision the tool supports); restrict to design subset if synthesis does not support full 1800.
- **Verification**: Use 1800-2017 (or supported revision) for SVA, checkers, coverage, classes.
- **Single revision**: State one revision (e.g. “IEEE 1800-2017”) in the project style guide and ensure all tools can accept that revision or a subset.

**Example**: `module7/docs/tool_support_matrix.md` (optional; table: tool vs 1364-1995/2001/2005, 1800-2005/2009/2012/2017)

### 5. Migration Checklist (1364 → 1800 Design)

Use this checklist when migrating a block from Verilog (1364) to SystemVerilog design subset (1800).

#### Pre-Migration

- [ ] Identify target standard (e.g. 1800-2017) and tool-supported subset.
- [ ] Establish baseline: passing simulation and (if applicable) synthesis for current 1364 RTL.
- [ ] List all files and hierarchy; decide order of migration (e.g. leaf modules first).

#### Per-Module Steps

- [ ] **Ports**: Keep ANSI style; change port types from wire/reg to logic where single driver.
- [ ] **Internal signals**: Replace wire/reg with logic for single-driver nets/variables.
- [ ] **Combinational always**: Replace `always @*` with `always_comb`; keep blocking assignment.
- [ ] **Sequential always**: Replace `always @(posedge clk)` (and similar) with `always_ff`; keep nonblocking.
- [ ] **Case**: Replace full_case/parallel_case attributes with unique case or priority case if semantics match.
- [ ] **Interfaces**: Optional; introduce interface for large or repeated port groups; add modports.
- [ ] **Packages**: Optional; move shared types/constants/functions to package; add import.
- [ ] **defparam**: Remove; use parameter override at instantiation only (1364-2005 and 1800).
- [ ] **Test**: Run simulation (and synthesis) for this module; compare with baseline.

#### Post-Migration

- [ ] Full regression (simulation and synthesis).
- [ ] Update style guide and project standard to 1800 (and revision).
- [ ] Document any remaining 1364-only blocks and reason (e.g. legacy IP).

**Example**: `module7/docs/migration_checklist.md` (this checklist in a file)

### 6. Version Selection Checklist

Use this when starting a new project or adopting a standard for an existing one.

#### Constraints

- [ ] **Tools**: Which simulator, synthesis, lint, and formal tools are used? What IEEE revision does each support?
- [ ] **IP and legacy**: Are there blocks or IP that are Verilog-only or tied to a specific revision?
- [ ] **Team**: Does the team know 1364 only, or 1800 design/verification as well?
- [ ] **Target**: FPGA, ASIC, or both? What synthesizable subset does the vendor support?

#### Decision

- [ ] **Verilog-only (1364 subset)**: Choose if tools or IP require it; use 1364-2005 as reference (wire/reg, always @*, no logic/interfaces/packages).
- [ ] **SystemVerilog design (1800)**: Choose if tools support it; use 1800-2017 as reference (logic, always_comb/always_ff, interfaces, packages, unique/priority case).
- [ ] **Single revision**: State one revision (e.g. IEEE 1800-2017) in the project; define subset (e.g. design only, no SVA in RTL) if needed.
- [ ] **Document**: Record chosen standard and subset in style guide or README; reference LRM and tool manuals.

**Example**: `module7/docs/version_selection_checklist.md`

### 7. Maintaining the Course When New Versions Appear

The version-centric course (one module per major revision) can be extended when new IEEE 1800 revisions are published (e.g. 1800-2024).

#### Adding a New Module

- **New standard released**: Add a new module (e.g. Module 8: IEEE 1800-2024) that describes what the new revision adds or clarifies over 2017.
- **Content**: Follow the same format (Goal, Overview, Topics Covered, Examples, DUT, Tests, Learning Outcomes, Key Concepts, Exercises, Common Pitfalls, Next Steps, Additional Resources).
- **Focus**: “What changed from 2017”; keep design-relevant content; link back to Module 6 (1800-2017).

#### Updating This Module (Module 7)

- **Version comparison**: Add the new revision to side-by-side tables and version timeline.
- **Migration**: Add “1800-2017 → 1800-2024” (or similar) migration steps if the new revision introduces breaking or recommended changes.
- **Tool support**: Update tool-support discussion to mention the new revision where applicable.
- **Checklists**: Extend migration and version-selection checklists to include the new revision.

#### Optional: Merging or Archiving Older Modules

- **Keep all modules**: Retain 1995 through 2017 (and new) so learners can see full evolution.
- **Or merge**: If the course must stay at N modules, merge two older revisions (e.g. “Module 2: 1364-2001 and 2005”) and add the new revision as the last module.
- **Archive**: Move very old revision content to an appendix or “legacy” section if needed; keep the main narrative on current and recent standards.

**Example**: Document in `module7/README.md` or course maintainer notes.

### 8. Summary: Version Comparison and Migration

- **Side-by-side**: Same design in 1995, 2001, 2005, 1800-2005, 1800-2017 shows exactly what changes (ports, types, procedural blocks, connectivity).
- **Migration**: Follow patterns (1364→1364, 1364→1800, 1800→1800); migrate incrementally (per block or per feature); test after each step.
- **Tools**: Match project standard to simulator, synthesis, and IP support; state one revision and subset.
- **Checklists**: Use migration checklist (1364→1800) and version-selection checklist for new or existing projects.
- **Future**: Add new modules for new IEEE 1800 revisions; update Module 7 comparison and migration content; keep format consistent.

## Examples

### Quick file reference

| Topic                | Path                                          | Key files |
|----------------------|-----------------------------------------------|-----------|
| Side-by-side mux     | `module7/examples/side_by_side/mux2_versions/` | `mux2_1364.v`, `mux2_1800.sv` |
| Side-by-side counter | `module7/examples/side_by_side/counter_versions/` | `counter_1364.v`, `counter_1800.sv` |
| Side-by-side decoder | `module7/examples/side_by_side/decoder_versions/` | `decoder_1364.v`, `decoder_1800.sv` |
| Side-by-side adder   | `module7/examples/side_by_side/adder_versions/`   | `adder_1364.v`, `adder_1800.sv` |
| Side-by-side parameter | `module7/examples/side_by_side/parameter_versions/` | `param_1364.v`, `param_1800.sv` |
| Side-by-side register | `module7/examples/side_by_side/register_versions/` | `register_1364.v`, `register_1800.sv` |
| Side-by-side FSM     | `module7/examples/side_by_side/fsm_versions/`    | `fsm_1364.v`, `fsm_1800.sv` |
| Side-by-side connectivity | `module7/examples/side_by_side/connectivity_versions/` | `bus_1364.v` (many ports; 1800 interface in Topics) |
| Migration 1364→1800  | `module7/examples/migration/`                  | `migration_steps.sv` |
| Migration 1995→2001  | `module7/examples/migration_1995_to_2001/`     | `migration_1995_2001.v` |
| Migration checklist  | `module7/examples/migration_checklist/`        | `migration_checklist.sv` |
| Incremental migration| `module7/examples/incremental_migration/`      | `incremental_migration.sv` |
| Port style compare   | `module7/examples/port_style_compare/`         | `port_style_compare.v` |
| Case versions        | `module7/examples/case_versions/`              | `case_versions.sv` |
| No defparam          | `module7/examples/no_defparam/`               | `no_defparam.v` |
| Version table        | `module7/examples/version_table/`              | `version_table.sv` |
| Version selection    | `module7/examples/version_selection/`         | `version_selection.sv` |

### Module 7 Examples

1. **Side-by-Side: Mux** (`examples/side_by_side/mux2_versions/`)
   - Same 2:1 mux in 1364-1995, 1364-2001, 1364-2005, 1800-2005 (and optionally 1800-2017)
   - **Key Concepts**: Port style, type, procedural block, one driver

2. **Side-by-Side: Counter** (`examples/side_by_side/counter_versions/`)
   - Same counter in 1995, 2001, 2005, 1800-2005
   - **Key Concepts**: Sequential block, reset, parameter/localparam

3. **Side-by-Side: Decoder** (`examples/side_by_side/decoder_versions/`)
   - Same 2:4 decoder in 1995, 2001, 2005, 1800; case vs unique case
   - **Key Concepts**: Port style, always @(sel) vs @* vs always_comb, unique case

4. **Side-by-Side: Adder** (`examples/side_by_side/adder_versions/`)
   - Same 8-bit adder in 1995, 2001, 2005, 1800 (continuous assign)
   - **Key Concepts**: wire vs logic; assign unchanged across versions

5. **Side-by-Side: Parameter** (`examples/side_by_side/parameter_versions/`)
   - Same parameterized shift in 1364 (parameter/localparam) vs 1800 (parameter int)
   - **Key Concepts**: parameter int, localparam int; same behavior

6. **Side-by-Side: Connectivity** (`examples/side_by_side/connectivity_versions/`)
   - Same master/slave connection: many ports (1364)
   - **Key Concepts**: Port list size, direction, reuse; interface (1800) optional per tool

7. **Migration 1364→1800** (`examples/migration/`)
   - Before/after: wire/reg, always @* vs logic, always_comb, unique case
   - **Key Concepts**: Order of steps, testing, regression

8. **Migration 1995→2001** (`examples/migration_1995_to_2001/`)
   - Before: non-ANSI, @(a or b or sel). After: ANSI, always @*
   - **Key Concepts**: ANSI ports, implicit sensitivity

9. **Case Versions** (`examples/case_versions/`)
   - Same 4:1 mux: 1364 case+default vs 1800 unique case
   - **Key Concepts**: case semantics; unique case for tool checking

10. **Version Table** (`examples/version_table/`)
    - Single reference: construct vs standard (1995–2017)
    - **Key Concepts**: When each feature was introduced; minimum revision

11. **Version Selection** (`examples/version_selection/`)
    - Runnable reminder of version-selection checklist (constraints, decision, document)
    - **Key Concepts**: See MODULE7.md for full checklist

12. **Side-by-Side: Register** (`examples/side_by_side/register_versions/`)
    - Same D flip-flop in 1995, 2001, 2005, 1800 (sequential block style)
    - **Key Concepts**: always @(posedge clk) vs always_ff; wire/reg vs logic

13. **Side-by-Side: FSM** (`examples/side_by_side/fsm_versions/`)
    - Same tiny FSM in 1364 vs 1800 (case vs unique case, always_ff)
    - **Key Concepts**: Sequential FSM; 1800 always_ff and unique case

14. **Migration Checklist** (`examples/migration_checklist/`)
    - Runnable reminder of 1364→1800 migration steps (pre, per-module, post)
    - **Key Concepts**: See MODULE7.md for full migration checklist

15. **Incremental Migration** (`examples/incremental_migration/`)
    - Two steps: step1 1364 style, step2 1800 style; same mux, compare outputs
    - **Key Concepts**: Migrate one construct at a time; test after each step

16. **Port Style Compare** (`examples/port_style_compare/`)
    - Same 2:1 mux: non-ANSI (1995) vs ANSI (2001) ports only
    - **Key Concepts**: Port declaration style; no other change

17. **No defparam** (`examples/no_defparam/`)
    - 1364-2005: parameter override at instantiation #(.WIDTH(n)); avoid defparam
    - **Key Concepts**: defparam deprecated; use instantiation override

## Design Under Test (DUT)

### Side-by-Side and Migration DUTs (`module7/dut/`)

- **mux2_1364.v, mux2_1800.sv**: Same 2:1 mux in 1364 style vs 1800 style
  - **Example**: Compare ports (ANSI), types (wire/reg vs logic), always @* vs always_comb

- **counter_1364.v, counter_1800.sv**: Same counter in 1364 style vs 1800 style
  - **Example**: Sequential block, reset, parameter/localparam; always @(posedge clk) vs always_ff

*Additional side-by-side DUTs (decoder, adder, register, FSM, parameter) live in `examples/side_by_side/*_versions/`. Connectivity (many ports vs interface) is in `examples/side_by_side/connectivity_versions/bus_1364.v`; 1800 interface version is shown in Topics.*

## Tests

### Module 7 Tests

- **test_mux2_all.sv**: Testbench that exercises mux in 1364 and 1800 form (uses `dut/mux2_1364.v`, `dut/mux2_1800.sv`) and compares outputs
  - **Key Features**: Same stimulus; same expected behavior; version-agnostic build

- **test_counter_all.sv**: Testbench that exercises counter in 1364 and 1800 form (uses `dut/counter_1364.v`, `dut/counter_1800.sv`)
  - **Key Features**: Reset, enable, wrap; compare across versions

## Learning Outcomes

By the end of this module, you should be able to:

- ✓ Compare the same design across 1364-1995, 1364-2001, 1364-2005, and 1800 (design subset) and list what changes
- ✓ Compare connectivity style: many ports (1364) vs interface (1800)
- ✓ Plan and execute migration from 1364 to 1800 design subset (or between 1364 revisions) using the migration patterns and checklist
- ✓ Choose a project standard (revision and subset) based on tool support and constraints
- ✓ Use the version-selection checklist for new or existing projects
- ✓ Describe how to extend the course when a new IEEE 1800 revision is released

## Key Concepts

### Side-by-Side Comparison

- **Same behavior**: Logic is equivalent across versions; only syntax and intent (and tool checking) change.
- **Ports**: Non-ANSI (1995) → ANSI (2001+); type wire/reg (1364) → logic (1800) for single driver.
- **Procedural**: Explicit sensitivity (1995) → @* (2001) → always_comb/always_ff (1800).
- **Connectivity**: Many ports (1364) → interface + modport (1800) for reused bundles.

### Migration Patterns

- **1364→1364**: Ports, @*, generate, signed, localparam (1995→2001); avoid defparam (2005).
- **1364→1800**: logic, always_comb/always_ff, optional interface/package, unique/priority case; test at each step.
- **1800→1800**: Usually compatible; adopt new features only when supported and beneficial.

### Tool Support and Version Selection

- **One revision**: State project standard (e.g. 1800-2017); match tool and IP support.
- **Subset**: Define “design only” or “Verilog subset” if tools or IP require it.
- **Checklists**: Migration checklist (per module, per feature); version-selection checklist (constraints, decision, document).

### Course Maintenance

- **New revision**: Add new module (same format); update Module 7 comparison and migration; extend checklists.
- **Consistency**: Keep one-module-per-major-revision structure; link new module to previous (e.g. 1800-2017).

## Exercises

1. **Side-by-Side Mux**
   - Implement the same 2:1 mux in 1364-1995, 1364-2001, and 1800-2005 (or 2017). Run one testbench (or one per version) and confirm identical behavior. List the exact syntax differences in a short table.

2. **Side-by-Side Connectivity**
   - Implement a small master/slave pair twice: once with many ports (1364) and once with an interface (1800). Connect in top and run the same test; compare line count and readability.

3. **Migration One Block**
   - Take one existing 1364-2005 module (e.g. from Module 2 or 3) and migrate it to 1800-2017 design subset using the migration checklist. Run simulation and (if applicable) synthesis before and after; confirm no functional change.

4. **Version Selection**
   - For a hypothetical project (or your real project), fill out the version-selection checklist: tools, IP, team, target. Decide “Verilog-only” or “1800 design” and state the revision (e.g. 1800-2017). Document the decision in one paragraph.

5. **Version Table**
   - Build a one-page table: rows = construct (e.g. logic, always_comb, interface, unique case), columns = 1364-1995, 1364-2001, 1364-2005, 1800-2005, 1800-2009, 1800-2012, 1800-2017. Mark “introduced” or “clarified” in the first column where it applies. Use it as a quick reference.

## Common Pitfalls and How to Avoid Them

1. **Migrating Everything at Once**
   - **Mistake**: Converting a large codebase from 1364 to 1800 in one big change.
   - **Reality**: Hard to debug; regressions are difficult to isolate.
   - **Correct**: Migrate incrementally (one module or one feature at a time); run regression after each step.
   - **Why**: Reduces risk and keeps a clear baseline.

2. **Ignoring Tool Support**
   - **Mistake**: Choosing 1800-2017 and using constructs the synthesis or simulator does not support.
   - **Reality**: Compile or elaboration errors; or tool-specific behavior.
   - **Correct**: Check tool manuals for supported revision and synthesizable subset; align RTL with that.
   - **Why**: Ensures the project builds and matches tool expectations.

3. **Breaking Interfaces During Migration**
   - **Mistake**: Changing port list or interface of a block while migrating its internals, so that other modules break.
   - **Reality**: Large ripple of changes; integration failures.
   - **Correct**: Keep external interface (ports or interface modport) unchanged during internal migration; change only implementation (logic, always_comb/always_ff, etc.).
   - **Why**: Limits scope of change and preserves compatibility with rest of design.

4. **Mixing Revisions in One File**
   - **Mistake**: Using 1995 ports in one module and 1800 logic in another in the same file without a clear rule.
   - **Reality**: Confusing for readers and tools; possible tool-dependent behavior.
   - **Correct**: Use one project standard per file (or per project); document the standard in the style guide.
   - **Why**: Consistency and predictable tool behavior.

5. **Forgetting to Test After Migration**
   - **Mistake**: Changing syntax (e.g. wire→logic, always @*→always_comb) and not re-running simulation or synthesis.
   - **Reality**: Subtle bugs (e.g. latch, wrong sensitivity) can appear.
   - **Correct**: Run full regression (simulation and synthesis) after every migration step; compare with baseline.
   - **Why**: Catches functional or synthesis differences early.

## Next Steps

You have completed the version-centric Verilog and SystemVerilog course (Modules 1–7). Suggested next steps:

- **Apply**: Use the version-selection and migration checklists in your next project or when maintaining legacy RTL.
- **Reference**: Use Module 1–6 as a quick reference for each IEEE revision; use Module 7 for comparison and migration.
- **Extend**: When a new IEEE 1800 revision is published, add a new module (same format) and update Module 7.
- **Related courses**: For verification methodology (e.g. UVM), assertion writing (SVA), or RTL design patterns, see other courses in the learning path.

## Additional Resources

### Module Documentation

- **Module 7 README**: [module7/README.md](../module7/README.md) — directory structure, quick start, and file map
- **Module 6**: [docs/MODULE6.md](MODULE6.md) — IEEE 1800-2017 (prerequisite)
- **Modules 1–5**: [docs/MODULE1.md](MODULE1.md) through [docs/MODULE5.md](MODULE5.md) — 1364-1995 through 1800-2012

### Reference Materials

- **IEEE Std 1800-2017**: Single LRM for Verilog and SystemVerilog; reference for current standard
- **Tool manuals**: Simulator, synthesis, and lint support for 1364 and 1800 revisions
- **Style guides**: Project-specific rules for subset and revision (e.g. “1800-2017 design only”)

### Learning Path

1. **Review**: Revisit Modules 1–6 for any revision you use often (e.g. 1364-2005, 1800-2017).
2. **Compare**: Run side-by-side examples (mux, counter, connectivity) and inspect diffs.
3. **Migrate**: Pick one block and migrate using the checklist; run regression.
4. **Document**: Write down your project’s standard and subset; share with team.
5. **Maintain**: When a new 1800 revision appears, add a module and update Module 7 (comparison and migration).

---

For questions or issues, refer to the main project documentation, the IEEE 1800-2017 standard, or the migration and version-selection checklists in this module.
