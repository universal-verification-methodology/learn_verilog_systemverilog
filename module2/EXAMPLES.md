# Module 2 — Hands-on labs

Generated from `docs/MODULE2.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE2.md` → **How to Learn This Module**, then work through each lab in order.

## 1. Module and instantiation with ANSI-style ports (`ansi_ports/`)

**Folder:** `module2/examples/ansi_ports/`

**What you'll learn:**
- Port direction and type in port list

**Run:**

```bash
cd module2/examples/ansi_ports
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/ansi_ports/`.

## 2. Combinational blocks with implicit sensitivity (`procedural/`)

**Folder:** `module2/examples/procedural/`

**What you'll learn:**
- No manual sensitivity list; tool infers from RHS

**Run:**

```bash
cd module2/examples/procedural
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/procedural/`.

## 3. Parameterized mux; generate-style parameterization (`generate/`)

**Folder:** `module2/examples/generate/`

**What you'll learn:**
- genvar, elaboration-time logic

**Run:**

```bash
cd module2/examples/generate
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/generate/`.

## 4. Conditional implementation by parameter (e.g. USE_CLIP wrap vs saturate) (`generate_if/`)

**Folder:** `module2/examples/generate_if/`

**What you'll learn:**
- generate if/else at elaboration

**Run:**

```bash
cd module2/examples/generate_if
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/generate_if/`.

## 5. N-bit ripple-carry adder using generate for (full_adder instances) (`generate_ripple_adder/`)

**Folder:** `module2/examples/generate_ripple_adder/`

**What you'll learn:**
- genvar loop, replicated hierarchy

**Run:**

```bash
cd module2/examples/generate_ripple_adder
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/generate_ripple_adder/`.

## 6. signed reg/wire, $signed/$unsigned (`signed/`)

**Folder:** `module2/examples/signed/`

**What you'll learn:**
- Two's complement arithmetic in RTL

**Run:**

```bash
cd module2/examples/signed
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/signed/`.

## 7. $signed() in expressions; a &lt; b unsigned vs signed (`signed_compare/`)

**Folder:** `module2/examples/signed_compare/`

**What you'll learn:**
- Cast in expressions without changing declaration

**Run:**

```bash
cd module2/examples/signed_compare
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/signed_compare/`.

## 8. 2:4 decoder with ANSI ports and always @* (case) (`decoder/`)

**Folder:** `module2/examples/decoder/`

**What you'll learn:**
- Combinational case; one-hot output

**Run:**

```bash
cd module2/examples/decoder
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/decoder/`.

## 9. Memory-style arrays (reg [7:0] mem [0:255]), indexing (`arrays/`)

**Folder:** `module2/examples/arrays/`

**What you'll learn:**
- Packed vs unpacked; array indexing rules in 2001

**Run:**

```bash
cd module2/examples/arrays
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/arrays/`.

## 10. 2x4 buffer using 1D array indexed as row*4+col (`multi_dim_arrays/`)

**Folder:** `module2/examples/multi_dim_arrays/`

**What you'll learn:**
- Emulating 2D with 1D array; index expression

**Run:**

```bash
cd module2/examples/multi_dim_arrays
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/multi_dim_arrays/`.

## 11. Parameter override, localparam for derived constants (`parameters/`)

**Folder:** `module2/examples/parameters/`

**What you'll learn:**
- When to use parameter vs localparam

**Run:**

```bash
cd module2/examples/parameters
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/parameters/`.

## 12. Input/output in header, automatic functions (`tasks_functions/`)

**Folder:** `module2/examples/tasks_functions/`

**What you'll learn:**
- 2001 style vs 1995 style

**Run:**

```bash
cd module2/examples/tasks_functions
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/tasks_functions/`.

## 13. task automatic apply_reset(output reg rn); begin/end body (`task_ansi/`)

**Folder:** `module2/examples/task_ansi/`

**What you'll learn:**
- Task with output argument; testbench reset pattern

**Run:**

```bash
cd module2/examples/task_ansi
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/task_ansi/`.
