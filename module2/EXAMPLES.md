# Module 2 — Hands-on labs

Generated from `docs/MODULE2.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE2.md` → **How to Learn This Module**, then work through each lab in order.

## 1. ANSI Ports (`ansi_ports/`)

**Folder:** `module2/examples/ansi_ports/`

**What you'll learn:**
- Module and instantiation with ANSI-style ports
- Port direction and type in port list

**Run:**

```bash
cd module2/examples/ansi_ports
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/ansi_ports/`.

## 2. always @* (`procedural/`)

**Folder:** `module2/examples/procedural/`

**What you'll learn:**
- Combinational blocks with implicit sensitivity
- No manual sensitivity list; tool infers from RHS

**Run:**

```bash
cd module2/examples/procedural
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/procedural/`.

## 3. Generate (`generate/`)

**Folder:** `module2/examples/generate/`

**What you'll learn:**
- Parameterized mux; generate-style parameterization
- genvar, elaboration-time logic

**Run:**

```bash
cd module2/examples/generate
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/generate/`.

## 4. Generate if/else (`generate_if/`)

**Folder:** `module2/examples/generate_if/`

**What you'll learn:**
- Conditional implementation by parameter (e.g. USE_CLIP wrap vs saturate)
- generate if/else at elaboration

**Run:**

```bash
cd module2/examples/generate_if
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/generate_if/`.

## 5. Generate Ripple Adder (`generate_ripple_adder/`)

**Folder:** `module2/examples/generate_ripple_adder/`

**What you'll learn:**
- N-bit ripple-carry adder using generate for (full_adder instances)
- genvar loop, replicated hierarchy

**Run:**

```bash
cd module2/examples/generate_ripple_adder
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/generate_ripple_adder/`.

## 6. Signed (`signed/`)

**Folder:** `module2/examples/signed/`

**What you'll learn:**
- signed reg/wire, $signed/$unsigned
- Two's complement arithmetic in RTL

**Run:**

```bash
cd module2/examples/signed
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/signed/`.

## 7. Signed vs Unsigned Comparison (`signed_compare/`)

**Folder:** `module2/examples/signed_compare/`

**What you'll learn:**
- $signed() in expressions; a &lt; b unsigned vs signed
- Cast in expressions without changing declaration

**Run:**

```bash
cd module2/examples/signed_compare
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/signed_compare/`.

## 8. Decoder (`decoder/`)

**Folder:** `module2/examples/decoder/`

**What you'll learn:**
- 2:4 decoder with ANSI ports and always @* (case)
- Combinational case; one-hot output

**Run:**

```bash
cd module2/examples/decoder
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/decoder/`.

## 9. Multi-Dimensional Arrays (`arrays/`)

**Folder:** `module2/examples/arrays/`

**What you'll learn:**
- Memory-style arrays (reg [7:0] mem [0:255]), indexing
- Packed vs unpacked; array indexing rules in 2001

**Run:**

```bash
cd module2/examples/arrays
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/arrays/`.

## 10. Multi-Dim Style (`multi_dim_arrays/`)

**Folder:** `module2/examples/multi_dim_arrays/`

**What you'll learn:**
- 2x4 buffer using 1D array indexed as row*4+col
- Emulating 2D with 1D array; index expression

**Run:**

```bash
cd module2/examples/multi_dim_arrays
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/multi_dim_arrays/`.

## 11. Parameters and localparam (`parameters/`)

**Folder:** `module2/examples/parameters/`

**What you'll learn:**
- Parameter override, localparam for derived constants
- When to use parameter vs localparam

**Run:**

```bash
cd module2/examples/parameters
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/parameters/`.

## 12. ANSI Task/Function (`tasks_functions/`)

**Folder:** `module2/examples/tasks_functions/`

**What you'll learn:**
- Input/output in header, automatic functions
- 2001 style vs 1995 style

**Run:**

```bash
cd module2/examples/tasks_functions
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/tasks_functions/`.

## 13. ANSI Task with Output (`task_ansi/`)

**Folder:** `module2/examples/task_ansi/`

**What you'll learn:**
- task automatic apply_reset(output reg rn); begin/end body
- Task with output argument; testbench reset pattern

**Run:**

```bash
cd module2/examples/task_ansi
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE2.md` and RTL under `module2/examples/task_ansi/`.
