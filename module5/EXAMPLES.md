# Module 5 — Hands-on labs

Generated from `docs/MODULE5.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE5.md` → **How to Learn This Module**, then work through each lab in order.

## 1. `inside` with ranges and sets; `==?` wildcard (fallback for tools that lack `inside`) (`operators/`)

**Folder:** `module5/examples/operators/`

**What you'll learn:**
- Set membership; don’t-care in comparison

**Run:**

```bash
cd module5/examples/operators
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/operators/`.

## 2. Dedicated `==?` wildcard equality (X/Z as don't care) (`wildcard_only/`)

**Folder:** `module5/examples/wildcard_only/`

**What you'll learn:**
- Wildcard match in RTL/testbench

**Run:**

```bash
cd module5/examples/wildcard_only
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/wildcard_only/`.

## 3. Range membership (e.g. value inside `[0:127]`); fallback to explicit comparison if needed (`range_check/`)

**Folder:** `module5/examples/range_check/`

**What you'll learn:**
- `inside` with ranges; 2009/2012 operator use

**Run:**

```bash
cd module5/examples/range_check
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/range_check/`.

## 4. Fixed memory with parameterized DEPTH/WIDTH; 2012 array semantics (`arrays/`)

**Folder:** `module5/examples/arrays/`

**What you'll learn:**
- Array indexing; synthesis-safe subset

**Run:**

```bash
cd module5/examples/arrays
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/arrays/`.

## 5. Parameterized memory using `$clog2(DEPTH)` for address width (`array_param/`)

**Folder:** `module5/examples/array_param/`

**What you'll learn:**
- Parameterized arrays; 2012 clarifications

**Run:**

```bash
cd module5/examples/array_param
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/array_param/`.

## 6. Immediate assertion (e.g. one-hot) using `$countones` or similar (`checkers/`)

**Folder:** `module5/examples/checkers/`

**What you'll learn:**
- assert in design; immediate assertion in RTL

**Run:**

```bash
cd module5/examples/checkers
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/checkers/`.

## 7. Immediate assertion for valid opcode/encoding (`assert_valid_encoding/`)

**Folder:** `module5/examples/assert_valid_encoding/`

**What you'll learn:**
- Invariant checking; assert for valid encodings

**Run:**

```bash
cd module5/examples/assert_valid_encoding
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/assert_valid_encoding/`.

## 8. Immediate assertion for one-hot grant (e.g. arbiter) (`assert_invariant/`)

**Folder:** `module5/examples/assert_invariant/`

**What you'll learn:**
- One-hot invariant; assert in RTL

**Run:**

```bash
cd module5/examples/assert_invariant
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/assert_invariant/`.

## 9. Comparison of 2005 vs 2009/2012 features in a small design (`summary/`)

**Folder:** `module5/examples/summary/`

**What you'll learn:**
- Backward compatibility; when to adopt new features

**Run:**

```bash
cd module5/examples/summary
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/summary/`.
