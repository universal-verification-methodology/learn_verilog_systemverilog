# Module 3 — Hands-on labs

Generated from `docs/MODULE3.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE3.md` → **How to Learn This Module**, then work through each lab in order.

## 1. No defparam; override at instantiation only (`parameters/`)

**Folder:** `module3/examples/parameters/`

**What you'll learn:**
- defparam deprecated; use `#(.PARAM(value))` at instantiation

**Run:**

```bash
cd module3/examples/parameters
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/parameters/`.

## 2. Parameter passed through hierarchy (parent → child) at instantiation only (`no_defparam/`)

**Folder:** `module3/examples/no_defparam/`

**What you'll learn:**
- No defparam anywhere; override only at inst

**Run:**

```bash
cd module3/examples/no_defparam
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/no_defparam/`.

## 3. Combinational (always @*, blocking) and sequential (posedge clk, nonblocking) (`synthesizable/`)

**Folder:** `module3/examples/synthesizable/`

**What you'll learn:**
- One driver per net; avoid latches; no delays in RTL

**Run:**

```bash
cd module3/examples/synthesizable
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/synthesizable/`.

## 4. Single assign to wire; single always driving reg (`one_driver/`)

**Folder:** `module3/examples/one_driver/`

**What you'll learn:**
- No multiple drivers per net

**Run:**

```bash
cd module3/examples/one_driver
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/one_driver/`.

## 5. Side-by-side combinational vs sequential blocks with correct assignment style (`procedural/`)

**Folder:** `module3/examples/procedural/`

**What you'll learn:**
- = in combinational; <= in sequential; do not mix for same variable

**Run:**

```bash
cd module3/examples/procedural
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/procedural/`.

## 6. Two-stage pipeline: q1 <= d; q2 <= q1 (nonblocking only) (`pipeline/`)

**Folder:** `module3/examples/pipeline/`

**What you'll learn:**
- q2 gets old q1 (previous cycle); sequential block only

**Run:**

```bash
cd module3/examples/pipeline
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/pipeline/`.

## 7. full_case / parallel_case attributes (or tool pragmas) where supported (`case_styles/`)

**Folder:** `module3/examples/case_styles/`

**What you'll learn:**
- Synthesis hints only; 1364-2005 has no unique/priority case

**Run:**

```bash
cd module3/examples/case_styles
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/case_styles/`.

## 8. Default before case; all paths assign output (`avoid_latch/`)

**Folder:** `module3/examples/avoid_latch/`

**What you'll learn:**
- No latch from incomplete case/if

**Run:**

```bash
cd module3/examples/avoid_latch
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/avoid_latch/`.

## 9. Function without delays used in always @* (e.g. min) (`function_synth/`)

**Folder:** `module3/examples/function_synth/`

**What you'll learn:**
- Combinational helper; no delays in RTL

**Run:**

```bash
cd module3/examples/function_synth
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/function_synth/`.

## 10. Small design using only 1364-2005 features (no 1800) (`summary/`)

**Folder:** `module3/examples/summary/`

**What you'll learn:**
- Checklist for “pure Verilog” RTL

**Run:**

```bash
cd module3/examples/summary
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE3.md` and RTL under `module3/examples/summary/`.
