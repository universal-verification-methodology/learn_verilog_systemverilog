# Learn: Verilog and SystemVerilog by IEEE Version

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![SystemVerilog](https://img.shields.io/badge/SystemVerilog-2017-blue.svg)](https://ieeexplore.ieee.org/document/8299595)
[![Verilog](https://img.shields.io/badge/Verilog-1364%20%7C%201800-green.svg)](https://ieeexplore.ieee.org/document/1620780)

A **version-centric** learning path for **Verilog** and **SystemVerilog** from IEEE 1364-1995 through IEEE 1800-2017. This project provides modules, examples, DUTs, tests, and documentation so you can see exactly what each standard adds and how to migrate between versions.

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Project Structure](#-project-structure)
- [Documentation](#-documentation)
- [Modules](#-modules)
- [Usage](#-usage)
- [Contributing](#-contributing)
- [License](#-license)
- [Acknowledgments](#-acknowledgments)

## 🎯 Overview

This project is a complete educational resource for learning Verilog and SystemVerilog **by IEEE standard version**. It provides:

- **8 Progressive Modules**: From Verilog-95 (1364-1995) through SystemVerilog 1800-2017, plus version comparison and quick reference
- **Side-by-Side Examples**: Same design in 1995, 2001, 2005, and 1800 styles so you see what changes
- **Migration Patterns**: Step-by-step migration (1364→1800, 1995→2001) with checklists
- **Runnable Examples**: All examples run with Icarus Verilog (`iverilog -g2012` for SystemVerilog)
- **Full Documentation**: Per-module docs (MODULE1.md–MODULE8.md) with construct tables, design subsets, and pitfalls
- **Quick Reference (Module 8)**: Version timeline, construct-by-standard table, migration cheat sheet, course map

### Why Version-Centric?

- **Standards matter**: Tools and projects target a specific IEEE revision (e.g. 1364-2005, 1800-2017).
- **Clear evolution**: See what 2001 added over 1995, what 1800 added over 1364, and what 2017 unified.
- **Migration**: Use Module 7 checklists and Module 8 quick reference to migrate or choose a standard.
- **Single LRM**: IEEE 1800-2017 is the current standard; Verilog is the subset of 1800 that corresponds to former 1364.

### Learning Approach

- **Module 1–3**: Verilog only (1364-1995, 1364-2001, 1364-2005).
- **Module 4–6**: SystemVerilog design (1800-2005, 1800-2009/2012, 1800-2017).
- **Module 7**: Version comparison and migration (side-by-side, checklists, tool support).
- **Module 8**: Quick reference and course summary (tables, cheat sheet, course map).

## ✨ Features

- ✅ **Version-by-version coverage**: 1364-1995, 1364-2001, 1364-2005, 1800-2005, 1800-2009, 1800-2012, 1800-2017
- ✅ **Side-by-side examples**: Mux, counter, decoder, adder, FSM, register, connectivity in multiple styles
- ✅ **Migration examples**: 1995→2001, 1364→1800, incremental migration, no defparam
- ✅ **Design subsets**: Verilog-only vs SystemVerilog design; synthesizable do/avoid
- ✅ **Construct lookup**: “Which standard has X?” (logic, always_comb, interface, etc.)
- ✅ **Orchestration scripts**: `./scripts/module1.sh` … `./scripts/module8.sh` to run all examples and tests
- ✅ **Quick reference**: Module 8 runnable cheat sheet, version timeline, migration steps, pitfalls
- ✅ **Icarus Verilog**: Examples target iverilog (Verilog and SystemVerilog `-g2012`)

## 📚 Prerequisites

### Required Knowledge

- **Basic programming**: Variables, control flow.
- **Binary/hex**: Helpful but not required; Module 1 uses simple values.

### System Requirements

- **Simulator**: Icarus Verilog (iverilog, vvp). Install e.g. `apt-get install iverilog` (Debian/Ubuntu).
- **Make**: Used by each example’s Makefile.
- **OS**: Linux, macOS, or WSL2.

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd learn
```

### 2. Install Icarus Verilog (if needed)

```bash
# Debian/Ubuntu
sudo apt-get install iverilog

# Or build from source; see your OS docs.
```

### 3. Run a Module

```bash
# Make scripts executable
chmod +x scripts/*.sh

# Run all examples and tests for a module
./scripts/module1.sh   # Verilog-95
./scripts/module4.sh   # SystemVerilog 1800-2005
./scripts/module7.sh   # Version comparison and migration
./scripts/module8.sh   # Quick reference (cheat sheet, tables)
```

### 4. Run One Example

```bash
cd module7/examples/side_by_side/mux2_versions
make run
```

## 📁 Project Structure

```
learn/
├── docs/                      # Module documentation
│   ├── MODULE1.md             # IEEE 1364-1995 (Verilog-95)
│   ├── MODULE2.md             # IEEE 1364-2001 (Verilog-2001)
│   ├── MODULE3.md             # IEEE 1364-2005 (Verilog-2005)
│   ├── MODULE4.md             # IEEE 1800-2005 (SystemVerilog design)
│   ├── MODULE5.md             # IEEE 1800-2009 and 1800-2012
│   ├── MODULE6.md             # IEEE 1800-2017 (unified LRM)
│   ├── MODULE7.md             # Version comparison and migration
│   └── MODULE8.md             # Quick reference and course summary
│
├── module1/                   # 1364-1995: modules, wire/reg, assign, always/initial
│   ├── examples/
│   ├── dut/
│   └── tests/
├── module2/                   # 1364-2001: ANSI, @*, generate, signed, arrays
├── module3/                   # 1364-2005: synthesizable subset, defparam deprecated
├── module4/                   # 1800-2005: logic, always_comb/always_ff, interfaces, packages
├── module5/                   # 1800-2009/2012: operators, arrays, assertions
├── module6/                   # 1800-2017: unified LRM, subsets, migration
├── module7/                   # Version comparison: side-by-side, migration, checklists
├── module8/                   # Quick reference: tables, cheat sheet, course map
│   ├── docs/                  # version_table.md, migration_cheat_sheet.md, course_map.md
│   └── examples/              # Runnable reference (quick_ref, version_timeline, etc.)
│
├── scripts/
│   ├── module1.sh … module8.sh   # Run each module’s examples and tests
│
├── README.md
└── LICENSE
```

## 📖 Documentation

- **[MODULE1.md](docs/MODULE1.md)** — IEEE 1364-1995: modules, wire/reg, assign, always/initial, explicit sensitivity
- **[MODULE2.md](docs/MODULE2.md)** — IEEE 1364-2001: ANSI ports, always @*, generate, signed, arrays, localparam
- **[MODULE3.md](docs/MODULE3.md)** — IEEE 1364-2005: clarifications, synthesizable subset, defparam deprecated
- **[MODULE4.md](docs/MODULE4.md)** — IEEE 1800-2005: logic, always_comb/always_ff, interfaces, packages, unique/priority case
- **[MODULE5.md](docs/MODULE5.md)** — IEEE 1800-2009/2012: interface refinements, checkers, array/string methods
- **[MODULE6.md](docs/MODULE6.md)** — IEEE 1800-2017: unified LRM, Verilog as subset, current standard
- **[MODULE7.md](docs/MODULE7.md)** — Version comparison and migration: side-by-side, patterns, checklists
- **[MODULE8.md](docs/MODULE8.md)** — Quick reference: version timeline, construct table, migration cheat sheet, course map

Each module directory has a **README.md** with structure and quick start for that module.

## 🎓 Modules

| Module | Title                    | Quick Start            |
|--------|--------------------------|------------------------|
| 1      | IEEE 1364-1995           | `./scripts/module1.sh` |
| 2      | IEEE 1364-2001           | `./scripts/module2.sh` |
| 3      | IEEE 1364-2005           | `./scripts/module3.sh` |
| 4      | IEEE 1800-2005           | `./scripts/module4.sh` |
| 5      | IEEE 1800-2009/2012      | `./scripts/module5.sh` |
| 6      | IEEE 1800-2017           | `./scripts/module6.sh` |
| 7      | Version comparison and migration | `./scripts/module7.sh` |
| 8      | Quick reference and course summary | `./scripts/module8.sh` |

**Learning path**: 1 → 2 → 3 → 4 → 5 → 6 (version order); then 7 (comparison and migration); use 8 as reference anytime.

## 💻 Usage

### Run All Examples and Tests for a Module

```bash
./scripts/module1.sh
# ... through ...
./scripts/module8.sh
```

### Run One Example

```bash
cd module5/examples/operators && make run
cd module7/examples/side_by_side/counter_versions && make run
cd module8/examples/construct_lookup && make run
```

### Run Module Tests Only

```bash
cd module5/tests && make all
cd module7/tests && make all
```

## 🤝 Contributing

Contributions are welcome. Please:

1. Follow existing code style and module structure.
2. Add comments and docstrings; keep examples runnable with iverilog.
3. Update the relevant module README and docs/MODULE*.md if you add examples or topics.
4. Run the corresponding `./scripts/moduleN.sh` to verify.

## 📄 License

This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

[![CC BY 4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)](https://creativecommons.org/licenses/by/4.0/)

### What this means

- ✅ **You may:** Share and adapt the material in any medium or format, including for commercial use.
- 📝 **You must:** Give appropriate credit, provide a link to the license, and indicate if changes were made. Do not suggest the licensor endorses you or your use.

### Attribution

When using this material, please include:

```
Based on "Learn: Verilog and SystemVerilog by IEEE Version"
Licensed under CC BY 4.0
https://creativecommons.org/licenses/by/4.0/
```

See [LICENSE](LICENSE) for the full license text.

## 🙏 Acknowledgments

- **Icarus Verilog**: [iverilog.icarus.com](http://iverilog.icarus.com/) — Open-source Verilog/SystemVerilog simulator
- **IEEE Std 1364**: Verilog Hardware Description Language (1995, 2001, 2005)
- **IEEE Std 1800-2017**: SystemVerilog—Unified Hardware Design, Specification, and Verification Language
- **Creative Commons**: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

---

**Happy Learning! 🚀**

Start with [Module 1: IEEE 1364-1995](docs/MODULE1.md) or jump to [Module 8: Quick Reference](docs/MODULE8.md) for the version timeline and cheat sheet.
