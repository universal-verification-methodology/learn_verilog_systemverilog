# Module 6: IEEE 1800-2017

This directory contains examples, DUTs, and tests for **IEEE Std 1800-2017**: unified LRM, Verilog vs SystemVerilog subset, design constructs recap, and version timeline.

## What you'll learn

- **Unified LRM**: One standard (1800-2017) defines both Verilog and SystemVerilog; IEEE 1364 is superseded for new work.
- **Verilog subset**: wire/reg, always @*; use when the flow is Verilog-only.
- **SystemVerilog design subset**: logic, always_comb/always_ff, interfaces, packages, unique/priority case; preferred for new RTL.
- **Design constructs recap**: Single driver for logic; packages and import; immediate assertions in RTL.
- **Version timeline**: 1364-1995 → 1800-2017; choosing a standard and migration from older revisions.

## Structure

```
module6/
├── examples/                    # 1800-2017 examples (each has Makefile)
│   ├── subsets/                 # Verilog vs SystemVerilog (wire/reg vs logic)
│   ├── design_recap/            # logic, always_comb, always_ff, package, unique case
│   ├── assertions/             # Immediate assertion in RTL (one-hot)
│   ├── version_summary/        # Version timeline (1995 → 2017)
│   ├── migration/               # 1364 → 1800 migration (same design)
│   ├── logic_single_driver/     # logic single driver (2017 clarified)
│   ├── priority_case/           # priority case (encoder)
│   ├── package_import/          # package and import (2017 clarified)
│   └── unique_case/             # unique case (decoder)
├── dut/                         # 1800-2017 compatible RTL
│   ├── alu_2017.sv              # ALU with logic, always_comb, package
│   ├── design_block_2017.sv    # Block with 2017 design subset
│   └── fsm_2017.sv              # FSM with unique case, immediate assertion
├── tests/                       # Testbenches for DUTs
└── README.md
```

## File map (concept → location)

| Concept              | Example / DUT / Test                        |
|----------------------|---------------------------------------------|
| Verilog vs SV subset | `examples/subsets/verilog_vs_sv.sv`         |
| Design recap         | `examples/design_recap/design_recap.sv`     |
| Immediate assertion  | `examples/assertions/immediate_in_rtl.sv`   |
| Version summary      | `examples/version_summary/version_summary.sv` |
| Migration 1364→1800  | `examples/migration/migration.sv`           |
| Logic single driver  | `examples/logic_single_driver/logic_single_driver.sv` |
| Priority case        | `examples/priority_case/priority_case.sv`   |
| Package and import   | `examples/package_import/package_import.sv` |
| Unique case          | `examples/unique_case/unique_case.sv`       |
| DUT: ALU             | `dut/alu_2017.sv`                            |
| DUT: design block    | `dut/design_block_2017.sv`                   |
| DUT: FSM             | `dut/fsm_2017.sv`                            |
| Test: ALU            | `tests/test_alu_2017.sv`                     |

## Quick start

**Requires**: Simulator with SystemVerilog support (e.g. iverilog `-g2012`, Verilator).

```bash
# From repo root: run all module6 examples and tests
./scripts/module6.sh

# Run only the testbenches (DUTs + tests)
cd module6/tests
make

# Run a single example (e.g. Verilog vs SV subset)
cd module6/examples/subsets
make run
```

Each `examples/*/` directory has a `Makefile`; use `make run` (or `make` where applicable) to compile and simulate.

## Documentation

- **Full module guide**: [docs/MODULE6.md](../docs/MODULE6.md) — topics, code snippets, exercises, pitfalls, and learning outcomes.

## 1800-2017 focus (reminder)

- **Unified LRM**: One standard (1800-2017) defines both Verilog and SystemVerilog; 1364 is superseded.
- **Verilog subset**: wire/reg, always @*; use when flow is Verilog-only.
- **SystemVerilog design**: logic, always_comb/always_ff, packages, unique/priority case; preferred for new RTL.
- **Immediate assertion**: `assert (cond) else $error("...");` in RTL for invariants.

## Tips

- Use **1800-2017** as the single reference for both Verilog and SystemVerilog; say "Verilog subset of 1800-2017" when restricting to non-SV.
- Prefer **SystemVerilog design subset** (logic, always_comb/always_ff, packages, unique/priority case) for new RTL when the flow supports it.
- Define one **project standard** (e.g. 1800-2017) and a subset (e.g. design only, no SVA in RTL); apply consistently across files.
- Check **tool documentation** for supported LRM revision and synthesizable subset; restrict code to that to avoid portability issues.
- Migrate legacy 1364 RTL to 1800 when adding features or when the project standard moves; leave stable blocks as-is if Verilog-only is sufficient.
