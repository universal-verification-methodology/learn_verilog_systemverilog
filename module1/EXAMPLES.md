# Module 1 — Hands-on labs

Generated from `docs/MODULE1.md` for slides, PDF, and video.
Run commands from the **course repository root** unless noted.

**Before you start:** Read `docs/MODULE1.md` → **How to Learn This Module**, then work through each lab in order.

## 1. Modules and Ports (`modules_ports/`)

**Folder:** `module1/examples/modules_ports/`

**What you'll learn:**
- 1995-style module declaration and port list
- Named and positional instantiation
- Non-ANSI ports, separate direction/type declarations

**Run:**

```bash
cd module1/examples/modules_ports
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/modules_ports/`.

## 2. Nets and Variables (`nets_variables/`)

**Folder:** `module1/examples/nets_variables/`

**What you'll learn:**
- wire vs reg, vectors, 4-state values
- When to use wire vs reg, single driver per net

**Run:**

```bash
cd module1/examples/nets_variables
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/nets_variables/`.

## 3. Continuous Assignment (`continuous_assign/`)

**Folder:** `module1/examples/continuous_assign/`

**What you'll learn:**
- assign for combinational logic (2:1 mux)
- Left-hand side must be net; expression on right

**Run:**

```bash
cd module1/examples/continuous_assign
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/continuous_assign/`.

## 4. Continuous Assignment Gates (`continuous_assign_gates/`)

**Folder:** `module1/examples/continuous_assign_gates/`

**What you'll learn:**
- XOR, NAND, NOR with assign
- Same as above; multiple gates in one example

**Run:**

```bash
cd module1/examples/continuous_assign_gates
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/continuous_assign_gates/`.

## 5. Adder (`adder/`)

**Folder:** `module1/examples/adder/`

**What you'll learn:**
- Half adder and full adder with assign (sum and carry)
- Multi-output combinational logic; wire for all outputs

**Run:**

```bash
cd module1/examples/adder
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/adder/`.

## 6. Procedural Blocks (`procedural/`)

**Folder:** `module1/examples/procedural/`

**What you'll learn:**
- always @(inputs) and always @(posedge clk) with explicit sensitivity
- initial for testbench; 1995-style task/function
- No `always @*`; blocking vs nonblocking

**Run:**

```bash
cd module1/examples/procedural
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/procedural/`.

## 7. Sequential D Flip-Flop (`sequential_dff/`)

**Folder:** `module1/examples/sequential_dff/`

**What you'll learn:**
- D flip-flop with async reset: always @(posedge clk or negedge rst_n) and <=
- Edge-sensitive always; nonblocking for sequential logic

**Run:**

```bash
cd module1/examples/sequential_dff
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/sequential_dff/`.

## 8. Delays and Timing (`delays_timing/`)

**Folder:** `module1/examples/delays_timing/`

**What you'll learn:**
- #n, @(posedge clk), wait(condition); clock generation with forever
- Delay-based and event-based timing in testbenches

**Run:**

```bash
cd module1/examples/delays_timing
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/delays_timing/`.

## 9. Testbenches (`testbenches/`)

**Folder:** `module1/examples/testbenches/`

**What you'll learn:**
- Minimal testbench with initial, #, $display, $finish
- Stimulus generation, termination with `$finish`

**Run:**

```bash
cd module1/examples/testbenches
make clean && make run
```

**You should see:** Simulation completes without errors; check `$display` output or PASS messages in the log.

**Go deeper:** Full context in `docs/MODULE1.md` and RTL under `module1/examples/testbenches/`.
