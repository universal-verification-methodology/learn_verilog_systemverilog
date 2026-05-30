# Module 5 — Hands-on labs

Generated from `docs/MODULE5.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE5.md` → **How to Learn This Module**, then work through each lab in order.

## 1. Operators (`operators/`)

**Folder:** `module5/examples/operators/`

**What you'll learn:**
- inside with ranges and sets; ==? wildcard (fallback for tools that lack inside)
- Set membership; don’t-care in comparison

**Run:**

```bash
cd module5/examples/operators
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/operators/`.

## 2. Wildcard Only (`wildcard_only/`)

**Folder:** `module5/examples/wildcard_only/`

**What you'll learn:**
- Dedicated ==? wildcard equality (X/Z as don't care)
- Wildcard match in RTL/testbench

**Run:**

```bash
cd module5/examples/wildcard_only
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/wildcard_only/`.

## 3. Range Check (`range_check/`)

**Folder:** `module5/examples/range_check/`

**What you'll learn:**
- Range membership (e.g. value inside [0:127]); fallback to explicit comparison if needed
- `inside` with ranges; 2009/2012 operator use

**Run:**

```bash
cd module5/examples/range_check
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/range_check/`.

## 4. Arrays (`arrays/`)

**Folder:** `module5/examples/arrays/`

**What you'll learn:**
- Fixed memory with parameterized DEPTH/WIDTH; 2012 array semantics
- Array indexing; synthesis-safe subset

**Run:**

```bash
cd module5/examples/arrays
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/arrays/`.

## 5. Array Param (`array_param/`)

**Folder:** `module5/examples/array_param/`

**What you'll learn:**
- Parameterized memory using $clog2(DEPTH) for address width
- Parameterized arrays; 2012 clarifications

**Run:**

```bash
cd module5/examples/array_param
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/array_param/`.

## 6. Checkers (`checkers/`)

**Folder:** `module5/examples/checkers/`

**What you'll learn:**
- Immediate assertion (e.g. one-hot) using $countones or similar
- assert in design; immediate assertion in RTL

**Run:**

```bash
cd module5/examples/checkers
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/checkers/`.

## 7. Assert Valid Encoding (`assert_valid_encoding/`)

**Folder:** `module5/examples/assert_valid_encoding/`

**What you'll learn:**
- Immediate assertion for valid opcode/encoding
- Invariant checking; assert for valid encodings

**Run:**

```bash
cd module5/examples/assert_valid_encoding
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/assert_valid_encoding/`.

## 8. Assert Invariant (`assert_invariant/`)

**Folder:** `module5/examples/assert_invariant/`

**What you'll learn:**
- Immediate assertion for one-hot grant (e.g. arbiter)
- One-hot invariant; assert in RTL

**Run:**

```bash
cd module5/examples/assert_invariant
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/assert_invariant/`.

## 9. Summary (`summary/`)

**Folder:** `module5/examples/summary/`

**What you'll learn:**
- Comparison of 2005 vs 2009/2012 features in a small design
- Backward compatibility; when to adopt new features

**Run:**

```bash
cd module5/examples/summary
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE5.md` and RTL under `module5/examples/summary/`.
