# Module 5: IEEE 1800-2009 and 1800-2012

This directory contains examples, DUTs, and tests for **IEEE Std 1800-2009 and 1800-2012**: interface/type refinements, operator enhancements (`inside`, `==?`), array and assertion concepts.

## What you'll learn

- **Operators**: `inside` (set/range membership) and `==?` (wildcard equality; X/Z as don't care); clarified in 2009/2012.
- **Arrays**: 2012 array semantics, parameterized arrays, optional array methods; synthesizable subset for RTL.
- **Immediate assertions**: `assert (condition) else $error("...");` in RTL for invariants (e.g. one-hot, valid encoding).
- **Checkers (2012)**: Reusable assertion/coverage blocks; tool-dependent; typically not synthesized.
- **Interface refinements (2009)**: Modport expressions, virtual interface (mainly testbench); doc-only in repo if tool support varies.
- **1800 timeline**: What 2009 and 2012 add over 2005; backward compatibility; when to adopt which revision.

## Structure

```
module5/
├── examples/                    # 1800-2009/2012 examples (each has Makefile)
│   ├── operators/               # inside, ==? wildcard
│   ├── wildcard_only/            # ==? only (X/Z don't care)
│   ├── range_check/              # Range check (inside [0:127] style)
│   ├── arrays/                   # Fixed array (2012 clarifications)
│   ├── array_param/              # Parameterized array ($clog2(DEPTH))
│   ├── checkers/                 # Immediate assertion (one-hot)
│   ├── assert_valid_encoding/    # assert valid opcode/encoding
│   ├── assert_invariant/         # assert grant one-hot (arbiter)
│   └── summary/                  # 2005 vs 2009/2012 comparison
├── dut/                          # 1800-2009/2012 compatible RTL
│   ├── decoder_inside.sv         # Uses inside for set membership
│   ├── small_fsm_sv.sv           # FSM with immediate assertion (one-hot)
│   └── mem_array_sv.sv           # Simple memory (array)
├── tests/                        # Testbenches for DUTs
└── README.md
```

## File map (concept → location)

| Concept              | Example / DUT / Test                        |
|----------------------|---------------------------------------------|
| inside and ==?       | `examples/operators/inside_wildcard.sv`      |
| Wildcard only        | `examples/wildcard_only/wildcard_only.sv`   |
| Range check          | `examples/range_check/range_check.sv`        |
| Arrays                | `examples/arrays/array_methods.sv`           |
| Array param          | `examples/array_param/array_param.sv`        |
| Checkers / immediate assert | `examples/checkers/immediate_assert.sv` |
| Assert valid encoding| `examples/assert_valid_encoding/assert_valid_encoding.sv` |
| Assert invariant     | `examples/assert_invariant/assert_invariant.sv` |
| Summary 2005 vs 2009/2012 | `examples/summary/summary_2012.sv`     |
| DUT: decoder         | `dut/decoder_inside.sv`                     |
| DUT: FSM             | `dut/small_fsm_sv.sv`                       |
| DUT: memory          | `dut/mem_array_sv.sv`                       |
| Test: decoder        | `tests/test_decoder_inside.sv`              |
| Test: FSM            | `tests/test_fsm_assert.sv`                  |
| Test: memory         | `tests/test_mem_array.sv`                   |

## Quick start

**Requires**: Simulator with SystemVerilog support (e.g. iverilog `-g2012`, Verilator).

```bash
# From repo root: run all module5 examples and tests
./scripts/module5.sh

# Run only the testbenches (DUTs + tests)
cd module5/tests
make

# Run a single example (e.g. operators)
cd module5/examples/operators
make run
```

Each `examples/*/` directory has a `Makefile`; use `make run` (or `make` where applicable) to compile and simulate.

## Documentation

- **Full module guide**: [docs/MODULE5.md](../docs/MODULE5.md) — topics, code snippets, exercises, pitfalls, and learning outcomes.

## 1800-2009/2012 focus (reminder)

- **inside**: Set/range membership; clarified in 2009/2012.
- **==?**: Wildcard equality (X/Z = don't care).
- **Immediate assertion**: `assert (cond) else $error("...");` in RTL.
- **Checker (2012)**: Reusable assertion/coverage block; tool-dependent.
- **Arrays**: Methods and assignment clarifications in 2012; RTL uses fixed arrays.
- **Interfaces (2009)**: Modport expressions, virtual interface; tool-dependent.

## Tips

- Use **inside** for set or range membership (e.g. `if (op inside {ADD, SUB, AND})` or `if (x inside {[0:127]})`); clearer than long if-else chains.
- Use **==?** when some bits are don't care: RHS X/Z match anything; useful for comparisons with undefined bits.
- **Immediate assertions**: Use `assert (cond) else $error("...");` for invariants (one-hot, valid encoding); avoid in paths that affect RTL outputs.
- **Checkers (2012)**: Reusable assertion blocks; confirm tool support; typically not synthesized.
- **Arrays in RTL**: Use fixed or parameterized arrays; avoid dynamic array/queue methods in synthesizable code; use methods in testbenches or checkers.
