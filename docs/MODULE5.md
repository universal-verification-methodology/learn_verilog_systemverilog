# Module 5: IEEE 1800-2009 and 1800-2012

**Goal**: Master the SystemVerilog revisions IEEE 1800-2009 and 1800-2012: interface and type refinements, operator and array enhancements, and assertion/checker concepts in context.

**Prerequisites**: Module 4 (IEEE 1800-2005) — you should be comfortable with logic, always_comb/always_ff, interfaces, packages, and unique/priority case.

**Estimated time**: 4–6 hours (examples + exercises + reading). Some features (e.g. checkers, virtual interface) are tool-dependent.

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

This module covers IEEE Std 1800-2009 and IEEE Std 1800-2012, the first two major revisions of SystemVerilog after 1800-2005. You'll learn what 2009 and 2012 add or clarify: interface refinements (e.g. modport expressions, virtual interfaces in verification), type and operator enhancements, array and string improvements, and a brief context for assertions and checkers. The focus remains on design-relevant constructs and on understanding the version timeline (2005 → 2009 → 2012) so you can read and write RTL that targets a specific standard or tool set.

### Learning Resources

**IEEE Standard References**:
- **IEEE Std 1800-2009**: IEEE Standard for SystemVerilog—Unified Hardware Design, Specification, and Verification Language (Revision of 1800-2005)
- **IEEE Std 1800-2012**: IEEE Standard for SystemVerilog—Unified Hardware Design, Specification, and Verification Language (Revision of 1800-2009)
- Both are backward compatible with 1800-2005; they add features and clarifications

**When to Reference the Standards**:
- When checking exact syntax for interface features, arrays, or operators added in 2009/2012
- When a project or tool specifies 1800-2009 or 1800-2012 compliance
- When comparing 1800-2005 with later revisions for migration or tool support

## Topics Covered

### 1. IEEE 1800-2009 and 1800-2012 Context

1800-2009 and 1800-2012 refine and extend 1800-2005. They do not replace the 2005 design subset; they add options and clarify behavior.

#### What 1800-2009 Adds or Clarifies

- **Interfaces**: Modport expressions, virtual interface type (for testbenches), interface inheritance
- **Types and operators**: Clarifications; additional operators and built-in methods
- **Assertions**: SVA enhancements; checker concept (preview)
- **DPI**: Refinements for C/C++ interop
- **Coverage**: Coverage option and syntax clarifications
- **Clarifications**: Scheduling, generate, and other 2005 semantics

#### What 1800-2012 Adds or Clarifies

- **Checkers**: Checker construct for reusable assertion/coverage logic
- **Arrays**: Array manipulation methods; array assignment and ordering clarifications
- **Strings**: String methods and behavior
- **Compilation units**: Refined rules for $unit and compilation-unit scope
- **Assertions and coverage**: Further SVA and coverage features
- **Clarifications**: Numerous editorial and semantic clarifications across the LRM

#### Relation to 1800-2005

- 1800-2005 RTL remains valid in 1800-2009 and 1800-2012.
- New features are additive; you adopt them when the tool and project support the revision.

### 2. Interface Refinements (2009)

1800-2009 extends interfaces with modport expressions and virtual interfaces, improving reuse and testbench connectivity.

#### Modport Expressions (2009)

Modports can expose expressions (e.g. slices or concatenations) rather than raw signals, so the connection view can be tailored without changing the interface body.

```systemverilog
interface data_if;
    logic [31:0] data;
    logic        valid;
    logic        ready;

    modport master (output data, valid, input ready);
    modport slave  (input data, valid, output ready);
    // 2009: modport can also specify expressions (tool-dependent syntax)
endinterface
```

- **Use**: When the same interface is used with different signal subsets or derived signals; check tool support for exact syntax.
- **Benefit**: Fewer duplicate interface definitions; clearer connection contract.

#### Virtual Interface (2009)

A **virtual interface** is a variable that holds a handle to an interface instance. It is used mainly in testbenches (e.g. in classes) to connect to different interface instances at runtime.

```systemverilog
// In a class (testbench)
class driver;
    virtual bus_if vif;
    task run();
        vif.valid <= 1;
        vif.data   <= 32'hDEAD;
    endtask
endclass
```

- **Design**: Rarely used in RTL; RTL typically connects to a concrete interface instance.
- **Verification**: Common in UVM and other OOP testbenches; allows one driver class to work with any instance of the interface.

**Example**: Interface refinements (modport expressions, virtual interface) are doc-only in this repo; see Topics and your tool’s 1800-2009 support.

### 3. Type and Operator Enhancements (2009/2012)

1800-2009 and 1800-2012 clarify and extend types and operators used in both design and testbenches.

#### Integer Types and Sizes

- **byte, shortint, int, longint**: 8, 16, 32, 64 bits; signed by default.
- **byte unsigned, int unsigned**: Unsigned variants.
- **Clarifications in 2012**: Representation and conversion rules; use in RTL for constants and parameters.

#### Operators Added or Clarified

- **inside**: Already in 2005; 2009/2012 clarify set membership and use with ranges.
  ```systemverilog
  if (op inside {ADD, SUB, AND, OR}) ...
  if (x inside {[0:15], [32:47]}) ...
  ```
- **Wildcard equality** `==?`: X/Z in the right-hand side act as “don’t care” in comparisons.
- **Set membership and case (inside)**: Used in case statements and constraints; semantics clarified in 2012.

#### Array Methods (2012)

Dynamic arrays, queues, and associative arrays have built-in methods; 2012 clarifies behavior and adds methods where applicable.

- **Array methods**: `.size()`, `.delete()`, `.sort()`, `.reverse()`, etc. (exact set is revision-dependent).
- **Queues**: `.push_back()`, `.pop_front()`, `.insert()`, etc.
- **Use in RTL**: Limited (arrays in RTL are often fixed); methods are common in testbenches and checkers.

**Example**: `module5/examples/operators/inside_wildcard.sv`

### 4. Array and String Refinements (2012)

1800-2012 refines array assignment, ordering, and string handling so that behavior is consistent across tools.

#### Array Assignment and Ordering

- **Packed vs unpacked**: Assignment rules and ordering (row-major, etc.) are clarified.
- **Array copy**: Whole-array assignment and copying; compatibility of dimensions.
- **Use in RTL**: Multi-dimensional arrays (e.g. memories) and parameterized dimensions; follow tool-supported subset for synthesis.

#### String Methods

- **Strings**: `string` type; methods such as `.len()`, `.substr()`, `.atoi()`, etc. (as defined in 2012).
- **Use in RTL**: Rare (strings are mainly for messages and file I/O in testbenches).
- **Use in testbenches**: Logging, report generation, file names.

**Example**: `module5/examples/arrays/array_methods.sv` (or doc reference)

### 5. Assertions and Checkers in Context (2009/2012)

SystemVerilog Assertions (SVA) and the **checker** construct (2012) support specification and reuse of properties. This section gives design-context only; full SVA/checker treatment is verification-focused.

#### Assertions in Design (Brief)

- **immediate assertions**: `assert (condition) else $error("...");` — checked when executed (like an if-check).
- **concurrent assertions**: `assert property (@(posedge clk) (a |-> b));` — checked over time; typically in verification.
- **Use in RTL**: Immediate assertions for invariants (e.g. one-hot, valid encodings); concurrent assertions often in bind files or testbench.

#### Checker (2012)

- **checker**: A reusable unit that can contain assertions, assumptions, coverage, and helper logic; can be instantiated in design or testbench.
- **Use**: Encapsulate a set of properties (e.g. protocol rules) and reuse across modules or hierarchies.
- **Design**: Checkers can be bound to RTL modules; they do not change RTL functionality, only add checking.

```systemverilog
checker onehot_check(logic [3:0] sig);
    always_comb assert ($onehot(sig)) else $error("not one-hot");
endchecker
```

- **Synthesis**: Checkers are typically not synthesized; they are for simulation and formal tools.

**Example**: `module5/examples/checkers/immediate_assert.sv` (one-hot immediate assertion)

### 6. Compilation Units and Scope (2012)

1800-2012 clarifies **compilation units** and the **$unit** scope. This affects where packages, types, and declarations are visible when multiple files are compiled together.

#### Compilation Unit

- **Compilation unit**: The scope of one or more source files compiled together (tool-defined).
- **$unit**: The compilation-unit scope; declarations in $unit are visible across the unit without import.
- **Best practice**: Prefer packages and explicit import over $unit to avoid hidden dependencies and name clashes.

#### Package and Import

- **Import**: `import pkg::*` or `import pkg::item`; 2012 clarifies visibility and search order.
- **Use**: Keep shared types and functions in packages; import where needed; avoid relying on $unit for new code.

**Example**: Document only, or reference Module 4 package examples.

### 7. Summary: 1800-2005 vs 2009 vs 2012 (Design-Relevant)

| Topic              | 1800-2005     | 1800-2009           | 1800-2012           |
|--------------------|---------------|---------------------|---------------------|
| Interfaces         | Basic, modport| Modport expressions, virtual interface | Clarifications      |
| Types/operators    | logic, bit, inside, ==? | Clarifications      | Array methods, clarifications |
| Arrays             | Basic         | Clarifications      | Assignment, methods, ordering |
| Strings            | Basic         | Clarifications      | Methods, behavior   |
| Assertions         | SVA           | SVA enhancements    | Checker, SVA        |
| Compilation        | Basic         | Clarifications      | $unit, compilation unit |

- **Migration**: 2005 RTL works in 2009 and 2012; adopt 2009/2012 features when the tool supports them and the project standard is updated.

### 8. When to Use 2009/2012 Features

- **Interfaces**: Use modport expressions or virtual interfaces when the project uses 1800-2009+ and you need the extra flexibility (especially in testbenches).
- **Operators**: Use `inside` and `==?` when they improve readability; they are in 2005 but clarified in 2009/2012.
- **Arrays**: Use array methods and clarified assignment when writing testbenches or checkers; in RTL, stick to the synthesizable subset your tool supports.
- **Assertions/checkers**: Use immediate assertions in RTL for invariants; use checkers when you want reusable property blocks (2012+).
- **Standard selection**: Choose 2005, 2009, or 2012 based on project and tool support; prefer a single revision for the codebase when possible.

## Examples

### Quick file reference

| Topic                | Path                                  | Key files |
|----------------------|---------------------------------------|-----------|
| inside and ==?       | `module5/examples/operators/`          | `inside_wildcard.sv` |
| Wildcard only        | `module5/examples/wildcard_only/`      | `wildcard_only.sv` |
| Range check          | `module5/examples/range_check/`        | `range_check.sv` |
| Arrays               | `module5/examples/arrays/`             | `array_methods.sv` |
| Array param          | `module5/examples/array_param/`        | `array_param.sv` |
| Checkers / immediate assert | `module5/examples/checkers/`   | `immediate_assert.sv` |
| Assert valid encoding| `module5/examples/assert_valid_encoding/` | `assert_valid_encoding.sv` |
| Assert invariant     | `module5/examples/assert_invariant/`    | `assert_invariant.sv` |
| Summary 2005 vs 2009/2012 | `module5/examples/summary/`       | `summary_2012.sv` |

*Interface refinements (modport expressions, virtual interface) are documented in Topics; no example directory in repo (tool-dependent).*

### Module 5 Examples (1800-2009/2012)

1. **Operators** (`examples/operators/`)
   - `inside` with ranges and sets; `==?` wildcard (fallback for tools that lack `inside`)
   - **Key Concepts**: Set membership; don’t-care in comparison

2. **Wildcard Only** (`examples/wildcard_only/`)
   - Dedicated `==?` wildcard equality (X/Z as don't care)
   - **Key Concepts**: Wildcard match in RTL/testbench

3. **Range Check** (`examples/range_check/`)
   - Range membership (e.g. value inside `[0:127]`); fallback to explicit comparison if needed
   - **Key Concepts**: `inside` with ranges; 2009/2012 operator use

4. **Arrays** (`examples/arrays/`)
   - Fixed memory with parameterized DEPTH/WIDTH; 2012 array semantics
   - **Key Concepts**: Array indexing; synthesis-safe subset

5. **Array Param** (`examples/array_param/`)
   - Parameterized memory using `$clog2(DEPTH)` for address width
   - **Key Concepts**: Parameterized arrays; 2012 clarifications

6. **Checkers** (`examples/checkers/`)
   - Immediate assertion (e.g. one-hot) using `$countones` or similar
   - **Key Concepts**: assert in design; immediate assertion in RTL

7. **Assert Valid Encoding** (`examples/assert_valid_encoding/`)
   - Immediate assertion for valid opcode/encoding
   - **Key Concepts**: Invariant checking; assert for valid encodings

8. **Assert Invariant** (`examples/assert_invariant/`)
   - Immediate assertion for one-hot grant (e.g. arbiter)
   - **Key Concepts**: One-hot invariant; assert in RTL

9. **Summary** (`examples/summary/`)
   - Comparison of 2005 vs 2009/2012 features in a small design
   - **Key Concepts**: Backward compatibility; when to adopt new features

*Interface refinements (modport expressions, virtual interface) are documented in the main module text; examples are tool-dependent and may be doc-only.*

## Design Under Test (DUT)

### 1800-2009/2012 Compatible RTL (`module5/dut/`)

- **decoder_inside.sv**: Decoder or FSM using `inside` for opcode/state check
  - **Example**: 2009/2012 operator; readable set membership

- **small_fsm_sv.sv**: FSM with optional immediate assertion (one-hot state)
  - **Example**: Assert in design; 2009/2012 assertion context

- **mem_array_sv.sv**: Simple memory with array; optional use of array semantics (2012)
  - **Example**: Array indexing and assignment; synthesis-safe subset

## Tests

### Module 5 Tests

- **test_decoder_inside.sv**: Decoder/FSM test
  - **Key Features**: Covers cases that use `inside`; no 2005-only assumptions

- **test_fsm_assert.sv**: FSM test with assertion on/off
  - **Key Features**: Exercises design; optional assertion failure injection

- **test_mem_array.sv**: Memory array test
  - **Key Features**: Array indexing and optional methods (if used in DUT)

## Learning Outcomes

By the end of this module, you should be able to:

- ✓ Describe what 1800-2009 and 1800-2012 add or clarify over 1800-2005 (interfaces, types, arrays, assertions, checkers)
- ✓ Use interface refinements (modport expressions, virtual interface) when the project and tool support 2009+
- ✓ Use `inside` and `==?` appropriately in RTL or testbenches
- ✓ Apply array and string refinements (2012) in testbenches or checkers; know the synthesizable subset for RTL
- ✓ Use immediate assertions in RTL for simple invariants; understand checker (2012) as reusable property block
- ✓ Summarize 1800-2005 vs 2009 vs 2012 and choose a standard based on tool and project

## Key Concepts

### 1800 Revisions (2005 → 2009 → 2012)

- **2005**: First SystemVerilog; logic, always_comb/always_ff, interfaces, packages, unique/priority case.
- **2009**: Interface refinements; type/operator/assertion clarifications and enhancements.
- **2012**: Checker; array/string methods and semantics; compilation unit clarifications.
- **Compatibility**: 2005 code is valid in 2009 and 2012; adopt new features when supported.

### Virtual Interface vs Concrete Interface

- **Concrete**: RTL connects to an interface instance (e.g. `bus_if bus()`).
- **Virtual**: Variable holding a handle to an interface; used in classes (testbench) to connect to different instances.

### inside and ==?

- **inside**: Set or range membership; clear and concise in case/if.
- **==?**: Wildcard equality; RHS X/Z are don’t-care; useful in comparisons.

### Assertions in Design

- **Immediate**: `assert (cond);` — executed when reached; use for invariants.
- **Concurrent**: `assert property (...);` — temporal; often in verification/bind.
- **Checker**: Reusable block of assertions/coverage (2012); bind to RTL or use in testbench.

## Exercises

1. **inside and ==?**
   - Rewrite a case or if-else chain using `inside` for a set of opcodes or states.
   - Use `==?` in a comparison where some bits are don’t-care; run simulation to confirm.

2. **Interface (2009)**
   - If your tool supports it, add a modport expression or use a virtual interface in a small testbench component; compare with a 2005-only interface connection.

3. **Immediate Assertion**
   - Add an immediate assertion in an existing RTL module (e.g. one-hot state, valid encoding); run simulation and trigger a failure to see the message.

4. **Checker (2012)**
   - If your tool supports checkers, write a small checker (e.g. one-hot or valid range) and bind it to a module; run simulation and observe pass/fail.

5. **Version Table**
   - Create a short table: 1800-2005 vs 2009 vs 2012 (design-relevant features only). List which revision your current tool supports and which features you can use.

## Common Pitfalls and How to Avoid Them

1. **Assuming 2009/2012 Features in an 2005-Only Flow**
   - **Mistake**: Using virtual interface, checker, or 2012 array methods when the project or tool is 1800-2005 only.
   - **Reality**: Compile or elaboration errors; or undefined behavior.
   - **Correct**: Confirm project standard and tool revision; use only features of that revision.
   - **Why**: Backward compatibility is 2005→2009→2012; tools may not implement all newer features.

2. **Virtual Interface in RTL**
   - **Mistake**: Using a virtual interface in synthesizable RTL.
   - **Reality**: Virtual interfaces are for dynamic binding (testbench); not for hardware.
   - **Correct**: Use concrete interface instances in RTL; use virtual interface only in testbench classes.
   - **Why**: Synthesis does not support virtual interface; it is a simulation construct.

3. **Checker Synthesis**
   - **Mistake**: Expecting a checker to be synthesized like a module.
   - **Reality**: Checkers are for assertion/coverage; typically not synthesized.
   - **Correct**: Use checkers for verification; keep RTL in modules.
   - **Why**: Checker semantics are for checking, not for netlist generation.

4. **Array Methods in RTL**
   - **Mistake**: Using dynamic array or queue methods (e.g. .push_back) in synthesizable RTL.
   - **Reality**: Many such methods are not synthesizable or are tool-specific.
   - **Correct**: In RTL use fixed-size or parameterized arrays and indexing; use methods in testbenches or checkers.
   - **Why**: Synthesis subset of SystemVerilog is smaller than the full language.

5. **$unit vs Package**
   - **Mistake**: Putting shared types or functions in $unit and relying on compilation order.
   - **Reality**: $unit visibility and order are tool-dependent; can cause subtle bugs.
   - **Correct**: Put shared items in packages; use explicit import.
   - **Why**: Packages give a clear namespace and import order; 2012 clarifies compilation unit but packages remain best practice.

## Next Steps

After completing this module, proceed to:

- **Module 6**: IEEE 1800-2017 — Current unified LRM; merged 1364 and 1800; final clarifications and design/verification features

## Additional Resources

### Module Documentation

- **Module 5 README**: [module5/README.md](../module5/README.md) — directory structure, quick start, and file map
- **Module 4**: [docs/MODULE4.md](MODULE4.md) — IEEE 1800-2005 (prerequisite)
- **Module 6**: [docs/MODULE6.md](MODULE6.md) — IEEE 1800-2017 (next)

### Reference Materials

- **IEEE Std 1800-2009**: IEEE Standard for SystemVerilog (Revision of 1800-2005)
- **IEEE Std 1800-2012**: IEEE Standard for SystemVerilog (Revision of 1800-2009)
- **IEEE Std 1800-2005**: For comparison (base SystemVerilog)
- **Tool Documentation**: Simulator and synthesis support for 1800-2009 and 1800-2012 (interfaces, checkers, array methods)

### Learning Path

1. **Start here**: Complete Module 5 examples using 2009/2012 features supported by your tool.
2. **Practice**: Add `inside` or `==?` to existing RTL; add one immediate assertion or checker.
3. **Compare**: Note which 2009/2012 features your tool supports vs the LRM.
4. **Prepare**: Before Module 6, list what you expect from 1800-2017 (merged LRM, current standard).

---

For questions or issues, refer to the main project documentation or the IEEE 1800-2009 and 1800-2012 standards for authoritative syntax and semantics.
