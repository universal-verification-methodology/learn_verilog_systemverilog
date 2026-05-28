# Module 4: IEEE 1800-2005 (SystemVerilog Design Subset)

**Goal**: Master the first SystemVerilog standard (IEEE 1800-2005) for RTL design: logic types, always_comb/always_ff, interfaces, packages, and unique/priority case.

**Prerequisites**: Module 1–3 (1364-1995, 1364-2001, 1364-2005) — you should be comfortable with Verilog RTL, synthesizable subset, and blocking vs nonblocking.

**Estimated time**: 8–12 hours (examples + exercises + reading). Interfaces and packages may require a simulator with full SystemVerilog support.


## Running Module 4

From the repo root:

- **Run all examples**: `./scripts/module4.sh`
- **Slides & video**: [slides.pptx](../media/module4/slides.pptx) · [slides.pdf](../media/module4/slides.pdf) · [video.mp4](../media/module4/video.mp4) — regenerate: `./scripts/build_all_media.sh --module 4`

## Table of Contents

- [Overview](#overview)
- [Topics Covered](#topics-covered)
- [Examples](#examples)
- [Design Under Test (DUT)](#design-under-test-dut)
- [Tests](#tests)
- [Learning Outcomes](#learning-outcomes)
- [Key Concepts](#key-concepts)
- [Exercises](#exercises)
- [Common Pitfalls](#common-pitfalls-and-how-to-avoid-them)
- [Next Steps](#next-steps)
- [Additional Resources](#additional-resources)

## Overview

This module covers IEEE Std 1800-2005, the first SystemVerilog standard. It extends Verilog (IEEE 1364-2005) with design and verification features. Here the focus is on the **design subset** used for RTL: the `logic` type, explicit procedural blocks (`always_comb`, `always_ff`, `always_latch`), interfaces and modports, packages, and `unique`/`priority` case. You'll learn how 1800-2005 improves clarity and tool checking over 1364-2005 and when to adopt these constructs in RTL. Verification features (classes, assertions, etc.) are introduced only in context; later modules can go deeper.

### Learning Resources

**IEEE Standard Reference**:
- **IEEE Std 1800-2005**: IEEE Standard for SystemVerilog—Unified Hardware Design, Specification, and Verification Language
- First SystemVerilog standard; builds on 1364-2005 (Verilog is a subset of 1800)
- Covers both design and verification; this module emphasizes design constructs

**When to Reference the Standard**:
- When checking exact syntax for interfaces, modports, packages, or procedural block semantics
- When writing RTL that uses SystemVerilog design features (logic, always_comb/always_ff, interfaces)
- When comparing 1364-2005 with 1800-2005 to decide which constructs to use

## Topics Covered

### 1. IEEE 1800-2005 Context

IEEE Std 1800-2005 is the first SystemVerilog standard. It unifies design and verification in one language and is backward compatible with 1364-2005 for Verilog subsets.

#### What 1800-2005 Adds Over 1364-2005 (Design Subset)

- **logic**: Single type for single-driver nets/variables (replaces wire/reg in most RTL)
- **2-state types**: `bit`, `int`, `byte`, etc. (mainly for testbenches; some RTL use)
- **always_comb, always_ff, always_latch**: Explicit procedural blocks with tool checks
- **Interfaces and modports**: Bundle signals and define direction per connection
- **Packages and import**: Shared types, constants, and functions across modules
- **unique case, priority case**: Standard semantics for case statements (no tool-specific attributes)
- **Operators**: `inside`, wildcard `==?`, and other enhancements
- **Verification**: Classes, assertions (SVA), coverage, etc. (covered in later modules or other courses)

#### What This Module Emphasizes

- **Design/RTL**: logic, always_comb/always_ff, interfaces, packages, unique/priority case
- **Not in depth**: Classes, SVA, coverage, constrained random (those are verification-focused)

#### Relation to 1364-2005

- 1364-2005 (Verilog) is a subset of 1800-2005 (SystemVerilog).
- Valid 1364-2005 RTL is valid 1800-2005 RTL; you can migrate incrementally (e.g. wire→logic, always @*→always_comb).

### 2. logic and 2-State Types (1800)

SystemVerilog introduces **logic** for single-driver nets and variables, and **2-state types** for simulation efficiency and clarity.

#### logic (4-State, Single Driver)

- **logic**: Replaces `wire` and `reg` when there is a single driver; can be used in both continuous and procedural assignments.
- **Rule**: A `logic` variable must have exactly one driver (one assign, or one always block, or one port connection).
- **4-state**: 0, 1, X, Z (same as wire/reg).

```systemverilog
module mux2 (
    input  logic a, b, sel,
    output logic y
);
    always_comb y = sel ? b : a;
endmodule
```

- **Ports**: `input logic`, `output logic`; no need to choose wire vs reg for single-driver ports.
- **Internal**: Use `logic` for single-driver signals; use `wire` only when needed (e.g. multiple drivers, tri-state).

#### bit and 2-State Types (1800)

- **bit**: 2-state (0, 1); no X or Z. Often used in testbenches and for indices.
- **int, byte, shortint, longint**: Integer types; 2-state unless declared with a 4-state base.
- **Use in RTL**: Optional (e.g. loop indices, parameters); many RTL designs use `logic` and `integer`/`reg` for compatibility.

```systemverilog
logic [7:0] data;   // 4-state, single driver
bit [7:0]   index;  // 2-state (e.g. for testbench)
int         i;      // 32-bit signed integer (e.g. loop counter)
```

**Example**: `module4/examples/data_types/logic_bit.sv`

### 3. always_comb, always_ff, always_latch (1800)

SystemVerilog adds **explicit** procedural block types so tools can check intended behavior (combinational, sequential, or latch).

#### always_comb

- **Intent**: Combinational logic; no storage; outputs are a function of inputs only.
- **Sensitivity**: Automatically inferred (like `always @*`); must not contain latches.
- **Tool check**: Simulator/synthesis can warn if the block implies storage or is sensitive to clock edges.

```systemverilog
always_comb begin
    y = a & b;
    z = y | c;   // y is combinational; no latch
end
```

- **Prefer over** `always @*` when the tool supports it: clearer intent and better checking.

#### always_ff

- **Intent**: Sequential logic (flip-flops); use nonblocking assignment (`<=`) only.
- **Sensitivity**: Must list exactly one clock (and optionally async reset); no other event controls.

```systemverilog
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 0;
    else
        q <= d;
end
```

- **Tool check**: Can warn if blocking assignment or incomplete sensitivity is used.

#### always_latch

- **Intent**: Explicit latch (level-sensitive storage). Use sparingly; usually latches are unintended.
- **When**: When a latch is truly intended (e.g. transparent latch); otherwise use always_comb or always_ff.

```systemverilog
always_latch
    if (en) q <= d;   // Transparent latch: q holds when en=0
```

- **Recommendation**: Prefer always_comb or always_ff; use always_latch only when a latch is desired.

**Example**: `module4/examples/procedural/always_comb_ff.sv`

### 4. Interfaces and Modports (1800)

**Interfaces** bundle related signals into one object; **modports** define direction per module role. They reduce port list repetition and clarify connection intent.

#### Interface Declaration

```systemverilog
interface bus_if;
    logic [31:0] data;
    logic        valid;
    logic        ready;
    logic        clk;
    logic        rst_n;

    modport master (output data, valid, input ready, clk, rst_n);
    modport slave  (input data, valid, output ready, input clk, rst_n);
endinterface
```

- **Signals**: Declared once inside the interface; shared by all modules that use it.
- **modport**: Defines a view (direction) for a given role (e.g. master sees data as output, slave sees data as input).

#### Using an Interface in a Module

```systemverilog
module master (bus_if.master bus);
    always_ff @(posedge bus.clk) begin
        if (!bus.rst_n)
            bus.valid <= 0;
        else
            bus.valid <= 1;
        bus.data <= 32'hDEAD;
    end
endmodule

module slave (bus_if.slave bus);
    assign bus.ready = bus.valid;
endmodule
```

- **Port**: Single interface port with a modport (e.g. `bus_if.master bus`).
- **Access**: `bus.signal_name`; direction is enforced by the modport.

#### Top-Level Connection

```systemverilog
module top;
    bus_if bus();
    master u_master (.bus(bus));
    slave  u_slave  (.bus(bus));
endmodule
```

- **One interface instance**: Connects master and slave; no long port lists.

**Example**: `module4/examples/interfaces/bus_if_example.sv` (interface in `dut/bus_if.sv`)

### 5. Packages and import (1800)

**Packages** provide a namespace for shared types, constants, and functions. **import** makes package items visible in a module or compilation unit.

#### Package Declaration

```systemverilog
package pkg_util;
    parameter int WIDTH = 32;
    typedef logic [WIDTH-1:0] word_t;

    function automatic logic [7:0] parity(input logic [31:0] v);
        parity = ^v;
    endfunction
endpackage
```

- **Contents**: parameter, localparam, typedef, function, task, etc. (no always blocks).
- **Scope**: Items are in namespace `pkg_util::` until imported.

#### Import and Use

```systemverilog
module alu (
    input  logic [31:0] a, b,
    output logic [31:0] y
);
    import pkg_util::*;   // Wildcard: use WIDTH, word_t, parity
    // or: import pkg_util::WIDTH; import pkg_util::parity;

    assign y = a + b;
    // parity(y) if needed
endmodule
```

- **import pkg_util::***: Import all names from the package (can cause name clashes).
- **import pkg_util::item**: Import specific items; safer when many packages are used.

**Example**: `module4/examples/packages/pkg_util.sv`

### 6. unique case and priority case (1800)

SystemVerilog adds **unique** and **priority** to case statements so that semantics are standard and tools can optimize or warn.

#### unique case

- **Semantics**: At most one case item must match at runtime; if none or more than one matches, a runtime error can be reported.
- **Use**: When the design guarantees at most one match (e.g. one-hot encoding, mutually exclusive conditions).
- **Synthesis**: Can be implemented as parallel priority logic; no inferred priority order.

```systemverilog
unique case (sel)
    2'b01: y = a;
    2'b10: y = b;
    2'b11: y = c;
    default: y = 0;   // Optional; handles 2'b00 and any X/Z
endcase
```

#### priority case

- **Semantics**: The first matching item has priority; if no item matches, a runtime error can be reported (unless default is present).
- **Use**: When priority order is intended (e.g. interrupt mask).
- **Synthesis**: Can be implemented as a priority chain (if-then-else or similar).

```systemverilog
priority case (1'b1)
    req[3]: grant = 4'b1000;
    req[2]: grant = 4'b0100;
    req[1]: grant = 4'b0010;
    req[0]: grant = 4'b0001;
    default: grant = 4'b0000;
endcase
```

**Example**: `module4/examples/case_unique_priority/decoder.sv`

### 7. Comparison: 1364-2005 vs 1800-2005 (Design)

| Feature           | 1364-2005 (Verilog)   | 1800-2005 (SystemVerilog)     |
|-------------------|------------------------|--------------------------------|
| Single-driver type| wire or reg           | logic                          |
| Combinational     | always @*             | always_comb                   |
| Sequential        | always @(posedge clk) | always_ff                      |
| Latch             | always @* (incomplete)| always_latch (explicit)       |
| Connectivity      | Many ports            | interface + modport            |
| Shared definitions| `include              | package + import               |
| case semantics    | full_case/parallel_case (tool-specific) | unique case / priority case |
| 2-state           | integer (partial)     | bit, int, byte, etc.           |

- **Migration**: Replace wire/reg with logic where single driver; replace always @* with always_comb; replace always @(posedge clk) with always_ff; introduce interfaces and packages as needed; use unique/priority case instead of attributes.

### 8. When to Use 1800-2005 Design Features

- **Use logic**: For all single-driver RTL signals when the flow supports SystemVerilog.
- **Use always_comb/always_ff**: For clearer intent and tool checking; prefer over always @* and always @(posedge clk) in new SV RTL.
- **Use interfaces**: When many modules share the same bundle of signals (e.g. bus, handshake); reduces port list size and errors.
- **Use packages**: When types, constants, or functions are shared across many files; avoids repeated `include and naming conflicts.
- **Use unique/priority case**: When semantics are “at most one match” or “first match wins”; avoids tool-specific attributes.
- **Stay with 1364-2005**: When the project or tool is Verilog-only; migrate when the flow supports 1800.

## Examples

### Quick file reference

| Topic                | Path                                  | Key files |
|----------------------|---------------------------------------|-----------|
| logic and 2-state    | `module4/examples/data_types/`        | `logic_bit.sv` |
| logic ports          | `module4/examples/logic_ports/`       | `logic_ports.sv` |
| always_comb / always_ff | `module4/examples/procedural/`     | `always_comb_ff.sv` |
| always_latch         | `module4/examples/always_latch/`      | `always_latch.sv` |
| One driver per logic | `module4/examples/one_driver_logic/`  | `one_driver_logic.sv` |
| typedef              | `module4/examples/typedef_sv/`        | `typedef_sv.sv` |
| Interfaces           | `module4/examples/interfaces/`        | `bus_if_example.sv` (see also `dut/bus_if.sv`) |
| Packages             | `module4/examples/packages/`          | `pkg_util.sv` |
| Package + typedef    | `module4/examples/package_typedef/`   | `package_typedef.sv` |
| unique / priority case | `module4/examples/case_unique_priority/` | `decoder.sv` |
| priority case only   | `module4/examples/priority_case/`     | `priority_case.sv` |
| Migration 1364→1800  | `module4/examples/migration/`          | `migration.sv` |

### Module 4 Examples (1800-2005 Design)

1. **logic and 2-State Types** (`examples/data_types/`)
   - logic for ports and internal single-driver signals
   - **Key Concepts**: Single driver for logic; 4-state

2. **logic Ports** (`examples/logic_ports/`)
   - All ports logic (mux, adder); no wire/reg choice
   - **Key Concepts**: assign and always_comb can drive output logic

3. **always_comb / always_ff** (`examples/procedural/`)
   - Combinational with always_comb; sequential with always_ff
   - **Key Concepts**: Explicit intent; tool checks; no latch in always_comb

4. **always_latch** (`examples/always_latch/`)
   - Explicit latch when intended (e.g. transparent latch)
   - **Key Concepts**: Use when latch is desired; prefer always_comb/always_ff otherwise

5. **One Driver per logic** (`examples/one_driver_logic/`)
   - Single assign to one output; single always_ff to another
   - **Key Concepts**: logic must have exactly one driver

6. **typedef** (`examples/typedef_sv/`)
   - typedef in module (e.g. byte_t = logic [7:0])
   - **Key Concepts**: User-defined types for clarity

7. **Interfaces and Modports** (`examples/interfaces/`)
   - Interface definition, modports, connection in top
   - **Key Concepts**: One bundle per connection; direction per modport

8. **Packages and import** (`examples/packages/`)
   - Package with types/params/functions; import in modules
   - **Key Concepts**: Namespace; wildcard vs specific import

9. **Package with typedef and function** (`examples/package_typedef/`)
   - Package with typedef and min_word function; import in ALU
   - **Key Concepts**: Shared types and helpers across modules

10. **unique / priority case** (`examples/case_unique_priority/`)
    - unique case (at most one match); priority case (first match)
    - **Key Concepts**: Standard semantics; synthesis and simulation behavior

11. **priority case only** (`examples/priority_case/`)
    - Arbiter with priority case (first req wins)
    - **Key Concepts**: priority case for arbiter, interrupt mask

12. **Migration from 1364** (`examples/migration/`)
    - Same small design in 1364-2005 style vs 1800-2005 style
    - **Key Concepts**: wire/reg→logic, always @*→always_comb, always @(posedge clk)→always_ff

## Design Under Test (DUT)

### SystemVerilog Design Subset (`module4/dut/`)

- **mux2_sv.sv**: 2:1 mux with logic and always_comb
  - **Example**: logic ports; always_comb; no wire/reg

- **counter_sv.sv**: Counter with always_ff and optional package type
  - **Example**: always_ff; nonblocking; reset

- **bus_if.sv**: Interface definition (used by bus_master and bus_slave)
  - **Example**: interface declaration; modports master and slave

- **bus_master.sv**: Master using an interface (modport master)
  - **Example**: interface port; modport; single connection object

- **bus_slave.sv**: Slave using an interface (modport slave)
  - **Example**: interface port; modport; same interface instance as master

- **decoder_unique.sv**: Decoder with unique case
  - **Example**: unique case; default; no tool-specific attributes

## Tests

### Module 4 Tests

- **test_mux2_sv.v**: Mux testbench (SystemVerilog or Verilog testbench)
  - **Key Features**: Exercises logic-based mux; no 1364-only assumptions

- **test_counter_sv.v**: Counter test
  - **Key Features**: Reset, enable, wrap; optional interface-based access

- **test_bus_master_slave.sv**: Master/slave with shared interface
  - **Key Features**: One interface instance; both sides driven/observed

- **test_decoder_unique.v**: Decoder with unique case
  - **Key Features**: All select values; default branch

## Learning Outcomes

By the end of this module, you should be able to:

- ✓ Use **logic** for single-driver nets and variables in RTL
- ✓ Use **always_comb** for combinational logic and **always_ff** for sequential logic
- ✓ Define and use **interfaces** with **modports** for bundled connectivity
- ✓ Define **packages** and **import** them in modules
- ✓ Use **unique case** and **priority case** with correct semantics
- ✓ Compare 1364-2005 and 1800-2005 design constructs and migrate simple RTL from Verilog to SystemVerilog design subset
- ✓ Decide when to adopt 1800 design features vs stay with 1364

## Key Concepts

### logic vs wire/reg

- **logic**: One driver only; use for most RTL when using SystemVerilog.
- **wire**: Use when multiple drivers (e.g. tri-state) or when staying in 1364 style.
- **reg**: In 1800, logic is preferred; reg remains for compatibility.

### always_comb / always_ff vs always @* / always @(posedge clk)

- **always_comb**: Same idea as always @*; explicit “combinational” and tool-checked.
- **always_ff**: Same idea as always @(posedge clk); explicit “flip-flop” and tool-checked.
- **Benefit**: Clearer intent; tools can warn on latch or wrong assignment style.

### Interfaces vs Many Ports

- **Many ports**: Each module has a long list; easy to misconnect.
- **Interface**: One object per connection; modports enforce direction; less repetition.

### Packages vs `include

- **`include**: Text inclusion; no namespace; risk of redefinition.
- **Package**: Named namespace; import only what is needed; better for large projects.

### unique / priority case vs full_case / parallel_case

- **unique case**: Standard “at most one match”; no tool-specific attribute.
- **priority case**: Standard “first match wins”; no tool-specific attribute.
- **full_case/parallel_case**: Tool-specific attributes in 1364; replace with unique/priority in 1800 when possible.

## Exercises

1. **logic and always_comb/always_ff**
   - Take a 1364-2005 module (e.g. mux, counter) and convert to 1800: wire/reg→logic, always @*→always_comb, always @(posedge clk)→always_ff.
   - Run simulation and optional synthesis; confirm behavior unchanged.

2. **Interface**
   - Define an interface for a simple handshake (valid, ready, data); add modports for producer and consumer.
   - Implement a producer and a consumer module using the interface; connect them in a top module.

3. **Package**
   - Create a package with a data width parameter, a typedef for a word, and a parity function.
   - Use the package in two different modules (e.g. ALU and register file); use both wildcard and specific import in each.

4. **unique case**
   - Implement a one-hot decoder with unique case (and default).
   - Run simulation with all combinations including X; observe behavior when no match or multiple matches (if applicable).

5. **Migration Summary**
   - List five 1800-2005 design features that replace 1364-2005 constructs.
   - Rewrite one of your 1364-2005 designs using only those five features and compare line count and readability.

## Common Pitfalls and How to Avoid Them

1. **Multiple Drivers on logic**
   - **Mistake**: Driving the same logic from two assign statements or two always blocks.
   - **Reality**: logic allows only one driver; multiple drivers are illegal or undefined.
   - **Correct**: Use one assign or one always per logic; for multiple drivers use wire (e.g. tri-state).
   - **Why**: logic is for single-driver RTL; wire is for resolved (multi-driver) nets.

2. **Using always_comb with Latched Behavior**
   - **Mistake**: Incomplete branches in always_comb (e.g. no default in case) and expecting no latch.
   - **Reality**: Tools may infer a latch or report a warning.
   - **Correct**: Assign every output in every path, or provide default before case.
   - **Why**: always_comb is intended for pure combinational logic; latches require always_latch if desired.

3. **Wrong Modport or Direction**
   - **Mistake**: Driving an input in a modport or reading an output that is not in the modport.
   - **Reality**: Compiler or elaboration error; or wrong connectivity.
   - **Correct**: Use the modport that matches the module role (master vs slave); check direction in the interface.
   - **Why**: Modports enforce direction; using the wrong view breaks the contract.

4. **Forgetting to import Package**
   - **Mistake**: Using a package type or function without importing.
   - **Reality**: Identifier not found; compile error.
   - **Correct**: Add `import pkg_name::*;` or `import pkg_name::item;` before use.
   - **Why**: Package names are in a separate namespace until imported.

5. **unique case with Multiple Matches**
   - **Mistake**: Writing unique case when two items can match (e.g. overlapping or X in select).
   - **Reality**: Runtime error or undefined behavior.
   - **Correct**: Use unique case only when at most one item can match; use default for catch-all; or use priority case when priority is intended.
   - **Why**: unique case has well-defined semantics; violating them breaks verification and synthesis.

## Next Steps

After completing this module, proceed to:

- **Module 5**: IEEE 1800-2009 / 2012 — Further design and assertion enhancements; more on types, operators, and interfaces

## Additional Resources

### Module Documentation

- **Module 4 README**: [module4/README.md](../module4/README.md) — directory structure, quick start, and file map
- **Module 3**: [docs/MODULE3.md](MODULE3.md) — IEEE 1364-2005 (prerequisite)
- **Module 5**: [docs/MODULE5.md](MODULE5.md) — IEEE 1800-2009/2012 (next)

### Reference Materials

- **IEEE Std 1800-2005**: IEEE Standard for SystemVerilog—Unified Hardware Design, Specification, and Verification Language
- **IEEE Std 1364-2005**: For comparison (Verilog subset of 1800)
- **Tool Documentation**: Simulator and synthesis support for SystemVerilog design subset (logic, always_comb/always_ff, interfaces, packages)

### Learning Path

1. **Start here**: Complete Module 4 examples using the 1800-2005 design subset only (no classes/SVA in depth).
2. **Practice**: Convert 1364-2005 RTL to 1800-2005 (logic, always_comb/always_ff, optional interface/package).
3. **Compare**: Keep one design in both 1364 and 1800 form; note readability and tool messages.
4. **Extend**: In Module 5, add 1800-2009/2012 features (e.g. interface refinements, operators).

---

For questions or issues, refer to the main project documentation or the IEEE 1800-2005 standard for authoritative syntax and semantics.
