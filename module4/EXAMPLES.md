# Module 4 — Hands-on labs

Generated from `docs/MODULE4.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE4.md` → **How to Learn This Module**, then work through each lab in order.

## 1. logic and 2-State Types (`data_types/`)

**Folder:** `module4/examples/data_types/`

**What you'll learn:**
- logic for ports and internal single-driver signals
- Single driver for logic; 4-state

**Run:**

```bash
cd module4/examples/data_types
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/data_types/`.

## 2. logic Ports (`logic_ports/`)

**Folder:** `module4/examples/logic_ports/`

**What you'll learn:**
- All ports logic (mux, adder); no wire/reg choice
- assign and always_comb can drive output logic

**Run:**

```bash
cd module4/examples/logic_ports
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/logic_ports/`.

## 3. always_comb / always_ff (`procedural/`)

**Folder:** `module4/examples/procedural/`

**What you'll learn:**
- Combinational with always_comb; sequential with always_ff
- Explicit intent; tool checks; no latch in always_comb

**Run:**

```bash
cd module4/examples/procedural
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/procedural/`.

## 4. always_latch (`always_latch/`)

**Folder:** `module4/examples/always_latch/`

**What you'll learn:**
- Explicit latch when intended (e.g. transparent latch)
- Use when latch is desired; prefer always_comb/always_ff otherwise

**Run:**

```bash
cd module4/examples/always_latch
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/always_latch/`.

## 5. One Driver per logic (`one_driver_logic/`)

**Folder:** `module4/examples/one_driver_logic/`

**What you'll learn:**
- Single assign to one output; single always_ff to another
- logic must have exactly one driver

**Run:**

```bash
cd module4/examples/one_driver_logic
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/one_driver_logic/`.

## 6. typedef (`typedef_sv/`)

**Folder:** `module4/examples/typedef_sv/`

**What you'll learn:**
- typedef in module (e.g. byte_t = logic [7:0])
- User-defined types for clarity

**Run:**

```bash
cd module4/examples/typedef_sv
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/typedef_sv/`.

## 7. Interfaces and Modports (`interfaces/`)

**Folder:** `module4/examples/interfaces/`

**What you'll learn:**
- Interface definition, modports, connection in top
- One bundle per connection; direction per modport

**Run:**

```bash
cd module4/examples/interfaces
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/interfaces/`.

## 8. Packages and import (`packages/`)

**Folder:** `module4/examples/packages/`

**What you'll learn:**
- Package with types/params/functions; import in modules
- Namespace; wildcard vs specific import

**Run:**

```bash
cd module4/examples/packages
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/packages/`.

## 9. Package with typedef and function (`package_typedef/`)

**Folder:** `module4/examples/package_typedef/`

**What you'll learn:**
- Package with typedef and min_word function; import in ALU
- Shared types and helpers across modules

**Run:**

```bash
cd module4/examples/package_typedef
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/package_typedef/`.

## 10. unique / priority case (`case_unique_priority/`)

**Folder:** `module4/examples/case_unique_priority/`

**What you'll learn:**
- unique case (at most one match); priority case (first match)
- Standard semantics; synthesis and simulation behavior

**Run:**

```bash
cd module4/examples/case_unique_priority
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/case_unique_priority/`.

## 11. priority case only (`priority_case/`)

**Folder:** `module4/examples/priority_case/`

**What you'll learn:**
- Arbiter with priority case (first req wins)
- priority case for arbiter, interrupt mask

**Run:**

```bash
cd module4/examples/priority_case
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/priority_case/`.

## 12. Migration from 1364 (`migration/`)

**Folder:** `module4/examples/migration/`

**What you'll learn:**
- Same small design in 1364-2005 style vs 1800-2005 style
- wire/reg→logic, always @*→always_comb, always @(posedge clk)→always_ff

**Run:**

```bash
cd module4/examples/migration
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE4.md` and RTL under `module4/examples/migration/`.
