        # Narration script — Module 7: Version Comparison and Migration

        **Target length:** ~33 minutes (75 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 7 | 0:25 | Welcome to module 7, Version Comparison and Migration. In this module you will compare verilog and systemverilog across ieee versions side-by-side, plan migration between standards, and choose the right version for your project and tools.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Compare Verilog and SystemVerilog across IEEE versions side-by-side, plan migration between standards, and choose the right version for... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Compare Verilog and SystemVerilog across IEEE versions side-by-side, plan migration between standards, and choose the right version for... |
| 5 | Overview | 0:16 | Overview. This module ties together Modules 1–6 by comparing the same design across standards (1364-1995 through 1800-2017), outlining migration... |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path (1/2) | 0:32 | Follow this learning path. Read the guides before running the labs. Skim this document — Goal, Overview, and Topics Covered set the IEEE scope for Module 7. Study design architecture — See how DUTs, examples, and testbenches fit together under module7/. Work through labs in order — Open module7/EXAMPLES.md and run each make clean && make run from the repo root. Run the full module script —... |
| 8 | Suggested learning path (2/2) | 0:24 | Follow this learning path. Read the guides before running the labs. Compare side-by-side — Open 1364 and 1800 versions of the same design and note port style, types, and procedural blocks. Review Common Pitfalls — Can you explain each mistake and the fix? Self-check — Use module7/CHECKLIST.md before starting the next module. From docs/MODULE7.md — read guides before running demos. |
| 9 | Design architecture | 0:08 | Next section: Design architecture. |
| 10 | 1. Repository layout (module7/) (1/2) | 0:38 | 1. Repository layout (module7/) (1/2). Side-by-side 1364 vs 1800 versions of the same designs module7/dut/ — mux2_1364.v and mux2_1800.sv for direct comparison examples/side_by_side/ — decoder, counter, FSM migration pairs examples/migration/ — step-by-step 1995 → 2017 patterns Refer to the diagram on the right. |
| 11 | 1. Repository layout (module7/) (2/2) | 0:16 | 1. Repository layout (module7/) (2/2). scripts/module7.sh — runs comparison and migration labs |
| 12 | 2. Side-by-side comparison architecture | 0:38 | 2. Side-by-side comparison architecture. Same behavior, different syntax — ports, types, procedural blocks 1364: wire/reg, always @(a or b), many scalar ports 1800: logic, always_comb/ff, optional interface for bus bundles Testbench can instantiate both versions and compare outputs Refer to the diagram on the right. |
| 13 | 3. Migration workflow | 0:38 | 3. Migration workflow. Inventory features used — match to target standard checklist Migrate ports first (ANSI, logic), then procedural blocks, then connectivity Simulate after each step — do not big-bang rewrite Document project standard and tool support decision Refer to the diagram on the right. |
| 14 | RTL block diagram (reference) | 0:22 | RTL block diagram (reference). Module 7: DUT hierarchy and signal flow. |
| 15 | Verification / testbench diagram (reference) | 0:22 | Verification / testbench diagram (reference). Module 7: stimulus, observation, and checking. |
| 16 | 1364 mux — wire/reg and explicit sensitivity | 0:28 | 1364 mux — wire/reg and explicit sensitivity. Review the code on screen and match it to files in the repository. |
| 17 | 1800 mux — logic and always_comb | 0:28 | 1800 mux — logic and always_comb. Review the code on screen and match it to files in the repository. |
| 18 | Execution & simulation flow | 0:08 | Next section: Execution & simulation flow. |
| 19 | How the example runs (toolchain) | 0:32 | How the example runs (toolchain). Match each bullet to files in the repository. Makefile: Verilator compiles RTL + SystemVerilog testbench into a C++ model sim_main.cpp: generates clk/rst_n, calls eval() until $finish Directed test (initial block or C++): drive stimulus, wait for DUT flags Self-check: compare outputs; print PASS/FAIL (see terminal demo slide) Repo path... |
| 20 | Key files to study | 0:08 | Next section: Key files to study. |
| 21 | Open these in the repo | 0:32 | Open these in the repo. module7/dut/mux2_1364.v and mux2_1800.sv module7/examples/side_by_side/mux2_versions/ module7/examples/migration_checklist/ module7/examples/incremental_migration/ scripts/module7.sh Trace while running module7/EXAMPLES.md labs. |
| 22 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 23 | 1. Comparison test execution | 0:34 | 1. Comparison test execution. test_mux2_all.sv — same stimulus on 1364 and 1800 mux; compare y test_counter_all.sv — reset/enable/wrap behavior must match ./scripts/module7.sh runs all migration and comparison examples Refer to the diagram on the right. |
| 24 | 2. Migration validation | 0:30 | 2. Migration validation. After each migration step: make run must pass with identical outputs Use migration_checklist example as a template for real projects Refer to the diagram on the right. |
| 25 | Migration checklist pattern | 0:28 | Migration checklist pattern. Review the code on screen and match it to files in the repository. |
| 26 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 27 | Protocol & design details | 0:08 | Next section: Protocol & design details. |
| 28 | 1. Side-by-Side Comparison: Same Design Across Versions | 0:20 | 1. Side-by-Side Comparison: Same Design Across Versions. Example: 2:1 Multiplexer What Changes Across Versions |
| 29 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 30 | Module 7 toolchain check | 0:45 | Module 7 toolchain check. Watch the terminal output and confirm you see the expected pass message. Requires iverilog on PATH (apt install iverilog). |
| 31 | Example 1: Same 2:1 mux in 1364-1995, 1364-2001, 1364-2005, | 0:16 | Example 1: Same 2:1 mux in 1364-1995, 1364-2001, 1364-2005, 1800-2005 (and optionally 1800-2017). Port style, type, procedural block, one driver module7/examples/side_by_side/README.md |
| 32 | Demo: Same 2:1 mux in 1364-1995, 1364-2001, 1364-2005, 1800- | 0:45 | Demo: Same 2:1 mux in 1364-1995, 1364-2001, 1364-2005, 1800-2005 (and optionally 1800-2017). Watch the terminal output and confirm you see the expected pass message. |
| 33 | Example 2: Same counter in 1995, 2001, 2005, 1800-2005 | 0:16 | Example 2: Same counter in 1995, 2001, 2005, 1800-2005. Sequential block, reset, parameter/localparam module7/examples/side_by_side/README.md |
| 34 | Demo: Same counter in 1995, 2001, 2005, 1800-2005 | 0:45 | Demo: Same counter in 1995, 2001, 2005, 1800-2005. Watch the terminal output and confirm you see the expected pass message. |
| 35 | Example 3: Same 2:4 decoder in 1995, 2001, 2005, 1800; case | 0:16 | Example 3: Same 2:4 decoder in 1995, 2001, 2005, 1800; case vs unique case. Port style, always @(sel) vs @* vs always_comb, unique case module7/examples/side_by_side/README.md |
| 36 | Demo: Same 2:4 decoder in 1995, 2001, 2005, 1800; case vs un | 0:45 | Demo: Same 2:4 decoder in 1995, 2001, 2005, 1800; case vs unique case. Watch the terminal output and confirm you see the expected pass message. |
| 37 | Example 4: Same 8-bit adder in 1995, 2001, 2005, 1800 (conti | 0:16 | Example 4: Same 8-bit adder in 1995, 2001, 2005, 1800 (continuous assign). wire vs logic; assign unchanged across versions module7/examples/side_by_side/README.md |
| 38 | Demo: Same 8-bit adder in 1995, 2001, 2005, 1800 (continuous | 0:45 | Demo: Same 8-bit adder in 1995, 2001, 2005, 1800 (continuous assign). Watch the terminal output and confirm you see the expected pass message. |
| 39 | Example 5: Same parameterized shift in 1364 (parameter/local | 0:16 | Example 5: Same parameterized shift in 1364 (parameter/localparam) vs 1800 (parameter int). parameter int, localparam int; same behavior module7/examples/side_by_side/README.md |
| 40 | Demo: Same parameterized shift in 1364 (parameter/localparam | 0:45 | Demo: Same parameterized shift in 1364 (parameter/localparam) vs 1800 (parameter int). Watch the terminal output and confirm you see the expected pass message. |
| 41 | Example 6: Same master/slave connection: many ports (1364) | 0:16 | Example 6: Same master/slave connection: many ports (1364). Port list size, direction, reuse; interface (1800) optional per tool module7/examples/side_by_side/README.md |
| 42 | Demo: Same master/slave connection: many ports (1364) | 0:45 | Demo: Same master/slave connection: many ports (1364). Watch the terminal output and confirm you see the expected pass message. |
| 43 | Example 7: Before/after: wire/reg, always @* vs logic, alway | 0:16 | Example 7: Before/after: wire/reg, always @* vs logic, always_comb, unique case. Order of steps, testing, regression module7/examples/migration/README.md |
| 44 | Demo: Before/after: wire/reg, always @* vs logic, always_com | 0:45 | Demo: Before/after: wire/reg, always @* vs logic, always_comb, unique case. Watch the terminal output and confirm you see the expected pass message. |
| 45 | Example 8: Before: non-ANSI, @(a or b or sel). After: ANSI, | 0:16 | Example 8: Before: non-ANSI, @(a or b or sel). After: ANSI, always @*. ANSI ports, implicit sensitivity module7/examples/migration_1995_to_2001/README.md |
| 46 | Demo: Before: non-ANSI, @(a or b or sel). After: ANSI, alway | 0:45 | Demo: Before: non-ANSI, @(a or b or sel). After: ANSI, always @*. Watch the terminal output and confirm you see the expected pass message. |
| 47 | Example 9: Same 4:1 mux: 1364 case+default vs 1800 unique ca | 0:16 | Example 9: Same 4:1 mux: 1364 case+default vs 1800 unique case. case semantics; unique case for tool checking module7/examples/case_versions/README.md |
| 48 | Demo: Same 4:1 mux: 1364 case+default vs 1800 unique case | 0:45 | Demo: Same 4:1 mux: 1364 case+default vs 1800 unique case. Watch the terminal output and confirm you see the expected pass message. |
| 49 | Example 10: Single reference: construct vs standard (1995–20 | 0:16 | Example 10: Single reference: construct vs standard (1995–2017). When each feature was introduced; minimum revision module7/examples/version_table/README.md |
| 50 | Demo: Single reference: construct vs standard (1995–2017) | 0:45 | Demo: Single reference: construct vs standard (1995–2017). Watch the terminal output and confirm you see the expected pass message. |
| 51 | Example 11: Runnable reminder of version-selection checklist | 0:16 | Example 11: Runnable reminder of version-selection checklist (constraints, decision, document). See MODULE7.md for full checklist module7/examples/version_selection/README.md |
| 52 | Demo: Runnable reminder of version-selection checklist (cons | 0:45 | Demo: Runnable reminder of version-selection checklist (constraints, decision, document). Watch the terminal output and confirm you see the expected pass message. |
| 53 | Example 12: Same D flip-flop in 1995, 2001, 2005, 1800 (sequ | 0:16 | Example 12: Same D flip-flop in 1995, 2001, 2005, 1800 (sequential block style). always @(posedge clk) vs always_ff; wire/reg vs logic module7/examples/side_by_side/README.md |
| 54 | Demo: Same D flip-flop in 1995, 2001, 2005, 1800 (sequential | 0:45 | Demo: Same D flip-flop in 1995, 2001, 2005, 1800 (sequential block style). Watch the terminal output and confirm you see the expected pass message. |
| 55 | Example 13: Same tiny FSM in 1364 vs 1800 (case vs unique ca | 0:16 | Example 13: Same tiny FSM in 1364 vs 1800 (case vs unique case, always_ff). Sequential FSM; 1800 always_ff and unique case module7/examples/side_by_side/README.md |
| 56 | Demo: Same tiny FSM in 1364 vs 1800 (case vs unique case, al | 0:45 | Demo: Same tiny FSM in 1364 vs 1800 (case vs unique case, always_ff). Watch the terminal output and confirm you see the expected pass message. |
| 57 | Example 14: Runnable reminder of 1364→1800 migration steps ( | 0:16 | Example 14: Runnable reminder of 1364→1800 migration steps (pre, per-module, post). See MODULE7.md for full migration checklist module7/examples/migration_checklist/README.md |
| 58 | Demo: Runnable reminder of 1364→1800 migration steps (pre, p | 0:45 | Demo: Runnable reminder of 1364→1800 migration steps (pre, per-module, post). Watch the terminal output and confirm you see the expected pass message. |
| 59 | Example 15: Two steps: step1 1364 style, step2 1800 style; s | 0:16 | Example 15: Two steps: step1 1364 style, step2 1800 style; same mux, compare outputs. Migrate one construct at a time; test after each step module7/examples/incremental_migration/README.md |
| 60 | Demo: Two steps: step1 1364 style, step2 1800 style; same mu | 0:45 | Demo: Two steps: step1 1364 style, step2 1800 style; same mux, compare outputs. Watch the terminal output and confirm you see the expected pass message. |
| 61 | Example 16: Same 2:1 mux: non-ANSI (1995) vs ANSI (2001) por | 0:16 | Example 16: Same 2:1 mux: non-ANSI (1995) vs ANSI (2001) ports only. Port declaration style; no other change module7/examples/port_style_compare/README.md |
| 62 | Demo: Same 2:1 mux: non-ANSI (1995) vs ANSI (2001) ports onl | 0:45 | Demo: Same 2:1 mux: non-ANSI (1995) vs ANSI (2001) ports only. Watch the terminal output and confirm you see the expected pass message. |
| 63 | Example 17: 1364-2005: parameter override at instantiation # | 0:16 | Example 17: 1364-2005: parameter override at instantiation #(.WIDTH(n)); avoid defparam. defparam deprecated; use instantiation override module7/examples/no_defparam/README.md |
| 64 | Demo: 1364-2005: parameter override at instantiation #(.WIDT | 0:45 | Demo: 1364-2005: parameter override at instantiation #(.WIDTH(n)); avoid defparam. Watch the terminal output and confirm you see the expected pass message. |
| 65 | Common pitfalls | 0:08 | Next section: Common pitfalls. |
| 66 | Migrating Everything at Once | 0:28 | Migrating Everything at Once. Mistake: Converting a large codebase from 1364 to 1800 in one big change. Reality: Hard to debug; regressions are difficult to isolate. Correct: Migrate incrementally (one module or one feature at a time); run regression after each step. Why: Reduces risk and keeps a clear baseline. |
| 67 | Ignoring Tool Support | 0:28 | Ignoring Tool Support. Mistake: Choosing 1800-2017 and using constructs the synthesis or simulator does not support. Reality: Compile or elaboration errors; or tool-specific behavior. Correct: Check tool manuals for supported revision and synthesizable subset; align RTL with that. Why: Ensures the project builds and matches tool expectations. |
| 68 | Breaking Interfaces During Migration | 0:28 | Breaking Interfaces During Migration. Mistake: Changing port list or interface of a block while migrating its internals, so that other modules break. Reality: Large ripple of changes; integration failures. Correct: Keep external interface (ports or interface modport) unchanged during internal migration; change only implementation (lo Why: Limits scope of change and preserves compatibility with... |
| 69 | Mixing Revisions in One File | 0:28 | Mixing Revisions in One File. Mistake: Using 1995 ports in one module and 1800 logic in another in the same file without a clear rule. Reality: Confusing for readers and tools; possible tool-dependent behavior. Correct: Use one project standard per file (or per project); document the standard in the style guide. Why: Consistency and predictable tool behavior. |
| 70 | Forgetting to Test After Migration | 0:28 | Forgetting to Test After Migration. Mistake: Changing syntax (e.g. wire→logic, always @*→always_comb) and not re-running simulation or synthesis. Reality: Subtle bugs (e.g. latch, wrong sensitivity) can appear. Correct: Run full regression (simulation and synthesis) after every migration step; compare with baseline. Why: Catches functional or synthesis differences early. |
| 71 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 72 | What you should know | 0:36 | By now you should be able to explain the following. ✓ Compare the same design across 1364-1995, 1364-2001, 1364-2005, and 1800 (design subset) and list what changes ✓ Compare connectivity style: many ports (1364) vs interface (1800) ✓ Plan and execute migration from 1364 to 1800 design subset (or between 1364 revisions) using the migration patterns and checklist ✓ Choose a project standard... |
| 73 | Exercises | 0:32 | Exercises. Side-by-Side Mux Side-by-Side Connectivity Migration One Block Version Selection Version Table |
| 74 | Exercises | 0:32 | Exercises. Migrating Everything at Once Ignoring Tool Support Breaking Interfaces During Migration Mixing Revisions in One File Forgetting to Test After Migration |
| 75 | Summary & next steps | 0:28 | In summary: Compare Verilog and SystemVerilog across IEEE versions side-by-side, plan migration between standards, and choose the right version for your project and tools. Next up: Next module in course. Compare Verilog and SystemVerilog across IEEE versions side-by-side, plan migration between standards, and choose the right version for... Complete module7/CHECKLIST.md Review... |

        ## Section narration (edit for TTS)

        - **How to learn:** Skim this document — Goal, Overview, and Topics Covered set the IEEE scope for Module 7. Then Study design architecture — See how DUTs, examples, and testbenches fit together under `module7/`. Then Work through labs in order — Open `module7/EXAMPLES.md` and run each `make clean && make run` from the repo root. Then Run the full module script — `./scripts/module7.sh` from the repo root to simulate all examples and tests..
- **Design architecture (Repository layout (module7/), Side-by-side comparison architecture, Migration workflow):** Walk through the block diagram, then relate each block to files under module7/examples/.
- **Verification (Comparison test execution, Migration validation):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 8 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module7/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE7.md` and `module7/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 7`
