# Module 6: IEEE 1800-2017 (Current SystemVerilog)

**Goal**: Master the current SystemVerilog standard (IEEE 1800-2017): unified LRM, merged Verilog and SystemVerilog, and design/verification overview.

**Prerequisites**: Modules 1–5 (1364-1995 through 1800-2012) — you should be comfortable with the version timeline and SystemVerilog design subset (logic, always_comb/always_ff, interfaces, packages, assertions).

**Estimated time**: 4–6 hours (examples + exercises + reading).


## Running Module 6

From the repo root:

- **Run all examples**: `./scripts/module6.sh`
- **Slides & video**: [slides.pptx](../media/module6/slides.pptx) · [slides.pdf](../media/module6/slides.pdf) · [video.mp4](../media/module6/video.mp4) — regenerate: `./scripts/build_all_media.sh --module 6`



## How to Learn This Module

Follow this path to learn **IEEE 1800-2017 (Current SystemVerilog)** in order:

1. **Skim this document** — Goal, Overview, and Topics Covered set the IEEE scope for Module 6.
2. **Study design architecture** — See how DUTs, examples, and testbenches fit together under `module6/`.
3. **Work through labs in order** — Open `module6/EXAMPLES.md` and run each `make clean && make run` from the repo root.
4. **Run the full module script** — `./scripts/module6.sh` from the repo root to simulate all examples and tests.
5. **Complete the exercises** — Try each exercise in this document before reading solutions or peeking at reference RTL.
6. **Review Common Pitfalls** — Can you explain each mistake and the fix?
7. **Self-check** — Use `module6/CHECKLIST.md` before starting the next module.

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

This module covers IEEE Std 1800-2017, the current SystemVerilog standard. In 1800-2017, the Verilog language (formerly IEEE 1364) is merged into the SystemVerilog LRM, so one document defines both the Verilog subset and SystemVerilog extensions. You'll learn what 2017 adds or clarifies over 2012: LRM structure, clarifications across design and verification, and how to treat 1800-2017 as the single reference for "current Verilog and SystemVerilog." This module also summarizes the full version path (1364-1995 → 1800-2017) and gives guidance on choosing a standard and migrating RTL.

### Learning Resources

**IEEE Standard Reference**:
- **IEEE Std 1800-2017**: IEEE Standard for SystemVerilog—Unified Hardware Design, Specification, and Verification Language
- **Unified LRM**: Merges former IEEE 1364 (Verilog) and IEEE 1800 (SystemVerilog) into one standard
- Current baseline for new RTL and verification; widely supported by commercial and open-source tools

**When to Reference the Standard**:
- When defining project language level (e.g. "1800-2017" or "1364-2005 subset")
- When checking authoritative syntax or semantics for any Verilog or SystemVerilog construct
- When comparing tool behavior against the LRM or planning migration

## Design Architecture

### 1. Repository layout (module6/)

- IEEE 1800-2017 — current unified SystemVerilog LRM
- Summarizes design subset plus 2017 language updates
- module6/examples/ — version summary, migration, assertions recap
- scripts/module6.sh — current-standard lab sweep

### 2. 2017 standard in practice

- Verilog is a subset of SystemVerilog in the 2017 LRM
- logic, always_comb/ff, packages, interfaces — production RTL baseline
- unique case, priority case — prefer over vendor attributes
- Course maps 2017 features back to Modules 4–5 introductions

### 3. Single-driver and type discipline

- logic enforces one driver per net in synthesizable RTL
- Package import :: scope — shared enums and parameters
- See rtl_architecture.png — same DUT/TB split as earlier modules

## Key files to study

- module6/examples/subsets/
- module6/examples/design_recap/
- module6/examples/version_summary/
- scripts/module6.sh

## Verification & Testing Methods

### 1. Execution flow

- make run per lab; ./scripts/module6.sh for full module
- version_summary example prints construct-by-standard table

### 2. Regression before Module 7

- Confirm all 2017-subset examples compile with your simulator
- Review CHECKLIST.md — ready to compare versions in Module 7

## Topics Covered

### 1. IEEE 1800-2017 Context

IEEE 1800-2017 is the current SystemVerilog standard. It consolidates Verilog and SystemVerilog into one Language Reference Manual (LRM).

#### Unified LRM (2017)

- **Before 2017**: IEEE 1364 defined Verilog; IEEE 1800 defined SystemVerilog (extending 1364). Two documents.
- **1800-2017**: One LRM (IEEE 1800-2017) defines both the Verilog subset and SystemVerilog. IEEE 1364 is superseded by 1800 for new designs.
- **Implication**: When you say "IEEE 1800-2017," you are referring to the full language (Verilog + SystemVerilog). "Verilog" is now the subset of 1800 that corresponds to former 1364.

#### What 1800-2017 Adds or Clarifies Over 2012

- **Structure**: Single LRM; consistent numbering and cross-references; Verilog and SystemVerilog in one place.
- **Clarifications**: Scheduling, generate, interfaces, assertions, coverage, DPI, and many other areas refined.
- **Corrections**: Errata and ambiguous cases addressed.
- **Additions**: Any new or clarified features in the 2017 edition (check LRM for specifics; often incremental).
- **No separate 1364**: For new work, use 1800-2017; legacy "1364-only" is the subset of 1800 that omits SystemVerilog-only constructs.

#### Backward Compatibility

- RTL and testbenches written for 1364-1995 through 1800-2012 remain valid in 1800-2017 when they use only constructs that are still defined and unchanged.
- Adopt 2017 as the reference standard for new projects unless a project or tool explicitly targets an older revision.

### 2. Verilog as a Subset of 1800-2017

In 1800-2017, "Verilog" is the subset of the language that corresponds to the former IEEE 1364. You can still write and target "Verilog-only" RTL by avoiding SystemVerilog-only features.

#### Verilog Subset (Design)

- **Modules, ports**: ANSI or non-ANSI (1364-1995 style); wire, reg.
- **Procedural blocks**: always, initial; always @* (2001); explicit sensitivity (1995).
- **No SystemVerilog-only**: No logic, always_comb/always_ff, interfaces, packages, unique/priority case (use 1364 case + attributes if needed), classes, SVA (unless added explicitly).
- **Use**: When the flow or legacy code requires "Verilog only" (e.g. synthesis or IP that does not accept SystemVerilog).

#### SystemVerilog Design Subset (1800)

- **logic**, always_comb, always_ff, always_latch.
- **Interfaces and modports.**
- **Packages and import.**
- **unique case, priority case.**
- **2-state types** (bit, int, etc.) where useful.
- **Use**: When the flow supports SystemVerilog; preferred for new RTL for clarity and tool checking.

#### Choosing a Subset

- **Verilog-only (1364 subset)**: Maximum portability; use when tools or IP are Verilog-only.
- **SystemVerilog design (1800 subset)**: Better expressiveness and checking; use when the flow supports 1800.

**Example**: `module6/examples/subsets/verilog_vs_sv.sv` (same design in both styles: 1364 vs 1800)

### 3. Design Constructs in 1800-2017 (Recap and Clarifications)

1800-2017 does not change the core design constructs from 2005/2009/2012; it clarifies their semantics. This section recaps and notes 2017 clarifications where relevant.

#### logic and Single Driver

- **Rule**: logic must have exactly one driver (one assign, one always block, or one port connection).
- **2017**: Semantics of multiple drivers, resolution, and connection rules are clarified in the LRM.

#### always_comb, always_ff, always_latch

- **Intent**: Combinational, sequential (flip-flop), or latch; tools can check and warn.
- **2017**: Execution order, sensitivity, and interaction with other processes are clarified.

#### Interfaces and Modports

- **Use**: Bundle signals; modports define direction per role.
- **2017**: Interface connection, parameterization, and modport rules are refined.

#### Packages and import

- **Use**: Shared types, constants, functions; explicit namespace.
- **2017**: Import scope, search order, and compilation-unit interaction are clarified.

#### unique case and priority case

- **Semantics**: At most one match (unique) or first match wins (priority); runtime checks possible.
- **2017**: Case statement semantics and synthesis mapping are clarified.

**Example**: Reference Module 4 and 5 examples; 2017 is the authoritative source for any ambiguity.

### 4. Assertions and Verification in 1800-2017 (Context)

1800-2017 defines the full assertion (SVA) and verification language. For design-focused work, only high-level context is needed here.

#### Immediate and Concurrent Assertions

- **Immediate**: `assert (condition);` — executed when reached; useful for invariants in RTL.
- **Concurrent**: `assert property (...);` — temporal; used in verification and bind files.
- **2017**: Property syntax, scheduling, and binding are clarified.

#### Checkers

- **Checker**: Reusable block of assertions/assumptions/coverage (from 2012); instantiated or bound.
- **2017**: Checker semantics and instantiation are clarified.

#### Coverage

- **Covergroups, coverpoints**: Defined in 1800; used in verification.
- **2017**: Coverage options and semantics are refined.

**Use in design**: Immediate assertions in RTL for local invariants; concurrent assertions and checkers in verification or bind modules. Keep RTL synthesizable; put heavy verification in testbench or separate bind files.

**Example**: `module6/examples/assertions/immediate_in_rtl.sv` (optional)

### 5. Synthesis and Tool Support (1800-2017)

1800-2017 defines the language; synthesis and simulation tools implement a **synthesizable subset** and may support different LRM revisions.

#### Synthesizable Subset

- **Generally supported**: logic, always_comb, always_ff, interfaces, packages, generate, parameter, localparam, unique/priority case, assign, operators, signed.
- **Often not supported or tool-specific**: Classes, full SVA, dynamic arrays/queues in RTL, virtual interface, DPI in RTL, delays, initial (except for FPGA init per tool).
- **Check tool docs**: Each vendor defines the exact synthesizable subset for 1800-2017.

#### Simulation Support

- **1800-2017**: Most commercial and several open-source simulators support a large subset of 1800-2017.
- **Revisions**: Tools may support 2005, 2009, 2012, or 2017; choose project standard to match tool and IP.

#### Linting and Formal

- **Lint**: Many tools check 1800-2017 syntax and common RTL rules (e.g. single driver, blocking/nonblocking).
- **Formal**: Assertions and checkers are used with formal tools; 2017 clarifies semantics for consistency.

**Example**: Document only; or reference project style guide and tool manuals.

### 6. Version Timeline Summary (1995 → 2017)

A concise view of the standard evolution covered in Modules 1–6:

| Standard     | Focus                          | Key design additions / notes        |
|-------------|---------------------------------|------------------------------------|
| 1364-1995   | First Verilog standard         | Modules, wire/reg, assign, always, initial; no ANSI, no @* |
| 1364-2001   | Major Verilog update           | ANSI ports, always @*, generate, signed, localparam, arrays |
| 1364-2005   | Last Verilog-only standard     | Clarifications; defparam deprecated; synthesizable subset |
| 1800-2005   | First SystemVerilog            | logic, always_comb/always_ff, interfaces, packages, unique/priority case |
| 1800-2009   | SystemVerilog revision         | Interface refinements; type/operator/assertion clarifications |
| 1800-2012   | SystemVerilog revision         | Checker; array/string methods; compilation unit |
| 1800-2017   | Current; unified LRM           | Merged 1364+1800; single LRM; clarifications |

- **Design migration**: 1364-1995 → 2001 → 2005 (Verilog); then 1800-2005 → 2009 → 2012 → 2017 (SystemVerilog). New RTL typically targets 1800-2017 or a subset (e.g. "1800-2017 design only").

### 7. Choosing a Standard and Migration

#### Choosing a Standard

- **Legacy or Verilog-only flow**: Use 1364-2005 subset (no SystemVerilog) or document "Verilog as per 1800-2017 subset."
- **New RTL with SystemVerilog**: Use 1800-2017 (or 2012/2009 if tool lags); adopt logic, always_comb/always_ff, interfaces, packages as needed.
- **Verification**: Use 1800-2017 (or supported revision) for SVA, checkers, coverage, classes.
- **Single revision**: Prefer one stated revision (e.g. "1800-2017") for the project to avoid mixed semantics.

#### Migration (Brief)

- **1364 → 1800 design**: Replace wire/reg with logic (single driver); always @* → always_comb; always @(posedge clk) → always_ff; add interfaces/packages where beneficial; use unique/priority case.
- **Older 1800 → 2017**: Most code remains valid; adopt 2017 clarifications and any new features the project needs; run regression.
- **Tool support**: Confirm simulator and synthesis support for the chosen revision before locking the standard.

**Example**: `module6/README.md` or course notes with "Standard selection checklist."

### 8. 1800-2017 as the Single Reference

- **One LRM**: For any question on Verilog or SystemVerilog syntax/semantics, 1800-2017 is the single reference (replacing 1364 for new work).
- **Subsets**: Define project subsets explicitly (e.g. "1800-2017 design subset, no SVA in RTL") so that lint, synthesis, and simulation stay consistent.
- **Future revisions**: New IEEE 1800 revisions (e.g. 2024+) will extend 2017; the version-centric approach (one module per major revision) remains applicable.

## Examples

### Quick file reference

| Topic                | Path                                  | Key files |
|----------------------|---------------------------------------|-----------|
| Verilog vs SV subset | `module6/examples/subsets/`            | `verilog_vs_sv.sv` |
| Design recap         | `module6/examples/design_recap/`      | `design_recap.sv` |
| Immediate assertion  | `module6/examples/assertions/`        | `immediate_in_rtl.sv` |
| Version summary      | `module6/examples/version_summary/`   | `version_summary.sv` |
| Migration 1364→1800  | `module6/examples/migration/`         | `migration.sv` |
| Logic single driver  | `module6/examples/logic_single_driver/` | `logic_single_driver.sv` |
| Priority case        | `module6/examples/priority_case/`     | `priority_case.sv` |
| Package and import   | `module6/examples/package_import/`    | `package_import.sv` |
| Unique case          | `module6/examples/unique_case/`       | `unique_case.sv` |

### Module 6 Examples (1800-2017)

1. **Verilog vs SystemVerilog Subset** (`examples/subsets/`)
   - Same small design: one file using only 1364-style (wire/reg, always @*), one using 1800 design (logic, always_comb/always_ff)
   - **Key Concepts**: 1364 subset vs 1800 design subset within 1800-2017

2. **Design Constructs Recap** (`examples/design_recap/`)
   - One module using logic, always_comb, always_ff, package, unique case (all 1800-2017 compliant)
   - **Key Concepts**: Current standard design subset in one place

3. **Immediate Assertion in RTL** (`examples/assertions/`)
   - Simple invariant (e.g. one-hot state) with assert in design
   - **Key Concepts**: Synthesizable RTL + assertion; 2017 semantics

4. **Version Comparison** (`examples/version_summary/`)
   - Table or script that lists which construct belongs to which standard (1995–2017)
   - **Key Concepts**: Full version timeline; choosing a standard

5. **Migration** (`examples/migration/`)
   - Same 4:1 mux in 1364-2005 style vs 1800-2017 style (wire/reg→logic, always @*→always_comb, unique case)
   - **Key Concepts**: Step-by-step migration from 1364 to 1800 design subset

6. **Logic Single Driver** (`examples/logic_single_driver/`)
   - Comb and seq blocks; each logic has exactly one driver (2017 clarified)
   - **Key Concepts**: Single driver for logic; assign, always_comb, always_ff

7. **Priority Case** (`examples/priority_case/`)
   - Priority encoder using priority case (first match wins)
   - **Key Concepts**: priority case; 2017 semantics for encoders/arbiters

8. **Package and Import** (`examples/package_import/`)
   - Shared types and parameters in package; import in module and top
   - **Key Concepts**: Package and import; 2017 scope and search order clarifications

9. **Unique Case** (`examples/unique_case/`)
   - Decoder with unique case and default (no latch)
   - **Key Concepts**: unique case; at most one match; 2017 clarified

## Design Under Test (DUT)

### 1800-2017 Design Subset (`module6/dut/`)

- **alu_2017.sv**: Small ALU with logic, always_comb, package type, optional immediate assertion
  - **Example**: Current standard design subset; no legacy 1364-only constructs

- **design_block_2017.sv**: Block using 1800-2017 design constructs (logic, always_comb/always_ff, package, etc.)
  - **Example**: Interface-style or block-level connectivity; 2017 design subset

- **fsm_2017.sv**: FSM with unique case and one immediate assertion (state encoding)
  - **Example**: 1800-2017 RTL; assertion for invariant

## Tests

### Module 6 Tests

- **test_alu_2017.sv**: ALU testbench (1800-2017 compatible)
  - **Key Features**: Exercises `dut/alu_2017.sv`; no use of deprecated or non-2017 constructs

*Additional tests for `design_block_2017` and `fsm_2017` may be added; run `make` in `module6/tests` to see current list.*

## Learning Outcomes

By the end of this module, you should be able to:

- ✓ Describe IEEE 1800-2017 as the unified LRM (Verilog + SystemVerilog in one standard)
- ✓ Explain "Verilog" as a subset of 1800-2017 and when to use Verilog-only vs SystemVerilog design
- ✓ Recap design constructs (logic, always_comb/always_ff, interfaces, packages, unique/priority case) in 2017 context
- ✓ Use immediate assertions in RTL appropriately; understand SVA/checker context
- ✓ Summarize the version timeline (1364-1995 through 1800-2017) and choose a standard for a project
- ✓ Plan simple migration from older Verilog or SystemVerilog to 1800-2017

## Key Concepts

### Unified LRM (1800-2017)

- **One document**: IEEE 1800-2017 defines both Verilog and SystemVerilog; 1364 is superseded for new work.
- **Subsets**: Projects can target "Verilog subset" or "SystemVerilog design subset" within 1800-2017.

### Verilog vs SystemVerilog Within 1800-2017

- **Verilog subset**: wire/reg, always @* or explicit sensitivity, no logic/interfaces/packages/unique/priority case (or use 1364-style only).
- **SystemVerilog design**: logic, always_comb/always_ff, interfaces, packages, unique/priority case; preferred for new RTL when tools support it.

### Version Timeline

- **1364**: 1995 → 2001 → 2005 (Verilog only).
- **1800**: 2005 → 2009 → 2012 → 2017 (SystemVerilog; 2017 merges 1364).
- **New projects**: Default to 1800-2017 unless project or tool requires an older revision.

### Synthesis and Simulation

- **LRM**: Defines language; 1800-2017 is the reference.
- **Tools**: Define synthesizable subset and supported revision; align project standard with tools and IP.

## Exercises

1. **Subset Comparison**
   - Implement the same small block twice: once with 1364-style (wire/reg, always @*) and once with 1800 design (logic, always_comb/always_ff). Run both with an 1800-2017 tool and compare.

2. **1800-2017 Design Checklist**
   - List the design constructs you use in a current project (or a Module 4/5 design). Map each to a minimum standard (1995, 2001, 2005, 2005, 2009, 2012, 2017). State the "project standard" (e.g. 1800-2017).

3. **Immediate Assertion**
   - Add one immediate assertion (e.g. one-hot, valid encoding) to an existing 1800 RTL module. Run simulation and trigger a failure; confirm the message and fix.

4. **Version Table**
   - Build a one-page table: rows = construct (e.g. logic, interface, unique case), columns = 1364-1995, 1364-2001, 1364-2005, 1800-2005, 1800-2009, 1800-2012, 1800-2017. Mark when each was introduced or clarified.

5. **Migration Plan**
   - Take a small 1364-2005 design (or describe one). Write a short migration plan to 1800-2017 design subset (steps: logic, always_comb/always_ff, optional interface/package, unique/priority case). Do not implement all steps; outline only.

## Common Pitfalls and How to Avoid Them

1. **Assuming 1364 Is Still a Separate Standard**
   - **Mistake**: Citing "IEEE 1364-2005" as the current Verilog standard for new designs.
   - **Reality**: 1364 is merged into 1800-2017; new work should reference 1800-2017 (and use a subset if Verilog-only is required).
   - **Correct**: Use "1800-2017" as the reference; say "Verilog subset of 1800-2017" when restricting to non-SystemVerilog.
   - **Why**: Avoids confusion and ensures one LRM for all language questions.

2. **Mixing Revisions in One Project**
   - **Mistake**: Using 1800-2017 in one file and 1800-2005-only in another without a clear subset rule.
   - **Reality**: Can lead to tool-dependent behavior or subtle bugs.
   - **Correct**: Define one project standard (e.g. 1800-2017) and a subset (e.g. design only, no SVA in RTL); apply consistently.
   - **Why**: Predictable tool behavior and easier maintenance.

3. **Ignoring Tool Support**
   - **Mistake**: Writing 1800-2017 syntax that the synthesis or simulation tool does not support.
   - **Reality**: Compile or elaboration errors; or tool-specific interpretation.
   - **Correct**: Check tool documentation for supported LRM revision and synthesizable subset; restrict code to that.
   - **Why**: Ensures portability and correct results.

4. **Assertions in Synthesis**
   - **Mistake**: Expecting concurrent assertions or complex checkers to be synthesized.
   - **Reality**: Most assertion/checker logic is for simulation and formal; not for netlist.
   - **Correct**: Use immediate assertions for simple invariants if the tool supports them in RTL; keep heavy checking in testbench or bind files.
   - **Why**: Synthesis tools typically ignore or strip assertions; RTL should remain synthesizable.

5. **Over-Migrating Legacy Code**
   - **Mistake**: Converting all legacy 1364 RTL to 1800 (logic, interfaces, etc.) without need.
   - **Reality**: Risk of introducing bugs; effort may not pay off if the block is stable and Verilog-only is sufficient.
   - **Correct**: Migrate when adding features, fixing bugs, or when the project standard moves to 1800; otherwise leave stable 1364 RTL as-is.
   - **Why**: Balance benefit (readability, tool checking) with risk and effort.

## Next Steps

After completing this module, proceed to:

- **Module 7**: Version comparison and migration — Side-by-side designs across standards; tool support; migration patterns and checklist

## Additional Resources

### Module Documentation

- **Module 6 README**: [module6/README.md](../module6/README.md) — directory structure, quick start, and file map
- **Module 5**: [docs/MODULE5.md](MODULE5.md) — IEEE 1800-2009/2012 (prerequisite)
- **Module 7**: [docs/MODULE7.md](MODULE7.md) — Version comparison and migration (next)

### Reference Materials

- **IEEE Std 1800-2017**: IEEE Standard for SystemVerilog—Unified Hardware Design, Specification, and Verification Language (single LRM for Verilog and SystemVerilog)
- **IEEE Std 1800-2012**: For comparison (previous revision before unified LRM)
- **Tool Documentation**: Simulator and synthesis support for 1800-2017; synthesizable subset and revision support

### Learning Path

1. **Start here**: Complete Module 6 examples using 1800-2017; ensure tool supports 2017.
2. **Practice**: Write one new small block in 1800-2017 design subset; add one immediate assertion.
3. **Summarize**: Build the version table (1995–2017) and the project standard checklist.
4. **Prepare**: For Module 7, gather one design (or block) to compare across versions or to migrate.

---

For questions or issues, refer to the main project documentation or the IEEE 1800-2017 standard for authoritative syntax and semantics.
