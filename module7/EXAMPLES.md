# Module 7 — Hands-on labs

Generated from `docs/MODULE7.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE7.md` → **How to Learn This Module**, then work through each lab in order.

## 7. Migration 1364→1800 (`migration/`)

**Folder:** `module7/examples/migration/`

**What you'll learn:**
- Before/after: wire/reg, always @* vs logic, always_comb, unique case
- Order of steps, testing, regression

**Run:**

```bash
cd module7/examples/migration
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/migration/`.

## 8. Migration 1995→2001 (`migration_1995_to_2001/`)

**Folder:** `module7/examples/migration_1995_to_2001/`

**What you'll learn:**
- Before: non-ANSI, @(a or b or sel). After: ANSI, always @*
- ANSI ports, implicit sensitivity

**Run:**

```bash
cd module7/examples/migration_1995_to_2001
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/migration_1995_to_2001/`.

## 9. Case Versions (`case_versions/`)

**Folder:** `module7/examples/case_versions/`

**What you'll learn:**
- Same 4:1 mux: 1364 case+default vs 1800 unique case
- case semantics; unique case for tool checking

**Run:**

```bash
cd module7/examples/case_versions
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/case_versions/`.

## 10. Version Table (`version_table/`)

**Folder:** `module7/examples/version_table/`

**What you'll learn:**
- Single reference: construct vs standard (1995–2017)
- When each feature was introduced; minimum revision

**Run:**

```bash
cd module7/examples/version_table
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/version_table/`.

## 11. Version Selection (`version_selection/`)

**Folder:** `module7/examples/version_selection/`

**What you'll learn:**
- Runnable reminder of version-selection checklist (constraints, decision, document)
- See MODULE7.md for full checklist
- Same D flip-flop in 1995, 2001, 2005, 1800 (sequential block style)
- always @(posedge clk) vs always_ff; wire/reg vs logic
- Same tiny FSM in 1364 vs 1800 (case vs unique case, always_ff)
- Sequential FSM; 1800 always_ff and unique case

**Run:**

```bash
cd module7/examples/version_selection
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/version_selection/`.

## 14. Migration Checklist (`migration_checklist/`)

**Folder:** `module7/examples/migration_checklist/`

**What you'll learn:**
- Runnable reminder of 1364→1800 migration steps (pre, per-module, post)
- See MODULE7.md for full migration checklist

**Run:**

```bash
cd module7/examples/migration_checklist
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/migration_checklist/`.

## 15. Incremental Migration (`incremental_migration/`)

**Folder:** `module7/examples/incremental_migration/`

**What you'll learn:**
- Two steps: step1 1364 style, step2 1800 style; same mux, compare outputs
- Migrate one construct at a time; test after each step

**Run:**

```bash
cd module7/examples/incremental_migration
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/incremental_migration/`.

## 16. Port Style Compare (`port_style_compare/`)

**Folder:** `module7/examples/port_style_compare/`

**What you'll learn:**
- Same 2:1 mux: non-ANSI (1995) vs ANSI (2001) ports only
- Port declaration style; no other change

**Run:**

```bash
cd module7/examples/port_style_compare
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/port_style_compare/`.

## 17. No defparam (`no_defparam/`)

**Folder:** `module7/examples/no_defparam/`

**What you'll learn:**
- 1364-2005: parameter override at instantiation #(.WIDTH(n)); avoid defparam
- defparam deprecated; use instantiation override

**Run:**

```bash
cd module7/examples/no_defparam
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE7.md` and RTL under `module7/examples/no_defparam/`.
