# Module 7: Version Comparison and Migration

This directory contains side-by-side examples, DUTs, and tests for **comparing Verilog/SystemVerilog across IEEE versions** and **migration patterns** (1364-1995 through 1800-2017).

## Structure

```
module7/
├── examples/
│   ├── side_by_side/
│   │   ├── mux2_versions/       # Same 2:1 mux in 1995, 2001, 2005, 1800
│   │   ├── counter_versions/    # Same counter in 1995, 2001, 2005, 1800
│   │   ├── decoder_versions/    # Same 2:4 decoder in 1995, 2001, 2005, 1800
│   │   ├── adder_versions/     # Same 8-bit adder in 1995, 2001, 2005, 1800
│   │   ├── parameter_versions/  # Parameter/localparam 1364 vs 1800 (shift)
│   │   ├── register_versions/   # D flip-flop in 1995, 2001, 2005, 1800
│   │   ├── fsm_versions/         # Tiny FSM 1364 vs 1800 (always_ff, unique case)
│   │   └── connectivity_versions/ # 1364 many ports (master/slave)
│   ├── migration/               # 1364 -> 1800 migration demo (before/after)
│   ├── migration_1995_to_2001/  # 1995 -> 2001 (ANSI, always @*)
│   ├── migration_checklist/     # Migration checklist reminder (1364->1800)
│   ├── incremental_migration/   # Step1 1364, step2 1800 (same mux)
│   ├── port_style_compare/      # Non-ANSI vs ANSI only (same mux)
│   ├── no_defparam/             # 1364-2005: parameter at instantiation, no defparam
│   ├── case_versions/           # 1364 case+default vs 1800 unique case
│   ├── version_table/           # Construct vs standard reference
│   └── version_selection/      # Version-selection checklist reminder
├── dut/                        # Versioned mux and counter (for tests)
│   ├── mux2_1364.v, mux2_1800.sv
│   └── counter_1364.v, counter_1800.sv
├── tests/                      # test_mux2_all, test_counter_all
└── README.md
```

## Quick Start

**Requires**: Simulator (iverilog for Verilog; iverilog -g2012 for SystemVerilog).

```bash
# Run all examples and tests (from repo root)
./scripts/module7.sh

# Or run individual example
cd module7/examples/side_by_side/mux2_versions
make run
```

## Documentation

Full module documentation: [docs/MODULE7.md](../docs/MODULE7.md)

## Focus (Reminder)

- **Side-by-side**: Same design in 1995, 2001, 2005, 1800 shows port style, type, procedural block changes.
- **Migration**: 1364 -> 1800 steps: wire/reg -> logic, always @* -> always_comb, always_ff, unique/priority case.
- **Checklists**: See MODULE7.md for migration checklist and version-selection checklist.
