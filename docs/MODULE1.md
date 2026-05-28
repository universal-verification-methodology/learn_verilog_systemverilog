# Module 1: IEEE 1364-1995 (Verilog-95)

**Goal**: Master the first standardized Verilog language (IEEE 1364-1995) and its core syntax for RTL design and simulation.

**Prerequisites**: None — this is the first module. Familiarity with digital logic (gates, flip-flops, RTL) is helpful.

**Estimated time**: 4–8 hours (examples + exercises + reading).


## Running Module 1

From the repo root:

- **Run all examples**: `./scripts/module1.sh`
- **Slides & video**: [slides.pptx](../media/module1/slides.pptx) · [slides.pdf](../media/module1/slides.pdf) · [video.mp4](../media/module1/video.mp4) — regenerate: `./scripts/build_all_media.sh --module 1`

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

This module establishes the foundation for the Verilog/SystemVerilog version-centric course. You'll learn the original Verilog language as defined by IEEE Std 1364-1995 (Verilog-95): modules, nets and variables, continuous assignments, procedural blocks, and basic testbench constructs. Understanding 1364-1995 is essential for reading legacy RTL and for appreciating what later IEEE versions add.

### Learning Resources

**IEEE Standard Reference**:
- **IEEE Std 1364-1995**: IEEE Standard Hardware Description Language Based on the Verilog Hardware Description Language
- Defines the first official Verilog standard; widely supported by simulators and synthesis tools
- Later versions (1364-2001, 1364-2005, 1800) extend this base

**When to Reference the Standard**:
- When checking exact syntax for port declarations, sensitivity lists, or task/function headers
- When writing or maintaining legacy RTL that must remain 1364-1995 compliant
- When comparing with Module 2 (1364-2001) and later modules to see what was added

## Topics Covered

### 1. IEEE 1364-1995 Context

IEEE Std 1364-1995 is the first official Verilog standard. It defines the language that tools and legacy code still support today.

#### What 1364-1995 Includes

- **Modules and hierarchy**: Module declaration, port list, instantiation
- **Nets**: `wire` (and `wand`, `wor`, `tri`; rarely used in RTL)
- **Variables**: `reg` for procedural assignment outputs
- **Continuous assignment**: `assign` for combinational logic
- **Procedural blocks**: `always`, `initial` with explicit sensitivity lists
- **Delays and timing**: `#`, `@`, `wait`
- **Tasks and functions**: Non-ANSI style (declarations separate from port list)
- **System tasks**: `$display`, `$monitor`, `$finish`, `$stop`, `$time`

#### What 1364-1995 Does Not Include

- No **ANSI-style port declarations** (added in 1364-2001)
- No **`always @*`** (added in 1364-2001)
- No **generate** (added in 1364-2001)
- No **signed** keyword, no multi-dimensional arrays (1364-2001)
- No **SystemVerilog**: no `logic`, `always_comb`, `always_ff`, interfaces, packages

### 2. Modules, Ports, and Hierarchy (1364-1995)

Modules are the top-level building blocks. In 1995, ports are declared in a separate list; port directions and types are given in the module body.

#### Module Declaration (1995 Style)

```verilog
// 1364-1995: Port list and port declarations are separate
module and_gate(a, b, y);    // Port list: names only
    input  a;                // Direction in body
    input  b;
    output y;

    wire a, b;               // Type in body (optional if wire is default)
    reg  y;                  // Output driven in always -> reg

    always @(a or b)
        y = a & b;
endmodule
```

- **Port list**: Only port names: `(a, b, y)`.
- **Port direction**: Declared inside the module: `input`, `output`.
- **Port type**: Declared inside the module: `wire` or `reg` (default for `input` is `wire`; for `output` can be `wire` or `reg`).

#### Module Instantiation (1995 Style)

```verilog
module top;
    wire in1, in2, out;

    and_gate u_and (.a(in1), .b(in2), .y(out));  // Named connection
    // or positional: and_gate u_and (in1, in2, out);
endmodule
```

- **Named port connection**: `.port_name(signal_name)` — recommended for readability.
- **Positional**: Order must match port list.

**Example**: `module1/examples/modules_ports/and_gate.v`

### 3. Nets and Variables: wire and reg

In 1364-1995, the main types are **nets** (`wire`) and **variables** (`reg`).

#### wire (Net)

- Represents a physical connection between components.
- Driven by **continuous assignment** (`assign`) or by **module output**.
- Cannot be assigned inside `always` or `initial` (use `reg` for that).

```verilog
wire w;
wire [7:0] bus;
assign w = a & b;
assign bus = 8'hFF;
```

#### reg (Variable)

- Holds a value; can be assigned in `always` or `initial`.
- **Does not** imply a flip-flop; flip-flops come from `always @(posedge clk)` (or similar).
- Used for outputs that are driven procedurally.

```verilog
reg q;
reg [7:0] counter;
always @(posedge clk)
    q <= d;
always @(a or b)
    q = a & b;   // combinational; q is still reg
```

#### 4-State Logic (1364-1995)

- Both `wire` and `reg` are **4-state**: `0`, `1`, `X` (unknown), `Z` (high-impedance).

**Example**: `module1/examples/nets_variables/data_types.v`

### 4. Continuous Assignment (assign)

Combinational logic can be described with one or more `assign` statements.

```verilog
module mux2_1995(a, b, sel, y);
    input  a, b, sel;
    output y;
    wire a, b, sel, y;

    assign y = sel ? b : a;   // 2:1 mux
endmodule
```

- **Right-hand side**: Any expression of `wire`/`reg` and operators.
- **Left-hand side**: Must be a `wire` (or similar net).

**Examples**: `module1/examples/continuous_assign/mux2.v`, `module1/examples/continuous_assign_gates/gates.v`, `module1/examples/adder/adder.v`

### 5. Procedural Blocks: always and initial (1364-1995)

#### always Block

- Repeated execution; sensitivity list defines when it runs.
- **1364-1995**: Sensitivity list is **mandatory and explicit** — no `@*`.

**Combinational (1995):**
```verilog
always @(a or b or c)   // Must list all inputs
    y = (a & b) | c;
```

**Sequential (1995):**
```verilog
always @(posedge clk)
    q <= d;
```

- Use **blocking** `=` for combinational, **nonblocking** `<=` for sequential (flip-flops).
- **Example (D flip-flop)**: `module1/examples/sequential_dff/dff.v`

#### initial Block

- Runs once at time zero. Used for testbenches: stimulus, `$display`, `$finish`.

```verilog
initial begin
    a = 0; b = 0;
    #10 a = 1;
    #10 b = 1;
    #10 $display("a=%b b=%b", a, b);
    #10 $finish;
end
```

**Example**: `module1/examples/procedural/always_initial.v`

### 6. Delays and Timing

- **`#n`**: Delay by `n` time units (e.g. `#10`).
- **`@(event)`**: Wait for event (e.g. `@(posedge clk)`).
- **`wait(condition)`**: Wait until condition is true.

```verilog
initial begin
    clk = 0;
    forever #5 clk = ~clk;   // Clock period 10
end
initial begin
    @(posedge clk);          // Sync to first posedge
    rst_n = 0;
    repeat(2) @(posedge clk);
    rst_n = 1;
end
```

**Example**: `module1/examples/delays_timing/timing.v`

### 7. Tasks and Functions (1995 Style)

In 1364-1995, task/function **ports are declared inside the body**, not in the header.

**Function (1995):**
```verilog
function [7:0] add8;
    input [7:0] a, b;
    begin
        add8 = a + b;
    end
endfunction
```

**Task (1995):**
```verilog
task apply_reset;
    begin
        rst_n = 0;
        #100;
        rst_n = 1;
        #20;
    end
endtask
```

- **Function**: Returns a single value; no delays (zero-time).
- **Task**: Can have delays and multiple outputs (output/inout args).

**Example**: `module1/examples/procedural/task_function_1995.v`

### 8. Simple Testbench (1364-1995)

A minimal testbench uses `initial`, `wire`/`reg`, DUT instantiation, delays, and system tasks.

```verilog
module test_and_gate;
    reg  a, b;
    wire y;

    and_gate u_dut (.a(a), .b(b), .y(y));

    initial begin
        $display("a b y");
        a = 0; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 0; b = 1; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 1; #10 $display("%b %b %b", a, b, y);
        $finish;
    end
endmodule
```

- **`$display`**: Print once.
- **`$monitor`**: Print whenever a listed signal changes (optional).
- **`$finish`**: End simulation.

**Example**: `module1/tests/test_and_gate.v`

## Examples

### Quick file reference

| Topic                    | Path                                      | Key files                          |
|--------------------------|-------------------------------------------|------------------------------------|
| Modules & ports          | `module1/examples/modules_ports/`         | `and_gate.v`                       |
| Nets & variables         | `module1/examples/nets_variables/`        | `data_types.v`                     |
| Continuous assignment   | `module1/examples/continuous_assign/`     | `mux2.v`                           |
| Continuous assign gates | `module1/examples/continuous_assign_gates/`| `gates.v`                          |
| Adder                    | `module1/examples/adder/`                 | `adder.v`                          |
| Procedural blocks        | `module1/examples/procedural/`            | `always_initial.v`, `task_function_1995.v` |
| Sequential DFF           | `module1/examples/sequential_dff/`        | `dff.v`                            |
| Delays & timing          | `module1/examples/delays_timing/`         | `timing.v`                         |
| Testbenches              | `module1/examples/testbenches/`           | `test_and_gate.v`                 |

### Module 1 Examples (1364-1995)

1. **Modules and Ports** (`examples/modules_ports/`)
   - 1995-style module declaration and port list
   - Named and positional instantiation
   - **Key Concepts**: Non-ANSI ports, separate direction/type declarations

2. **Nets and Variables** (`examples/nets_variables/`)
   - `wire` vs `reg`, vectors, 4-state values
   - **Key Concepts**: When to use wire vs reg, single driver per net

3. **Continuous Assignment** (`examples/continuous_assign/`)
   - `assign` for combinational logic (2:1 mux)
   - **Key Concepts**: Left-hand side must be net; expression on right

4. **Continuous Assignment Gates** (`examples/continuous_assign_gates/`)
   - XOR, NAND, NOR with `assign`
   - **Key Concepts**: Same as above; multiple gates in one example

5. **Adder** (`examples/adder/`)
   - Half adder and full adder with `assign` (sum and carry)
   - **Key Concepts**: Multi-output combinational logic; wire for all outputs

6. **Procedural Blocks** (`examples/procedural/`)
   - `always @(inputs)` and `always @(posedge clk)` with explicit sensitivity
   - `initial` for testbench; 1995-style task/function
   - **Key Concepts**: No `always @*`; blocking vs nonblocking

7. **Sequential D Flip-Flop** (`examples/sequential_dff/`)
   - D flip-flop with async reset: `always @(posedge clk or negedge rst_n)` and `<=`
   - **Key Concepts**: Edge-sensitive always; nonblocking for sequential logic

8. **Delays and Timing** (`examples/delays_timing/`)
   - `#n`, `@(posedge clk)`, `wait(condition)`; clock generation with `forever`
   - **Key Concepts**: Delay-based and event-based timing in testbenches

9. **Testbenches** (`examples/testbenches/`)
   - Minimal testbench with `initial`, `#`, `$display`, `$finish`
   - **Key Concepts**: Stimulus generation, termination with `$finish`

## Design Under Test (DUT)

### Simple Gates (`module1/dut/simple_gates/`)

- **and_gate.v**: 2-input AND (1364-1995 style)
  - Non-ANSI ports, `always @(a or b)` for combinational output
  - **Example**: Reference for 1995 module and procedural style

- **or_gate.v**: 2-input OR (1364-1995 style)
  - Same port and procedural style as `and_gate.v`

- **not_gate.v**: 1-input NOT (1364-1995 style)
  - Single-input combinational gate in 1995 style

### 2:1 Multiplexer (for tests)

- **mux2_1995**: Defined in `examples/continuous_assign/mux2.v` and copied as `tests/mux2_1995.v` for standalone test runs.
  - `assign` for combinational logic; all ports `wire`
  - **Example**: Continuous assignment pattern

## Tests

### Module 1 Tests

- **test_and_gate.v**: AND gate testbench
  - Exhaustive input combinations; `$display` and `$finish`
  - **Key Features**: 1364-1995 testbench style, no SystemVerilog

- **test_mux2.v**: 2:1 mux testbench
  - All input combinations; delay-based stimulus
  - **Key Features**: Verifying combinational logic with 1995 syntax only

## Learning Outcomes

By the end of this module, you should be able to:

- ✓ Write modules in IEEE 1364-1995 style (non-ANSI ports, explicit sensitivity)
- ✓ Use `wire` and `reg` correctly for nets and procedural outputs
- ✓ Describe combinational logic with `assign` and `always @(inputs)`
- ✓ Describe sequential logic with `always @(posedge clk)` and nonblocking assignment
- ✓ Use `initial`, `#`, `@`, and `wait` for testbenches
- ✓ Use 1364-1995 tasks and functions (non-ANSI form)
- ✓ State what 1364-1995 does not include (ANSI, `@*`, generate, SystemVerilog)

## Key Concepts

### wire vs reg (1364-1995)

- **Use `wire` for**: Continuous assignments, module connections, inputs
- **Use `reg` for**: Outputs (and internal signals) driven in `always` or `initial`
- **Remember**: `reg` does not imply a register; flip-flops come from clocked `always` blocks

### Sensitivity Lists (1364-1995)

- **Combinational**: List every input: `always @(a or b or c)`
- **Sequential**: Edge: `always @(posedge clk)` or `always @(negedge rst_n)`
- **No `always @*`** in 1995; that is introduced in 1364-2001 (Module 2)

### Blocking vs Nonblocking (Preview)

- **Blocking (=)**: For combinational logic in `always @(inputs)` blocks
- **Nonblocking (<=)**: For sequential logic in `always @(posedge clk)` blocks

**Note**: Covered in more detail in later modules; following this convention in 1995 avoids RTL/synthesis issues.

### 1364-1995 Limitations (What Comes Later)

- **Module 2 (1364-2001)**: ANSI ports, `always @*`, generate, signed, multi-dimensional arrays
- **Module 4+ (1800)**: `logic`, `always_comb`/`always_ff`, interfaces, packages

## Exercises

1. **Module and Ports (1995)**
   - Write a 2:1 mux module with 1995 port style (port list + separate direction/type)
   - Instantiate it in a top module with named connections
   - List all inputs in the mux's combinational `always` sensitivity list

2. **wire vs reg**
   - Implement a small adder with `assign` (output as `wire`)
   - Implement the same adder with an `always @(a or b)` block (output as `reg`)
   - Compare and note when each style is appropriate

3. **Simple Testbench**
   - Write an `initial` block that exercises the mux for all input combinations
   - Use `$display` and `$finish`
   - Optionally add a clock with `forever #5 clk = ~clk`

4. **Limitations**
   - Try writing the same mux with `always @*` and confirm it is not part of 1364-1995 (it will work in 2001+ tools but is outside 1995)
   - List three features you expect to see in Module 2 (1364-2001)

## Common Pitfalls and How to Avoid Them

1. **Incomplete Sensitivity List**
   - **Mistake**: `always @(sel) y = sel ? b : a;` (missing `a` and `b`)
   - **Reality**: In 1364-1995 you must list every input that the block reads
   - **Correct**: `always @(a or b or sel) y = sel ? b : a;`
   - **Why**: Incomplete lists cause simulation/synthesis mismatches and inferred latches

2. **Port Type Mismatch**
   - **Mistake**: Declaring as `wire` an output that is assigned in `always`
   - **Reality**: Outputs driven in procedural blocks must be `reg`
   - **Correct**: `output y; reg y;` when `y` is assigned in `always`
   - **Why**: `wire` cannot be the target of procedural assignment

3. **Simulation Never Ends**
   - **Mistake**: Testbench without `$finish`
   - **Correct**: Always call `$finish` after stimulus (e.g. `#1000; $finish;`)
   - **Why**: Simulator runs until explicit termination or limit

4. **Using 2001/SystemVerilog Constructs in 1995**
   - **Mistake**: Writing `always @*` or ANSI ports and assuming 1995
   - **Reality**: `always @*` and ANSI ports are 1364-2001; `logic`/`always_comb` are SystemVerilog
   - **Correct**: For strict 1995, use explicit sensitivity and non-ANSI ports
   - **Why**: Keeps code portable to 1995-only tools and clarifies version scope

5. **Confusing reg with Registers**
   - **Mistake**: Thinking `reg` creates a flip-flop
   - **Reality**: `reg` is a variable type; flip-flops come from `always @(posedge clk)` with `<=`
   - **Correct**: Use `reg` for any procedural output; use clocked `always` for sequential logic
   - **Why**: Clarifies design intent and avoids synthesis surprises

## Next Steps

After completing this module, proceed to:

- **Module 2**: IEEE 1364-2001 — ANSI ports, `always @*`, generate, signed types, and other 2001 additions

## Additional Resources

### Module Documentation

- **Module 1 README**: [module1/README.md](../module1/README.md) — directory structure, quick start, and file map
- **Module 2**: [docs/MODULE2.md](MODULE2.md) — IEEE 1364-2001 (next)

### Reference Materials

- **IEEE Std 1364-1995**: IEEE Standard Hardware Description Language Based on the Verilog Hardware Description Language
- **IEEE Std 1364-2001**: For comparison (ANSI ports, generate, `always @*`, signed, etc.)
- **Tool Documentation**: Icarus Verilog, Verilator, or your simulator’s “Verilog 1995” compatibility notes

### Learning Path

1. **Start here**: Complete Module 1 examples and exercises using 1364-1995 only
2. **Practice**: Write small modules (gates, mux, simple FSM) in strict 1995 style
3. **Compare**: After Module 2, reimplement one design in 2001 style and note differences
4. **Verify**: Run all examples with a simulator; ensure no 2001/SystemVerilog extensions are used if targeting 1995

---

For questions or issues, refer to the main project documentation or the IEEE 1364-1995 standard for authoritative syntax.
