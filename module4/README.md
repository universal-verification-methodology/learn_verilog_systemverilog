# Module 4: IEEE 1800-2005 (SystemVerilog Design Subset)

This directory contains examples, DUTs, and tests for **IEEE Std 1800-2005** SystemVerilog design subset: logic, always_comb/always_ff, interfaces, packages, and unique/priority case.

## What you'll learn

- **logic**: Single-driver type (replaces wire/reg for most RTL); 4-state.
- **always_comb / always_ff / always_latch**: Explicit procedural blocks with tool checks (combinational, sequential, latch).
- **Interfaces and modports**: Bundle signals; define direction per role (master/slave); one object per connection.
- **Packages and import**: Shared types, constants, and functions; namespace and wildcard/specific import.
- **unique case / priority case**: Standard case semantics (at most one match, or first match wins); no tool-specific attributes.
- **Migration from 1364**: wire/reg→logic, always @*→always_comb, always @(posedge clk)→always_ff.

## Structure

```
module4/
├── examples/                    # 1800-2005 design examples (each has Makefile)
│   ├── data_types/              # logic, 2-state types
│   ├── logic_ports/             # all ports logic (mux, adder)
│   ├── procedural/              # always_comb, always_ff
│   ├── always_latch/             # always_latch (explicit latch)
│   ├── one_driver_logic/        # one assign, one always_ff per output
│   ├── typedef_sv/              # typedef in module
│   ├── interfaces/              # interface + modport (bus_if_example.sv)
│   ├── packages/                # package + import
│   ├── package_typedef/        # package with typedef and function
│   ├── case_unique_priority/   # unique case, priority case
│   ├── priority_case/           # priority case only (arbiter)
│   └── migration/               # 1364 vs 1800 style
├── dut/                         # SystemVerilog DUTs
│   ├── mux2_sv.sv               # logic, always_comb
│   ├── counter_sv.sv            # always_ff
│   ├── decoder_unique.sv        # unique case
│   ├── bus_if.sv                # interface definition
│   ├── bus_master.sv            # uses interface (modport master)
│   └── bus_slave.sv             # uses interface (modport slave)
├── tests/                       # Testbenches for DUTs
└── README.md
```

## File map (concept → location)

| Concept              | Example / DUT / Test                        |
|----------------------|---------------------------------------------|
| logic and 2-state    | `examples/data_types/logic_bit.sv`          |
| logic ports          | `examples/logic_ports/logic_ports.sv`       |
| always_comb / always_ff | `examples/procedural/always_comb_ff.sv`  |
| always_latch         | `examples/always_latch/always_latch.sv`     |
| One driver per logic | `examples/one_driver_logic/one_driver_logic.sv` |
| typedef              | `examples/typedef_sv/typedef_sv.sv`          |
| Interfaces           | `examples/interfaces/bus_if_example.sv`, `dut/bus_if.sv` |
| Packages             | `examples/packages/pkg_util.sv`             |
| Package + typedef    | `examples/package_typedef/package_typedef.sv` |
| unique / priority case | `examples/case_unique_priority/decoder.sv` |
| priority case only   | `examples/priority_case/priority_case.sv`   |
| Migration 1364→1800  | `examples/migration/migration.sv`           |
| DUT: mux             | `dut/mux2_sv.sv`                             |
| DUT: counter         | `dut/counter_sv.sv`                          |
| DUT: decoder         | `dut/decoder_unique.sv`                      |
| DUT: bus (if, master, slave) | `dut/bus_if.sv`, `bus_master.sv`, `bus_slave.sv` |
| Test: mux            | `tests/test_mux2_sv.sv`                     |
| Test: counter        | `tests/test_counter_sv.sv`                   |
| Test: decoder        | `tests/test_decoder_unique.sv`               |
| Test: bus            | `tests/test_bus_master_slave.sv`             |

## Quick start

**Requires**: Simulator with SystemVerilog support (e.g. Icarus Verilog with `-g2012`, Verilator, or ModelSim).

```bash
# From repo root: run all module4 examples and tests
./scripts/module4.sh

# Run only the testbenches (DUTs + tests)
cd module4/tests
make

# Run a single example (e.g. data types)
cd module4/examples/data_types
make run
```

Each `examples/*/` directory has a `Makefile`; use `make run` (or `make` where applicable) to compile and simulate.

**Note**: Icarus Verilog (iverilog) has partial SystemVerilog support. Use `-g2012` for `.sv` files. Interfaces and packages may require Verilator or a commercial simulator for full support.

## Documentation

- **Full module guide**: [docs/MODULE4.md](../docs/MODULE4.md) — topics, code snippets, exercises, pitfalls, and learning outcomes.

## 1800-2005 design subset (reminder)

- **logic**: Single-driver type (replaces wire/reg for most RTL).
- **always_comb**: Combinational; inferred sensitivity; no latch.
- **always_ff**: Sequential; one clock (and optional async reset); nonblocking only.
- **interface + modport**: Bundle signals; direction per role.
- **package + import**: Shared types, constants, functions.
- **unique / priority case**: Standard case semantics (no tool-specific attributes).

## Tips

- **logic** must have exactly one driver; use **wire** only when you need multiple drivers (e.g. tri-state).
- Use **always_comb** for combinational and **always_ff** for sequential; assign every output in every path in always_comb to avoid inferred latches.
- **Interfaces**: Define the interface once (e.g. `dut/bus_if.sv`); use modports (master/slave) so each module sees the correct directions.
- **Packages**: Use `import pkg::*;` or `import pkg::item;` before using package types or functions.
- **unique case**: Use only when at most one item can match; add **default** for catch-all; use **priority case** when first match wins.
