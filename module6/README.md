# Module 6: IEEE 1800-2017

This directory contains examples, DUTs, and tests for **IEEE Std 1800-2017**: unified LRM, Verilog vs SystemVerilog subset, design constructs recap, and version timeline.

## Structure

```
module6/
├── examples/                    # 1800-2017 examples
│   ├── subsets/                 # Verilog vs SystemVerilog (wire/reg vs logic)
│   ├── design_recap/            # logic, always_comb, always_ff, package, unique case
│   ├── assertions/              # Immediate assertion in RTL (one-hot)
│   ├── version_summary/         # Version timeline (1995 -> 2017)
│   ├── migration/                # 1364 -> 1800 migration (same design)
│   ├── logic_single_driver/     # logic single driver (2017 clarified)
│   ├── priority_case/           # priority case (encoder)
│   ├── package_import/          # package and import (2017 clarified)
│   └── unique_case/             # unique case (decoder)
├── dut/                         # 1800-2017 compatible RTL
│   ├── alu_2017.sv
│   ├── fsm_2017.sv
│   └── design_block_2017.sv
├── tests/                       # Testbenches
└── README.md
```

## Quick Start

**Requires**: Simulator with SystemVerilog support (e.g. iverilog `-g2012`, Verilator).

```bash
# Run all examples and tests (from repo root)
./scripts/module6.sh

# Or run individual example
cd module6/examples/subsets
make run
```

## Documentation

Full module documentation: [docs/MODULE6.md](../docs/MODULE6.md)

## 1800-2017 Focus (Reminder)

- **Unified LRM**: One standard (1800-2017) defines both Verilog and SystemVerilog; 1364 is superseded.
- **Verilog subset**: wire/reg, always @*; use when flow is Verilog-only.
- **SystemVerilog design**: logic, always_comb/always_ff, packages, unique/priority case; preferred for new RTL.
- **Immediate assertion**: `assert (cond) else $error("...");` in RTL for invariants.
