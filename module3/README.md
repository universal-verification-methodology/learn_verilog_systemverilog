# Module 3: IEEE 1364-2005 (Verilog-2005)

This directory contains examples, DUTs, and tests for **IEEE Std 1364-2005 (Verilog-2005)** — the last Verilog-only standard: clarifications, defparam deprecation, synthesizable subset, and blocking vs nonblocking.

## What you'll learn

- **defparam deprecation**: Use parameter override at instantiation only; avoid defparam.
- **Synthesizable subset**: What maps to hardware (assign, always @*, always @(posedge clk), generate) and what to avoid in RTL (delays, defparam, multiple drivers, latches).
- **Blocking vs nonblocking**: `=` in combinational always; `<=` in sequential always; never mix for the same variable.
- **full_case / parallel_case**: Tool-dependent synthesis hints (1364-2005 has no unique/priority case).
- **Avoiding latches**: Default before case; assign in all paths.
- **1364 evolution**: How 1995 → 2001 → 2005 fits together and when to stay Verilog-only vs move to SystemVerilog.

## Structure

```
module3/
├── examples/                    # IEEE 1364-2005 examples (each has Makefile)
│   ├── parameters/               # Parameter override at instantiation (no defparam)
│   ├── no_defparam/              # Hierarchy: parent passes param to child at inst only
│   ├── synthesizable/            # Combinational + sequential synthesizable style
│   ├── one_driver/                # One driver per net (single assign, single always)
│   ├── procedural/               # Blocking vs nonblocking (combo vs seq)
│   ├── pipeline/                  # Two-stage pipeline (nonblocking only)
│   ├── case_styles/               # full_case / parallel_case (tool attributes)
│   ├── avoid_latch/               # Default + case so all paths assign (no latch)
│   ├── function_synth/             # Synthesizable function (no delays) in always @*
│   └── summary/                  # Small 1364-2005-only design (checklist)
├── dut/                          # Design Under Test (1364-2005)
│   ├── counter_2005.v             # Counter with parameter, localparam; no defparam
│   ├── fsm_2005.v                 # Small FSM with case (optional full_case)
│   └── param_chain.v             # Hierarchical parameter override only
├── tests/                        # Testbenches for DUTs
└── README.md                     # This file
```

## File map (concept → location)

| Concept              | Example / DUT / Test                        |
|----------------------|---------------------------------------------|
| Parameter override   | `examples/parameters/param_override.v`      |
| No defparam          | `examples/no_defparam/no_defparam.v`        |
| Synthesizable style  | `examples/synthesizable/comb_seq_style.v`    |
| One driver           | `examples/one_driver/one_driver.v`          |
| Blocking vs nonblocking | `examples/procedural/blocking_nonblocking.v` |
| Pipeline             | `examples/pipeline/pipeline.v`              |
| Case styles          | `examples/case_styles/case_full_parallel.v`  |
| Avoid latch          | `examples/avoid_latch/avoid_latch.v`        |
| Synthesizable function | `examples/function_synth/function_synth.v` |
| 1364-2005 summary    | `examples/summary/summary_2005.v`           |
| DUT: counter         | `dut/counter_2005.v`                         |
| DUT: FSM             | `dut/fsm_2005.v`                             |
| DUT: param chain     | `dut/param_chain.v`                          |
| Test: counter        | `tests/test_counter_2005.v`                  |
| Test: FSM            | `tests/test_fsm_2005.v`                      |
| Test: param chain    | `tests/test_param_chain.v`                   |

## Quick start

**Requires**: [Icarus Verilog](http://iverilog.icarus.com/) (`iverilog`) or a compatible simulator.

```bash
# From repo root: run all module3 examples and tests
./scripts/module3.sh

# Run only the testbenches (DUTs + tests)
cd module3/tests
make

# Run a single example (e.g. parameter override)
cd module3/examples/parameters
make run
```

Each `examples/*/` directory has a `Makefile`; use `make run` (or `make` where applicable) to compile and simulate.

## Documentation

- **Full module guide**: [docs/MODULE3.md](../docs/MODULE3.md) — topics, code snippets, exercises, pitfalls, and learning outcomes.

## 1364-2005 focus (reminder)

- **No defparam**: Use parameter override at instantiation only.
- **Synthesizable subset**: assign, always @* (combo), always @(posedge clk) (seq), generate, no delays in RTL.
- **Blocking (=)** in combinational always; **nonblocking (<=)** in sequential always; do not mix for same variable.
- **full_case / parallel_case**: Tool-dependent attributes; 1364-2005 has no unique/priority case.
- **No SystemVerilog**: wire/reg, always @* / always @(posedge clk); last Verilog-only standard.

## Tips

- **Do not use defparam** in new RTL; override parameters at instantiation with `#(.PARAM(value))`.
- Use **blocking** `=` only in combinational `always @*`; use **nonblocking** `<=` only in sequential `always @(posedge clk)`; never mix for the same variable.
- To avoid inferred latches, assign a default before `case` or ensure every branch assigns the output (full case).
- For synthesis hints, use tool-supported `full_case`/`parallel_case` attributes; 1364-2005 has no `unique` or `priority case` (those are SystemVerilog).
