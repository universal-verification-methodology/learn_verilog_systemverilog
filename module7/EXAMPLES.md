# Module 7 — Hands-on labs

Generated from `docs/MODULE7.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE7.md` → **How to Learn This Module**, then work through each lab in order.

## 1. Same 2:1 mux in 1364-1995, 1364-2001, 1364-2005, 1800-2005 (and optionally 1800-2017) (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- Port style, type, procedural block, one driver

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 2. Same counter in 1995, 2001, 2005, 1800-2005 (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- Sequential block, reset, parameter/localparam

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 3. Same 2:4 decoder in 1995, 2001, 2005, 1800; case vs unique case (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- Port style, always @(sel) vs @* vs always_comb, unique case

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 4. Same 8-bit adder in 1995, 2001, 2005, 1800 (continuous assign) (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- wire vs logic; assign unchanged across versions

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 5. Same parameterized shift in 1364 (parameter/localparam) vs 1800 (parameter int) (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- parameter int, localparam int; same behavior

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 6. Same master/slave connection: many ports (1364) (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- Port list size, direction, reuse; interface (1800) optional per tool

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 7. Before/after: wire/reg, always @* vs logic, always_comb, unique case (`migration/`)

**Folder:** `module7/examples/migration/`

**What you'll learn:**
- Order of steps, testing, regression

**Run:**

```bash
cd module7/examples/migration
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/migration/`.

## 8. Before: non-ANSI, @(a or b or sel). After: ANSI, always @* (`migration_1995_to_2001/`)

**Folder:** `module7/examples/migration_1995_to_2001/`

**What you'll learn:**
- ANSI ports, implicit sensitivity

**Run:**

```bash
cd module7/examples/migration_1995_to_2001
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/migration_1995_to_2001/`.

## 9. Same 4:1 mux: 1364 case+default vs 1800 unique case (`case_versions/`)

**Folder:** `module7/examples/case_versions/`

**What you'll learn:**
- case semantics; unique case for tool checking

**Run:**

```bash
cd module7/examples/case_versions
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/case_versions/`.

## 10. Single reference: construct vs standard (1995–2017) (`version_table/`)

**Folder:** `module7/examples/version_table/`

**What you'll learn:**
- When each feature was introduced; minimum revision

**Run:**

```bash
cd module7/examples/version_table
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/version_table/`.

## 11. Runnable reminder of version-selection checklist (constraints, decision, document) (`version_selection/`)

**Folder:** `module7/examples/version_selection/`

**What you'll learn:**
- See MODULE7.md for full checklist

**Run:**

```bash
cd module7/examples/version_selection
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/version_selection/`.

## 12. Same D flip-flop in 1995, 2001, 2005, 1800 (sequential block style) (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- always @(posedge clk) vs always_ff; wire/reg vs logic

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 13. Same tiny FSM in 1364 vs 1800 (case vs unique case, always_ff) (`side_by_side/`)

**Folder:** `module7/examples/side_by_side/`

**What you'll learn:**
- Sequential FSM; 1800 always_ff and unique case

**Run:**

```bash
cd module7/examples/side_by_side
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/side_by_side/`.

## 14. Runnable reminder of 1364→1800 migration steps (pre, per-module, post) (`migration_checklist/`)

**Folder:** `module7/examples/migration_checklist/`

**What you'll learn:**
- See MODULE7.md for full migration checklist

**Run:**

```bash
cd module7/examples/migration_checklist
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/migration_checklist/`.

## 15. Two steps: step1 1364 style, step2 1800 style; same mux, compare outputs (`incremental_migration/`)

**Folder:** `module7/examples/incremental_migration/`

**What you'll learn:**
- Migrate one construct at a time; test after each step

**Run:**

```bash
cd module7/examples/incremental_migration
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/incremental_migration/`.

## 16. Same 2:1 mux: non-ANSI (1995) vs ANSI (2001) ports only (`port_style_compare/`)

**Folder:** `module7/examples/port_style_compare/`

**What you'll learn:**
- Port declaration style; no other change

**Run:**

```bash
cd module7/examples/port_style_compare
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/port_style_compare/`.

## 17. 1364-2005: parameter override at instantiation #(.WIDTH(n)); avoid defparam (`no_defparam/`)

**Folder:** `module7/examples/no_defparam/`

**What you'll learn:**
- defparam deprecated; use instantiation override

**Run:**

```bash
cd module7/examples/no_defparam
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/no_defparam/`.
