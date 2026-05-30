# Module 3: IEEE 1364-2005 (Verilog-2005)

**Goal**: Master the final Verilog-only standard (IEEE 1364-2005), its clarifications over 2001, and the synthesizable subset as a stable baseline before SystemVerilog.

**Prerequisites**: Module 1 (1364-1995) and Module 2 (1364-2001) — you should be comfortable with ANSI ports, `always @*`, generate, signed types, and localparam.

**Estimated time**: 4–6 hours (examples + exercises + reading).


## Running Module 3

From the repo root:

- **Run all examples**: `./scripts/module3.sh`
- **Slides & video**: [slides.pptx](../media/module3/slides.pptx) · [slides.pdf](../media/module3/slides.pdf) · [video.mp4](../media/module3/video.mp4) — regenerate: `./scripts/build_all_media.sh --module 3`



## How to Learn This Module

Follow this path to learn **IEEE 1364-2005 (Verilog-2005)** in order:

1. **Skim this document** — Goal, Overview, and Topics Covered set the IEEE scope for Module 3.
2. **Study design architecture** — See how DUTs, examples, and testbenches fit together under `module3/`.
3. **Work through labs in order** — Open `module3/EXAMPLES.md` and run each `make clean && make run` from the repo root.
4. **Run the full module script** — `./scripts/module3.sh` from the repo root to simulate all examples and tests.
5. **Complete the exercises** — Try each exercise in this document before reading solutions or peeking at reference RTL.
6. **Review Common Pitfalls** — Can you explain each mistake and the fix?
7. **Self-check** — Use `module3/CHECKLIST.md` before starting the next module.

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

This module covers IEEE Std 1364-2005 (Verilog-2005), the last standard that defines Verilog alone before it was merged with SystemVerilog (IEEE 1800). You'll learn what 2005 adds or clarifies over 2001: minor language clarifications, additional system tasks, and deprecation notes. The focus is on using 1364-2005 as a clear, tool-stable baseline for RTL and on the synthesizable subset and best practices. This sets the stage for Module 4 (IEEE 1800 — SystemVerilog design subset).

### Learning Resources

**IEEE Standard Reference**:
- **IEEE Std 1364-2005**: IEEE Standard for Verilog Hardware Description Language
- Final standalone Verilog standard; 1800-2005 and later merge 1364 with SystemVerilog
- Used as the “pure Verilog” reference in many style guides and synthesis flows

**When to Reference the Standard**:
- When defining a 1364-only (no SystemVerilog) design or tool target
- When checking exact semantics for edge cases (e.g. blocking vs nonblocking, race rules)
- When comparing 1364-2005 with 1800 (Module 4+) to decide when to adopt SystemVerilog

## Topics Covered

### 1. IEEE 1364-2005 Context

IEEE Std 1364-2005 is a modest revision of 1364-2001. It does not introduce major new constructs; it clarifies behavior and adds a few conveniences. It is the last standard where “Verilog” is defined on its own before 1800 subsumes it.

#### What 1364-2005 Is

- **Final Verilog-only standard**: No SystemVerilog (no `logic`, interfaces, packages, classes).
- **Clarifications**: Refined wording and examples for 2001 features (e.g. generate, signed, scheduling).
- **Minor additions**: Additional system tasks and small syntax clarifications.
- **Stable baseline**: Many synthesis and style guides treat 1364-2005 as the Verilog baseline.

#### What 1364-2005 Adds or Clarifies Over 2001

- **Clarifications**: Scheduling, blocking vs nonblocking semantics, and generate behavior.
- **System tasks**: Additional or clarified tasks (e.g. `$realtime`, file I/O behavior).
- **Deprecations**: e.g. **defparam** is deprecated (use instantiation parameter override instead).
- **Attributes**: Clarified syntax and usage for tool-specific attributes.
- **No major new language features**: The big step to new features is 1800 (Module 4).

#### What 1364-2005 Still Does Not Include

- No **SystemVerilog**: no `logic`, `always_comb`/`always_ff`, interfaces, packages, classes, assertions (SVA).
- No **interfaces** or **type parameters** (those are 1800).

### 2. defparam Deprecation (2005)

**defparam** allows overriding parameters from outside the module hierarchy. It is deprecated in 1364-2005 because it can make design intent unclear and cause tool/synthesis issues.

#### Why defparam Is Deprecated

```verilog
// Deprecated: defparam (avoid in new code)
defparam u_block.u_sub.WIDTH = 16;
```

- **Problem**: Overrides a parameter deep in hierarchy from outside; hard to trace and tool-dependent.
- **Preferred**: Override at instantiation: `sub #(.WIDTH(16)) u_sub (...);`

#### Correct Practice: Parameter Override at Instantiation

```verilog
// Preferred: override at instantiation
block u_block (
    .clk(clk),
    .data_in(data_in)
);
// In block.v, instantiate: sub #(.WIDTH(16)) u_sub (...);
```

- **Recommendation**: Do not use defparam in new RTL; use named parameter override in the instantiation.

**Example**: `module3/examples/parameters/param_override.v`

### 3. Synthesizable Subset (1364-2005)

Not every 1364-2005 construct is synthesizable. Tools and style guides define a **synthesizable subset** that maps reliably to hardware.

#### Generally Synthesizable (RTL Subset)

- **Modules**: ANSI ports, parameter, localparam.
- **Nets and variables**: wire, reg (with correct usage).
- **assign**: Combinational logic; single driver per net.
- **always**: Combinational with `always @*`; sequential with `always @(posedge clk)` (or negedge) and nonblocking `<=`.
- **generate**: generate for, generate if/else for structure.
- **Operators**: Arithmetic, logical, bitwise, relational, shift, concatenation, conditional (`? :`).
- **case / casez / casex**: With care (full case, parallel case, or tool directives).
- **Tasks and functions**: Without delays; used for combinational or single-cycle helpers.
- **Signed**: signed types and $signed/$unsigned as supported by the tool.

#### Generally Not Synthesizable (or Tool-Specific)

- **Delays**: `#n` in RTL (used for testbenches only).
- **initial**: Except for initialization of reg/mem in FPGAs (tool-dependent).
- **Event controls**: `@(posedge clk)` is fine; complex event lists may not map.
- **Fork/join**: Usually testbench-only.
- **System tasks**: e.g. `$display`, `$finish` — testbench/simulation only.
- **Pure latch inference**: Unintended latches from incomplete case/if; use full case or default.

#### Best Practices for Synthesis (1364-2005)

- **Combinational**: Use `always @*` and blocking `=`; assign all outputs in all branches (or default) to avoid latches.
- **Sequential**: Use `always @(posedge clk)` (and optionally `negedge rst_n`) and nonblocking `<=`; do not mix blocking and nonblocking for the same variable.
- **One driver per net**: No multiple assign to the same wire; no multiple always driving the same reg in conflicting ways.
- **Avoid latches**: In combinational always, cover all cases or use a default assignment.

**Example**: `module3/examples/synthesizable/comb_seq_style.v`

### 4. Blocking vs Nonblocking (Clarified in 2005)

1364-2005 clarifies the semantics of blocking (`=`) and nonblocking (`<=`) assignments. Using them correctly is essential for predictable RTL and matching simulation to synthesis.

#### Rules of Thumb

- **Combinational always** (`always @*`): Use **blocking** `=`. Order of statements can matter (same simulation time step).
- **Sequential always** (`always @(posedge clk)`): Use **nonblocking** `<=`. Order does not matter within the block; updates occur at the end of the time step.
- **Do not mix** blocking and nonblocking for the same variable in the same always block.

```verilog
// Combinational: blocking
always @* begin
    y = a & b;
    z = y | c;   // y is already updated in this time step
end

// Sequential: nonblocking
always @(posedge clk) begin
    q1 <= d1;
    q2 <= q1;    // q2 gets OLD q1 (previous cycle)
end
```

**Example**: `module3/examples/procedural/blocking_nonblocking.v`

### 5. Full Case and Parallel Case (Synthesis Hints)

In 1364-2005 there are no built-in **unique** or **priority** keywords (those are SystemVerilog). Synthesis tools often support **attributes** or **pragmas** to indicate full case and parallel case.

#### full_case (Tool-Dependent)

- **Intent**: “Every possible case value is covered; no latch.”
- **Syntax**: Often an attribute, e.g. `(* full_case *)` or tool-specific comment.
- **Use**: When the designer guarantees all cases are covered (e.g. one-hot state encoding).

#### parallel_case (Tool-Dependent)

- **Intent**: “At most one case arm matches; can be implemented as parallel mux.”
- **Syntax**: Often an attribute, e.g. `(* parallel_case *)` or tool-specific.
- **Use**: When at most one branch is true (e.g. one-hot); misuse can hide bugs.

**Note**: In SystemVerilog (Module 4+), `unique case` and `priority case` provide standard semantics. In 1364-2005, rely on tool documentation for attribute syntax and behavior.

**Example**: `module3/examples/case_styles/case_full_parallel.v`

### 6. Summary: 1364 Evolution (1995 → 2001 → 2005)

A concise view of what each Verilog-only standard contributes:

| Feature / topic        | 1364-1995 | 1364-2001 | 1364-2005 |
|------------------------|-----------|-----------|-----------|
| Port style             | Non-ANSI  | ANSI      | ANSI      |
| Combinational always   | Explicit sensitivity | `always @*` | `always @*` |
| Generate               | No        | Yes       | Yes (clarified) |
| signed                 | No        | Yes       | Yes       |
| Multi-dim arrays       | No        | Yes       | Yes       |
| localparam             | No        | Yes       | Yes       |
| defparam               | Allowed   | Allowed   | Deprecated |
| Blocking/nonblocking   | Same      | Same      | Clarified |
| SystemVerilog          | No        | No        | No        |

- **Module 1**: 1364-1995 — Base language.
- **Module 2**: 1364-2001 — ANSI, @*, generate, signed, arrays, localparam.
- **Module 3**: 1364-2005 — Clarifications, deprecations, synthesizable subset; last Verilog-only.

### 7. When to Use 1364-2005 vs Move to 1800

- **Stay with 1364-2005** when: Project or tool flow is Verilog-only; legacy codebase; no need for interfaces, packages, or SVA.
- **Move to 1800** (Module 4+) when: You want `logic`, `always_comb`/`always_ff`, interfaces, packages, assertions, or other SystemVerilog design/verification features.

**Example**: `module3/README.md` (or course notes) can summarize “1364-2005 checklist” for a project.

## Examples

### Quick file reference

| Topic                 | Path                                  | Key files |
|-----------------------|---------------------------------------|-----------|
| Parameter override   | `module3/examples/parameters/`        | `param_override.v` |
| No defparam          | `module3/examples/no_defparam/`        | `no_defparam.v` |
| Synthesizable style  | `module3/examples/synthesizable/`     | `comb_seq_style.v` |
| One driver           | `module3/examples/one_driver/`         | `one_driver.v` |
| Blocking vs nonblocking | `module3/examples/procedural/`      | `blocking_nonblocking.v` |
| Pipeline             | `module3/examples/pipeline/`           | `pipeline.v` |
| Case styles          | `module3/examples/case_styles/`        | `case_full_parallel.v` |
| Avoid latch          | `module3/examples/avoid_latch/`        | `avoid_latch.v` |
| Synthesizable function | `module3/examples/function_synth/`   | `function_synth.v` |
| 1364-2005 summary    | `module3/examples/summary/`            | `summary_2005.v` |

### Module 3 Examples (1364-2005)

1. **Parameter Override** (`examples/parameters/`)
   - No defparam; override at instantiation only
   - **Key Concepts**: defparam deprecated; use `#(.PARAM(value))` at instantiation

2. **No defparam** (`examples/no_defparam/`)
   - Parameter passed through hierarchy (parent → child) at instantiation only
   - **Key Concepts**: No defparam anywhere; override only at inst

3. **Synthesizable Style** (`examples/synthesizable/`)
   - Combinational (always @*, blocking) and sequential (posedge clk, nonblocking)
   - **Key Concepts**: One driver per net; avoid latches; no delays in RTL

4. **One Driver** (`examples/one_driver/`)
   - Single assign to wire; single always driving reg
   - **Key Concepts**: No multiple drivers per net

5. **Blocking vs Nonblocking** (`examples/procedural/`)
   - Side-by-side combinational vs sequential blocks with correct assignment style
   - **Key Concepts**: = in combinational; <= in sequential; do not mix for same variable

6. **Pipeline** (`examples/pipeline/`)
   - Two-stage pipeline: q1 <= d; q2 <= q1 (nonblocking only)
   - **Key Concepts**: q2 gets old q1 (previous cycle); sequential block only

7. **Case Styles** (`examples/case_styles/`)
   - full_case / parallel_case attributes (or tool pragmas) where supported
   - **Key Concepts**: Synthesis hints only; 1364-2005 has no unique/priority case

8. **Avoid Latch** (`examples/avoid_latch/`)
   - Default before case; all paths assign output
   - **Key Concepts**: No latch from incomplete case/if

9. **Synthesizable Function** (`examples/function_synth/`)
   - Function without delays used in always @* (e.g. min)
   - **Key Concepts**: Combinational helper; no delays in RTL

10. **1364-2005 Summary** (`examples/summary/`)
    - Small design using only 1364-2005 features (no 1800)
    - **Key Concepts**: Checklist for “pure Verilog” RTL

## Design Under Test (DUT)

### 1364-2005 Compliant RTL (`module3/dut/`)

- **counter_2005.v**: Counter with parameter and localparam; no defparam
  - **Example**: Synthesizable subset; nonblocking in sequential block

- **fsm_2005.v**: Small FSM with case; optional full_case/parallel_case attribute
  - **Example**: Combinational next-state and output; sequential state register

- **param_chain.v**: Hierarchical parameter override (no defparam)
  - **Example**: Parameter passed through hierarchy via instantiation only

## Tests

### Module 3 Tests

- **test_counter_2005.v**: Counter test (reset, enable, wrap)
  - **Key Features**: 1364-2005 testbench; no SystemVerilog

- **test_fsm_2005.v**: FSM test (state coverage, transitions)
  - **Key Features**: Verilog-only; delay-based stimulus

- **test_param_chain.v**: Parameter propagation test
  - **Key Features**: Verifies parameter override at each level

## Learning Outcomes

By the end of this module, you should be able to:

- ✓ Describe what 1364-2005 adds or clarifies over 1364-2001 (no major new constructs)
- ✓ Avoid defparam and use instantiation parameter override only
- ✓ Apply the synthesizable subset of 1364-2005 (combinational vs sequential, one driver, no latches)
- ✓ Use blocking assignment in combinational always and nonblocking in sequential always
- ✓ Use tool-supported full_case/parallel_case (or equivalent) where appropriate
- ✓ Summarize 1364 evolution (1995 → 2001 → 2005) and when to stay Verilog-only vs adopt 1800

## Key Concepts

### 1364-2005 Role

- **Last Verilog-only standard**: Defines “pure” Verilog before 1800.
- **Clarifications over 2001**: Scheduling, blocking/nonblocking, generate; defparam deprecated.
- **Stable baseline**: Common choice for Verilog-only RTL and synthesis.

### Synthesizable Subset

- **Do**: assign, always @* (combinational), always @(posedge clk) (sequential), generate, parameter/localparam, signed.
- **Avoid in RTL**: Delays, initial (unless for FPGA init per tool), fork/join, system tasks; defparam; multiple drivers; unintended latches.

### Blocking vs Nonblocking

- **Combinational always**: Blocking `=`; order can matter within the block.
- **Sequential always**: Nonblocking `<=`; order does not matter; updates at end of time step.
- **Never**: Mix both for the same variable in one always block.

### defparam

- **Deprecated** in 1364-2005; do not use in new RTL.
- **Use**: Parameter override at instantiation: `module_name #(.PARAM(value)) inst (...);`

## Exercises

1. **Remove defparam**
   - Find or write a small design that uses defparam; replace with parameter override at instantiation.
   - Verify behavior in simulation.

2. **Synthesizable Checklist**
   - Take a 1364-2001 design and ensure it uses only the synthesizable subset (no delays, no initial in RTL, single driver, no latch).
   - Run synthesis (or lint) and fix any reported issues.

3. **Blocking vs Nonblocking**
   - Write a small pipeline (e.g. two stages): use nonblocking in sequential blocks; add a combinational block with blocking; confirm simulation matches intended behavior.

4. **Case and Latches**
   - Write a 4-to-1 mux with case; omit default and observe latch warning (if any).
   - Add default (or full case) and confirm latch is removed.

5. **1364-2005 Summary**
   - List three differences between 1364-1995 and 1364-2005 (using Modules 1–3).
   - List two reasons to stay with 1364-2005 and two reasons to move to 1800 (Module 4).

## Common Pitfalls and How to Avoid Them

1. **Using defparam in New Code**
   - **Mistake**: Overriding parameters with defparam for convenience.
   - **Reality**: defparam is deprecated in 1364-2005; tools may warn or restrict.
   - **Correct**: Override at instantiation: `sub #(.WIDTH(16)) u_sub (...);`
   - **Why**: Clear, hierarchical parameter flow; better for synthesis and maintenance.

2. **Mixing Blocking and Nonblocking for Same Variable**
   - **Mistake**: Using both `=` and `<=` for the same reg in one always block.
   - **Reality**: Leads to simulation/synthesis mismatch and race conditions.
   - **Correct**: Use only `=` in combinational always; only `<=` in sequential always for that variable.
   - **Why**: 1364-2005 semantics assume consistent use; mixing is undefined in practice.

3. **Assuming unique/priority case in 1364-2005**
   - **Mistake**: Writing `unique case` or `priority case` (SystemVerilog) and expecting 1364-2005 tools to support it.
   - **Reality**: Those keywords are in IEEE 1800, not 1364.
   - **Correct**: Use full_case/parallel_case attributes if the tool supports them; otherwise ensure full coverage and document intent.
   - **Why**: Avoids tool errors and clarifies design intent.

4. **Latches from Incomplete case/if**
   - **Mistake**: Combinational always with case or if that does not assign in all paths.
   - **Reality**: Synthesis infers a latch; simulation may hold previous value.
   - **Correct**: Assign default before case, or cover all cases; avoid incomplete if/else.
   - **Why**: Latches are rarely intended in synchronous RTL; explicit defaults avoid them.

5. **Using SystemVerilog in “1364-2005” Project**
   - **Mistake**: Using `logic`, `always_comb`, or interfaces while targeting “Verilog only.”
   - **Reality**: Those are 1800 (SystemVerilog); 1364-2005 does not define them.
   - **Correct**: Use wire/reg and always @* / always @(posedge clk) for strict 1364-2005.
   - **Why**: Keeps tool and project consistently on one standard.

## Next Steps

After completing this module, proceed to:

- **Module 4**: IEEE 1800-2005 (SystemVerilog design subset) — logic, always_comb/always_ff, interfaces, packages, and the first SystemVerilog standard

## Additional Resources

### Module Documentation

- **Module 3 README**: [module3/README.md](../module3/README.md) — directory structure, quick start, and file map
- **Module 2**: [docs/MODULE2.md](MODULE2.md) — IEEE 1364-2001 (prerequisite)
- **Module 4**: [docs/MODULE4.md](MODULE4.md) — IEEE 1800-2005 (next)

### Reference Materials

- **IEEE Std 1364-2005**: IEEE Standard for Verilog Hardware Description Language
- **IEEE Std 1364-2001**: For comparison (what 2005 clarifies or deprecates)
- **Synthesis guides**: Vendor documentation on synthesizable subset, full_case/parallel_case, and blocking/nonblocking

### Learning Path

1. **Start here**: Complete Module 3 examples using 1364-2005 only (no defparam, no SystemVerilog).
2. **Practice**: Convert or audit a 1364-2001 design for 1364-2005 (remove defparam, apply synthesizable subset).
3. **Compare**: Summarize 1995 vs 2001 vs 2005 in a short table or checklist.
4. **Prepare**: Note which 1800 features you want (logic, interfaces, etc.) before starting Module 4.

---

For questions or issues, refer to the main project documentation or the IEEE 1364-2005 standard for authoritative semantics.
