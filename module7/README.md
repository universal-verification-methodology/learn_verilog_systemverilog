# Module 7: Version Comparison and Migration

This directory contains side-by-side examples, DUTs, and tests for **comparing Verilog/SystemVerilog across IEEE versions** and **migration patterns** (1364-1995 through 1800-2017).

## What you'll learn

- **Side-by-side comparison**: Same design (mux, counter, decoder, adder, register, FSM, connectivity) in 1364 style vs 1800 style; port style, types (wire/reg vs logic), procedural blocks (@* vs always_comb/always_ff).
- **Migration patterns**: 1364→1800 (wire/reg→logic, always @*→always_comb, always_ff, unique/priority case); 1995→2001 (ANSI, @*); incremental migration and checklist.
- **Tool support and version selection**: Match project standard to simulator/synthesis; choose one revision (e.g. 1800-2017) and subset; use version-selection and migration checklists.
- **No new language features**: This module applies Modules 1–6 in practice (comparison and migration only).

## Structure

```
module7/
├── examples/                    # All examples have Makefile; use make run
│   ├── side_by_side/
│   │   ├── mux2_versions/       # mux2_1364.v vs mux2_1800.sv
│   │   ├── counter_versions/   # counter_1364.v vs counter_1800.sv
│   │   ├── decoder_versions/   # decoder_1364.v vs decoder_1800.sv
│   │   ├── adder_versions/      # adder_1364.v vs adder_1800.sv
│   │   ├── parameter_versions/  # param_1364.v vs param_1800.sv
│   │   ├── register_versions/   # register_1364.v vs register_1800.sv
│   │   ├── fsm_versions/        # fsm_1364.v vs fsm_1800.sv
│   │   └── connectivity_versions/ # bus_1364.v (many ports; 1800 interface in doc)
│   ├── migration/               # 1364→1800 migration (migration_steps.sv)
│   ├── migration_1995_to_2001/   # 1995→2001 (ANSI, always @*)
│   ├── migration_checklist/     # Migration checklist reminder
│   ├── incremental_migration/   # Step1 1364, step2 1800 (same mux)
│   ├── port_style_compare/      # Non-ANSI vs ANSI only
│   ├── no_defparam/             # Parameter at instantiation, no defparam
│   ├── case_versions/           # 1364 case+default vs 1800 unique case
│   ├── version_table/           # Construct vs standard reference
│   └── version_selection/       # Version-selection checklist reminder
├── dut/                         # Versioned mux and counter (for tests)
│   ├── mux2_1364.v, mux2_1800.sv
│   └── counter_1364.v, counter_1800.sv
├── tests/                       # test_mux2_all.sv, test_counter_all.sv
└── README.md
```

## File map (concept → location)

| Concept              | Path / key files |
|----------------------|------------------|
| Side-by-side mux     | `examples/side_by_side/mux2_versions/` (mux2_1364.v, mux2_1800.sv) |
| Side-by-side counter | `examples/side_by_side/counter_versions/` |
| Side-by-side decoder, adder, parameter, register, FSM | `examples/side_by_side/*_versions/` |
| Connectivity (many ports) | `examples/side_by_side/connectivity_versions/bus_1364.v` |
| Migration 1364→1800  | `examples/migration/migration_steps.sv` |
| Migration 1995→2001  | `examples/migration_1995_to_2001/migration_1995_2001.v` |
| Migration checklist  | `examples/migration_checklist/migration_checklist.sv` |
| Incremental migration | `examples/incremental_migration/incremental_migration.sv` |
| Port / case / no_defparam / version_table / version_selection | `examples/port_style_compare/`, `case_versions/`, `no_defparam/`, `version_table/`, `version_selection/` |
| DUT mux, counter     | `dut/mux2_1364.v`, `mux2_1800.sv`, `counter_1364.v`, `counter_1800.sv` |
| Tests                | `tests/test_mux2_all.sv`, `tests/test_counter_all.sv` |

## Quick start

**Requires**: Simulator (iverilog for Verilog; iverilog `-g2012` for SystemVerilog).

```bash
# From repo root: run all module7 examples and tests
./scripts/module7.sh

# Run only the testbenches (DUTs + tests)
cd module7/tests
make

# Run a single example (e.g. side-by-side mux)
cd module7/examples/side_by_side/mux2_versions
make run
```

Each `examples/*/` (and `examples/side_by_side/*/`) directory has a `Makefile`; use `make run` (or `make` where applicable) to compile and simulate.

## Documentation

- **Full module guide**: [docs/MODULE7.md](../docs/MODULE7.md) — topics, migration patterns, checklists, exercises, pitfalls, and learning outcomes.

## Focus (reminder)

- **Side-by-side**: Same design in 1995, 2001, 2005, 1800 shows port style, type, procedural block changes.
- **Migration**: 1364 -> 1800 steps: wire/reg -> logic, always @* -> always_comb, always_ff, unique/priority case.
- **Checklists**: See MODULE7.md for migration checklist and version-selection checklist.

## Tips

- **Migrate incrementally**: One module or one feature at a time (e.g. wire→logic, then always @*→always_comb); run regression after each step.
- **Keep interfaces stable**: When migrating a block, keep its port list (or interface modport) unchanged; change only internals (logic, always_comb/always_ff).
- **One project standard**: State one revision (e.g. 1800-2017) and subset in the style guide; ensure all tools support it.
- **Use checklists**: Follow the migration checklist (pre, per-module, post) for 1364→1800; use the version-selection checklist when starting a new project.
- **Side-by-side first**: Run mux/counter/decoder examples and diff the files to see exactly what changes between 1364 and 1800.
