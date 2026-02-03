# Module 2: IEEE 1364-2001 (Verilog-2001)

This directory contains examples, DUTs, and tests for **IEEE Std 1364-2001 (Verilog-2001)** — ANSI ports, `always @*`, generate, signed types, and related 2001 features.

## What you'll learn

- **ANSI-style ports**: Direction and type in the port list (no separate declarations)
- **always @***: Implicit sensitivity for combinational logic (no manual list)
- **generate**: Conditional and loop-based instantiation (`generate for`, `generate if/else`)
- **signed types**: Signed arithmetic, `$signed`/`$unsigned`, two's complement
- **Multi-dimensional arrays**: e.g. `reg [7:0] mem [0:255]` for memories
- **localparam**: Constants that cannot be overridden at instantiation
- **ANSI tasks/functions**: Input/output in the header (2001 style)

## Structure

```
module2/
├── examples/                    # IEEE 1364-2001 examples (each has Makefile)
│   ├── ansi_ports/              # ANSI-style port declarations (mux2)
│   ├── procedural/              # always @* (implicit sensitivity)
│   ├── generate/               # parameterized mux (generate)
│   ├── generate_if/             # generate if/else (USE_CLIP)
│   ├── generate_ripple_adder/   # N-bit ripple-carry adder (generate for)
│   ├── signed/                  # signed reg/wire, $signed/$unsigned
│   ├── signed_compare/          # signed vs unsigned comparison
│   ├── decoder/                 # 2:4 decoder (ANSI, always @*)
│   ├── arrays/                  # Simple RAM (reg [7:0] mem [0:255])
│   ├── multi_dim_arrays/       # 2x4-style buffer (index row*4+col)
│   ├── parameters/             # parameter, localparam
│   ├── tasks_functions/        # ANSI-style function
│   └── task_ansi/               # ANSI-style task with output
├── dut/                         # Design Under Test (1364-2001)
│   ├── mux_2to1_param.v         # Parameterized 2:1 mux
│   ├── dff.v                    # D flip-flop (for shift_reg_gen)
│   ├── shift_reg_gen.v          # Shift register (generate for)
│   └── counter_param.v          # Counter with localparam
├── tests/                       # Testbenches for DUTs
└── README.md                    # This file
```

## File map (concept → location)

| Concept              | Example / DUT / Test                         |
|----------------------|----------------------------------------------|
| ANSI ports           | `examples/ansi_ports/mux2.v`                 |
| always @*             | `examples/procedural/always_star.v`           |
| generate              | `examples/generate/param_mux.v`              |
| generate if/else      | `examples/generate_if/gen_if.v`               |
| Generate ripple adder| `examples/generate_ripple_adder/ripple_adder.v` |
| Signed                | `examples/signed/adder_signed.v`              |
| Signed vs unsigned    | `examples/signed_compare/signed_compare.v`    |
| Decoder               | `examples/decoder/decoder.v`                  |
| Multi-dim arrays      | `examples/arrays/ram_simple.v`                |
| Multi-dim style       | `examples/multi_dim_arrays/multi_dim.v`       |
| Parameters/localparam | `examples/parameters/counter_param.v`        |
| ANSI task/function    | `examples/tasks_functions/ansi_task_func.v`    |
| ANSI task with output | `examples/task_ansi/task_ansi.v`              |
| DUT: param mux        | `dut/mux_2to1_param.v`                        |
| DUT: shift reg        | `dut/shift_reg_gen.v` (+ `dut/dff.v`)         |
| DUT: counter          | `dut/counter_param.v`                         |
| Test: mux             | `tests/test_mux_param.v`                     |
| Test: shift reg       | `tests/test_shift_reg_gen.v`                  |
| Test: counter         | `tests/test_counter_param.v`                  |

## Quick start

**Requires**: [Icarus Verilog](http://iverilog.icarus.com/) (`iverilog`) or a compatible simulator.

```bash
# From repo root: run all module2 examples and tests
./scripts/module2.sh

# Run only the testbenches (DUTs + tests)
cd module2/tests
make

# Run a single example (e.g. ANSI ports)
cd module2/examples/ansi_ports
make run
```

Each `examples/*/` directory has a `Makefile`; use `make run` (or `make` where applicable) to compile and simulate.

## Documentation

- **Full module guide**: [docs/MODULE2.md](../docs/MODULE2.md) — topics, code snippets, exercises, pitfalls, and learning outcomes.

## 1364-2001 features (reminder)

- **Ports**: ANSI style — direction and type in port list.
- **Sensitivity**: `always @*` for combinational logic.
- **Generate**: `generate for` with genvar; `generate if/else`.
- **Types**: `signed` reg/wire; multi-dimensional arrays.
- **Constants**: `localparam` (not overridable).
- **Tasks/Functions**: ANSI style (input/output in header).
- **No**: SystemVerilog (`logic`, `always_comb`, interfaces, packages).

## Tips

- Prefer `always @*` for combinational logic to avoid incomplete sensitivity lists; use `always @(posedge clk)` for sequential logic only.
- Use **genvar** only inside `generate for`; use **integer** or **reg** for runtime loops in `always`/`initial`.
- **localparam** cannot be overridden at instantiation; use **parameter** for values that need to be configured.
- For signed arithmetic, be explicit: use `signed` types or `$signed`/`$unsigned` and verify with testbenches.
