# Module 1: IEEE 1364-1995 (Verilog-95)

This directory contains examples, DUTs, and tests for **IEEE Std 1364-1995 (Verilog-95)** — the first standardized Verilog language.

## What you'll learn

- **Modules and hierarchy**: 1995-style port list and declarations, instantiation
- **Nets and variables**: `wire` vs `reg`, when to use each, 4-state values
- **Combinational logic**: `assign` and `always @(inputs)` with explicit sensitivity
- **Sequential logic**: `always @(posedge clk)` and nonblocking assignment
- **Testbenches**: `initial`, delays (`#`), events (`@`), `$display`, `$finish`
- **Tasks and functions**: Non-ANSI 1995 form (ports declared inside body)

## Structure

```
module1/
├── examples/                    # IEEE 1364-1995 examples (each has Makefile)
│   ├── modules_ports/           # Module declaration, ports, instantiation
│   ├── nets_variables/          # wire, reg, vectors
│   ├── continuous_assign/       # assign statements (mux2_1995)
│   ├── continuous_assign_gates/ # XOR, NAND, NOR with assign
│   ├── adder/                   # Half adder, full adder with assign
│   ├── procedural/              # always, initial, task/function (1995 style)
│   ├── sequential_dff/          # D flip-flop (always @(posedge clk))
│   ├── delays_timing/           # #, @(posedge clk), wait(condition)
│   └── testbenches/             # Simple testbenches
├── dut/                         # Design Under Test (1364-1995 only)
│   └── simple_gates/            # and_gate.v, or_gate.v, not_gate.v
├── tests/                       # Testbenches + mux2_1995.v for test_mux2
└── README.md                    # This file
```

## File map (concept → location)

| Concept              | Example / DUT / Test                    |
|----------------------|----------------------------------------|
| Modules & ports      | `examples/modules_ports/and_gate.v`     |
| wire vs reg          | `examples/nets_variables/data_types.v` |
| assign (mux)         | `examples/continuous_assign/mux2.v`     |
| assign (gates)       | `examples/continuous_assign_gates/gates.v` |
| Adder                | `examples/adder/adder.v`               |
| always / initial     | `examples/procedural/always_initial.v` |
| Task/function 1995   | `examples/procedural/task_function_1995.v` |
| D flip-flop          | `examples/sequential_dff/dff.v`        |
| Delays & timing      | `examples/delays_timing/timing.v`      |
| Simple testbench     | `examples/testbenches/test_and_gate.v` |
| DUT: AND/OR/NOT      | `dut/simple_gates/*.v`                 |
| Test: AND gate       | `tests/test_and_gate.v`                |
| Test: 2:1 mux        | `tests/test_mux2.v` (+ `tests/mux2_1995.v`) |

## Quick start

**Requires**: [Icarus Verilog](http://iverilog.icarus.com/) (`iverilog`) or a compatible simulator.

```bash
# From repo root: run all module1 examples and tests
./scripts/module1.sh

# Run only the testbenches (DUTs + tests)
cd module1/tests
make

# Run a single example (e.g. modules and ports)
cd module1/examples/modules_ports
make run
```

Each `examples/*/` directory has a `Makefile`; use `make run` (or `make` where applicable) to compile and simulate.

## Documentation

- **Full module guide**: [docs/MODULE1.md](../docs/MODULE1.md) — topics, code snippets, exercises, pitfalls, and learning outcomes.

## 1364-1995 rules (reminder)

- **Ports**: Non-ANSI — port list names only; direction and type declared inside module body.
- **Sensitivity**: Explicit only — e.g. `always @(a or b or sel)`; no `always @*`.
- **Types**: `wire` for nets; `reg` for procedural outputs.
- **No**: ANSI ports, `always @*`, generate, signed, `logic`, interfaces, packages.

## Tips

- If a test fails, ensure the simulator is using 1995-compatible options (e.g. no 2001/SystemVerilog extensions).
- For combinational `always` blocks, list every input in the sensitivity list to avoid inferred latches.
- Use **named** port connections when instantiating (e.g. `.a(in1), .b(in2), .y(out)`) for readability.
