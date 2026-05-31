        # Narration script — Module 8: Quick Reference and Course Summary

        **Target length:** ~20 minutes (41 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 8 | 0:25 | Welcome to module 8, Quick Reference and Course Summary. In this module you will provide a single quick reference and course summary for verilog and systemverilog across ieee versions (1364-1995 through 1800-2017).. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Provide a single quick reference and course summary for Verilog and SystemVerilog across IEEE versions (1364-1995 through 1800-2017). |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Provide a single quick reference and course summary for Verilog and SystemVerilog across IEEE versions (1364-1995 through 1800-2017). |
| 5 | Overview | 0:16 | Overview. This module is a reference and summary for the version-centric Verilog/SystemVerilog course (Modules 1–7). It does not introduce new... |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path (1/2) | 0:32 | Follow this learning path. Read the guides before running the labs. Skim this document — Goal, Overview, and Topics Covered set the IEEE scope for Module 8. Study design architecture — See how DUTs, examples, and testbenches fit together under module8/. Work through labs in order — Open module8/EXAMPLES.md and run each make clean && make run from the repo root. Run the full module script —... |
| 8 | Suggested learning path (2/2) | 0:24 | Follow this learning path. Read the guides before running the labs. Use as reference — Module 8 summarizes the full course; run examples to print quick-reference slices, not to learn new RTL. Review Common Pitfalls — Can you explain each mistake and the fix? Self-check — Use module8/CHECKLIST.md before starting the next module. From docs/MODULE8.md — read guides before running demos. |
| 9 | Design architecture | 0:08 | Next section: Design architecture. |
| 10 | 1. Reference module layout (module8/) | 0:38 | 1. Reference module layout (module8/). No new language — consolidates Modules 1–7 into quick-reference tables examples/ print version timelines, migration reminders, tool notes Use after completing the course or as a lookup during real projects scripts/module8.sh — runs reference printouts, not new RTL lessons Refer to the diagram on the right. |
| 11 | 2. Course map architecture | 0:38 | 2. Course map architecture. Module 1–3 — Verilog-only path (1995, 2001, 2005) Module 4–6 — SystemVerilog design path (2005, 2009/12, 2017) Module 7 — comparison and migration between standards Module 8 — this reference layer on top of the version stack Refer to the diagram on the right. |
| 12 | 3. How reference examples execute | 0:34 | 3. How reference examples execute. Most labs $display tables or cheat-sheet rows to stdout No new DUT hierarchy — output is documentation you can grep Pair with docs/MODULE8.md for full tables Refer to the diagram on the right. |
| 13 | One-page course map | 0:28 | One-page course map. Review the code on screen and match it to files in the repository. |
| 14 | Installation & execution | 0:08 | Next section: Installation & execution. |
| 15 | How to run this module | 0:32 | How to run this module. From repo root: ./scripts/module8.sh --check — validate environment ./scripts/module8.sh --demo — print demo commands to run locally ./scripts/module8.sh --scaffold — create ~/unix_practice/ exercise files Open module8/EXAMPLES.md — run each numbered lab in your terminal Track progress with module8/CHECKLIST.md before moving on From MODULE8 — execution and artifact layout. |
| 16 | Key files to study | 0:08 | Next section: Key files to study. |
| 17 | Open these in the repo | 0:32 | Open these in the repo. docs/MODULE8.md — master reference tables module8/examples/version_timeline/ module8/examples/migration_steps/ module8/examples/course_map/ scripts/module8.sh Trace while running module8/EXAMPLES.md labs. |
| 18 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 19 | 1. Using Module 8 as closure | 0:34 | 1. Using Module 8 as closure. Run ./scripts/module8.sh once to print all reference slices Cross-check “which standard has X?” against printed tables Bookmark slides.pdf and MODULE8.md for day-to-day lookup Refer to the diagram on the right. |
| 20 | 2. When to re-run labs | 0:30 | 2. When to re-run labs. Re-run a specific Module 1–7 example when you need hands-on refresh Module 8 examples confirm you know where to find detail, not replace it Refer to the diagram on the right. |
| 21 | Version timeline printer | 0:28 | Version timeline printer. Review the code on screen and match it to files in the repository. |
| 22 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 23 | 1. Version Timeline (One Table) | 0:16 | 1. Version Timeline (One Table). See docs/MODULE8.md |
| 24 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 25 | Module 8 toolchain check | 0:45 | Module 8 toolchain check. Watch the terminal output and confirm you see the expected pass message. Requires iverilog on PATH (apt install iverilog). |
| 26 | Demo: One-page cheat sheet (version timeline, subsets, migra | 0:45 | Demo: One-page cheat sheet (version timeline, subsets, migration, version selection). Watch the terminal output and confirm you see the expected pass message. |
| 27 | Demo: Version timeline (standard, year, role, module) | 0:45 | Demo: Version timeline (standard, year, role, module). Watch the terminal output and confirm you see the expected pass message. |
| 28 | Demo: Verilog-only vs SystemVerilog design subset (ports, ty | 0:45 | Demo: Verilog-only vs SystemVerilog design subset (ports, types, comb/seq, when to use). Watch the terminal output and confirm you see the expected pass message. |
| 29 | Demo: Tool support summary (simulators, synthesis, lint, for | 0:45 | Demo: Tool support summary (simulators, synthesis, lint, formal; Icarus, Verilator, commercial). Watch the terminal output and confirm you see the expected pass message. |
| 30 | Demo: "Which standard has X?" for key constructs (logic, alw | 0:45 | Demo: "Which standard has X?" for key constructs (logic, always_comb, interface, etc.). Watch the terminal output and confirm you see the expected pass message. |
| 31 | Demo: Course map (Modules 1–8 with title and content summary | 0:45 | Demo: Course map (Modules 1–8 with title and content summary). Watch the terminal output and confirm you see the expected pass message. |
| 32 | Demo: Migration steps (1995→2001, 1364→1800, 1800→1800) and | 0:45 | Demo: Migration steps (1995→2001, 1364→1800, 1800→1800) and rules of thumb. Watch the terminal output and confirm you see the expected pass message. |
| 33 | Demo: Synthesizable do/avoid (assign, always_comb/@*, single | 0:45 | Demo: Synthesizable do/avoid (assign, always_comb/@*, single driver; avoid delays, defparam, latches). Watch the terminal output and confirm you see the expected pass message. |
| 34 | Demo: Version selection (match tools/IP, state one revision | 0:45 | Demo: Version selection (match tools/IP, state one revision and subset, document). Watch the terminal output and confirm you see the expected pass message. |
| 35 | Demo: Learning path (1→…→6, then 7; use 8 as reference) and | 0:45 | Demo: Learning path (1→…→6, then 7; use 8 as reference) and where to go next. Watch the terminal output and confirm you see the expected pass message. |
| 36 | Demo: Common pitfalls quick reference (construct table, subs | 0:45 | Demo: Common pitfalls quick reference (construct table, subset rule, regression, tool support, Module 8 as reference). Watch the terminal output and confirm you see the expected pass message. |
| 37 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 38 | What you should know | 0:32 | By now you should be able to explain the following. ✓ Use the version timeline and construct-by-standard table to look up “which standard has X?” ✓ Use the design-subset quick reference to choose Verilog-only vs SystemVerilog design ✓ Use the migration quick reference and Module 7 checklists for migration and version selection ✓ Use the course map to find which module covers a given standard... |
| 39 | Exercises | 0:32 | Exercises. Lookup Subset Migration Course map Cheat sheet |
| 40 | Exercises | 0:32 | Exercises. Assuming a construct is in an older standard Mixing subsets without a rule Skipping regression after migration Forgetting tool support Treating this module as a replacement for Modules 1–7 |
| 41 | Summary & next steps | 0:28 | In summary: Provide a single quick reference and course summary for Verilog and SystemVerilog across IEEE versions (1364-1995 through 1800-2017). Next up: Next module in course. Provide a single quick reference and course summary for Verilog and SystemVerilog across IEEE versions (1364-1995 through 1800-2017). Complete module8/CHECKLIST.md Review module8/EXAMPLES.md and run each lab Next: Next... |

        ## Section narration (edit for TTS)

        - **How to learn:** Skim this document — Goal, Overview, and Topics Covered set the IEEE scope for Module 8. Then Study design architecture — See how DUTs, examples, and testbenches fit together under `module8/`. Then Work through labs in order — Open `module8/EXAMPLES.md` and run each `make clean && make run` from the repo root. Then Run the full module script — `./scripts/module8.sh` from the repo root to simulate all examples and tests..
- **Design architecture (Reference module layout (module8/), Course map architecture, How reference examples execute):** Walk through the block diagram, then relate each block to files under module8/examples/.
- **Verification (Using Module 8 as closure, When to re-run labs):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 8 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module8/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE8.md` and `module8/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 8`
