# Module 6 — Hands-on labs

Generated from `docs/MODULE6.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE6.md` → **How to Learn This Module**, then work through each lab in order.

## 1. Verilog vs SystemVerilog Subset (`subsets/`)

**Folder:** `module6/examples/subsets/`

**What you'll learn:**
- Same small design: one file using only 1364-style (wire/reg, always @*), one using 1800 design (logic, always_comb/always_ff)
- 1364 subset vs 1800 design subset within 1800-2017

**Run:**

```bash
cd module6/examples/subsets
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/subsets/`.

## 2. Design Constructs Recap (`design_recap/`)

**Folder:** `module6/examples/design_recap/`

**What you'll learn:**
- One module using logic, always_comb, always_ff, package, unique case (all 1800-2017 compliant)
- Current standard design subset in one place

**Run:**

```bash
cd module6/examples/design_recap
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/design_recap/`.

## 3. Immediate Assertion in RTL (`assertions/`)

**Folder:** `module6/examples/assertions/`

**What you'll learn:**
- Simple invariant (e.g. one-hot state) with assert in design
- Synthesizable RTL + assertion; 2017 semantics

**Run:**

```bash
cd module6/examples/assertions
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/assertions/`.

## 4. Version Comparison (`version_summary/`)

**Folder:** `module6/examples/version_summary/`

**What you'll learn:**
- Table or script that lists which construct belongs to which standard (1995–2017)
- Full version timeline; choosing a standard

**Run:**

```bash
cd module6/examples/version_summary
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/version_summary/`.

## 5. Migration (`migration/`)

**Folder:** `module6/examples/migration/`

**What you'll learn:**
- Same 4:1 mux in 1364-2005 style vs 1800-2017 style (wire/reg→logic, always @*→always_comb, unique case)
- Step-by-step migration from 1364 to 1800 design subset

**Run:**

```bash
cd module6/examples/migration
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/migration/`.

## 6. Logic Single Driver (`logic_single_driver/`)

**Folder:** `module6/examples/logic_single_driver/`

**What you'll learn:**
- Comb and seq blocks; each logic has exactly one driver (2017 clarified)
- Single driver for logic; assign, always_comb, always_ff

**Run:**

```bash
cd module6/examples/logic_single_driver
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/logic_single_driver/`.

## 7. Priority Case (`priority_case/`)

**Folder:** `module6/examples/priority_case/`

**What you'll learn:**
- Priority encoder using priority case (first match wins)
- priority case; 2017 semantics for encoders/arbiters

**Run:**

```bash
cd module6/examples/priority_case
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/priority_case/`.

## 8. Package and Import (`package_import/`)

**Folder:** `module6/examples/package_import/`

**What you'll learn:**
- Shared types and parameters in package; import in module and top
- Package and import; 2017 scope and search order clarifications

**Run:**

```bash
cd module6/examples/package_import
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/package_import/`.

## 9. Unique Case (`unique_case/`)

**Folder:** `module6/examples/unique_case/`

**What you'll learn:**
- Decoder with unique case and default (no latch)
- unique case; at most one match; 2017 clarified

**Run:**

```bash
cd module6/examples/unique_case
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE6.md` and RTL under `module6/examples/unique_case/`.
