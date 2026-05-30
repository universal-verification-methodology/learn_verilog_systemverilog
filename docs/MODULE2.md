# Module 2: IEEE 1364-2001 (Verilog-2001)

**Goal**: Master the major Verilog update (IEEE 1364-2001) and its additions over 1364-1995: ANSI ports, implicit sensitivity, generate, signed types, and multi-dimensional arrays.

**Prerequisites**: Module 1 (IEEE 1364-1995) — you should be comfortable with modules, `wire`/`reg`, `assign`, `always`/`initial`, and 1995 port style.

**Estimated time**: 6–10 hours (examples + exercises + reading).


## Running Module 2

From the repo root:

- **Run all examples**: `./scripts/module2.sh`
- **Slides & video**: [slides.pptx](../media/module2/slides.pptx) · [slides.pdf](../media/module2/slides.pdf) · [video.mp4](../media/module2/video.mp4) — regenerate: `./scripts/build_all_media.sh --module 2`



## How to Learn This Module

Follow this path to learn **IEEE 1364-2001 (Verilog-2001)** in order:

1. **Skim this document** — Goal, Overview, and Topics Covered set the IEEE scope for Module 2.
2. **Study design architecture** — See how DUTs, examples, and testbenches fit together under `module2/`.
3. **Work through labs in order** — Open `module2/EXAMPLES.md` and run each `make clean && make run` from the repo root.
4. **Run the full module script** — `./scripts/module2.sh` from the repo root to simulate all examples and tests.
5. **Complete the exercises** — Try each exercise in this document before reading solutions or peeking at reference RTL.
6. **Review Common Pitfalls** — Can you explain each mistake and the fix?
7. **Self-check** — Use `module2/CHECKLIST.md` before starting the next module.

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

This module covers IEEE Std 1364-2001 (Verilog-2001), the first major revision of the Verilog standard. You'll learn what 2001 adds over 1995: ANSI-style port and task/function declarations, `always @*` for combinational logic, generate blocks for parameterized and conditional hierarchy, signed arithmetic, and multi-dimensional arrays. These features are the basis for most modern Verilog RTL and are required before moving to 1364-2005 and SystemVerilog (Module 4+).

### Learning Resources

**IEEE Standard Reference**:
- **IEEE Std 1364-2001**: IEEE Standard Verilog Hardware Description Language
- Major update over 1364-1995; widely supported by current tools
- 1364-2005 (Module 3) is a minor revision; 1800 (Module 4+) builds on 1364

**When to Reference the Standard**:
- When checking exact syntax for ANSI ports, generate, or signed semantics
- When writing RTL that must be 1364-2001 compliant (no SystemVerilog)
- When comparing with Module 1 (1995) and Module 3 (2005) to see what changed

## Topics Covered

### 1. IEEE 1364-2001 Context

IEEE Std 1364-2001 is the first major revision after 1995. It addresses common RTL needs and reduces errors from manual sensitivity lists and port duplication.

#### What 1364-2001 Adds Over 1995

- **ANSI-style port declarations**: Direction and type (and size) in the port list
- **`always @*`**: Implicit sensitivity for combinational logic (no manual list)
- **generate**: Conditional and loop-based instantiation and logic
- **signed**: Signed arithmetic and signed nets/variables
- **Multi-dimensional arrays**: e.g. `reg [7:0] mem [0:255]`
- **localparam**: Named constants that cannot be overridden
- **ANSI-style task/function**: Input/output in the header
- **Other**: File I/O improvements, `$signed`/`$unsigned`, attribute syntax, etc.

#### What 1364-2001 Still Does Not Include

- No **SystemVerilog**: no `logic`, `always_comb`/`always_ff`, interfaces, packages, classes
- No **type parameters** or **interfaces** (those are 1800)

### 2. ANSI-Style Port Declarations (2001)

Port direction and type can be declared directly in the port list. This avoids duplication and reduces errors.

#### ANSI-C Style Ports

```verilog
// 1364-2001: ANSI style — direction and type in port list
module and_gate (
    input  wire a,
    input  wire b,
    output reg  y
);
    always @(a or b)   // or always @*
        y = a & b;
endmodule
```

- **input wire**: Default for input; can omit `wire` (e.g. `input [7:0] a`).
- **output reg**: Required when the output is driven in `always`/`initial`.
- **output wire**: When the output is driven only by `assign` or submodule.

#### Comparison: 1995 vs 2001 Port Style

**1995 (Module 1):**
```verilog
module mux(a, b, sel, y);
    input  a, b, sel;
    output y;
    wire a, b, sel;
    reg  y;
    // ...
endmodule
```

**2001:**
```verilog
module mux (
    input  wire a, b, sel,
    output reg  y
);
    // ...
endmodule
```

- Same behavior; 2001 is more concise and keeps port and type in one place.

**Example**: `module2/examples/ansi_ports/mux2.v`

### 3. Implicit Sensitivity: always @* (2001)

Combinational logic can use `always @*` so the simulator infers the sensitivity list from the right-hand sides. This reduces mistakes from forgetting an input.

#### always @* Syntax

```verilog
// 1364-2001: Implicit sensitivity — no manual list
always @* begin
    y = a & b;           // Sensitive to a, b
end

always @* begin
    mux_out = sel ? b : a;   // Sensitive to sel, a, b
end
```

- **`@*`** (or **`@(*)`**): Sensitive to every signal read in the block (RHS and conditions).
- Use for **combinational logic only**; do not use for sequential (use `always @(posedge clk)`).

#### When to Use @* vs Explicit List

- **Prefer `@*`**: For combinational blocks; fewer errors, easier to maintain.
- **Explicit list**: When targeting strict 1995 compatibility or when a tool does not support `@*`.

**Example**: `module2/examples/procedural/always_star.v`

### 4. Generate (2001)

Generate blocks allow conditional and loop-based instantiation of modules and procedural logic. They are essential for parameterized, scalable RTL.

#### generate / endgenerate

```verilog
module shift_reg #(parameter N = 8) (
    input  wire clk, rst_n, sin,
    output wire sout
);
    wire [N-1:0] q;
    assign q[0] = sin;
    assign sout = q[N-1];

    generate
        genvar i;
        for (i = 1; i < N; i = i + 1) begin : gen_ff
            dff u_ff (
                .clk(clk), .rst_n(rst_n),
                .d(q[i-1]), .q(q[i])
            );
        end
    endgenerate
endmodule
```

- **genvar**: Loop variable for generate loops; not a runtime variable.
- **generate for**: Replicates logic/instances; index must be constant at elaboration.

#### Conditional Generate

```verilog
generate
    if (WIDTH == 8)
        assign y = a + b;
    else if (WIDTH == 16)
        assign y = {8'b0, a} + {8'b0, b};
    else
        initial $error("Unsupported WIDTH");
endgenerate
```

- **generate if / else**: Choose one of several implementations at elaboration.

**Example**: `module2/examples/generate/param_mux.v`

### 5. Signed Types (2001)

The **signed** keyword allows signed arithmetic on nets and variables. Operators treat the value as two's complement.

#### signed Wire and reg

```verilog
reg signed [7:0] a, b;   // Range -128 to 127
wire signed [15:0] sum;

assign sum = a + b;   // Signed addition
```

- **signed**: Affects arithmetic and comparison in expressions involving that net/reg.
- **Unsigned** (default): No sign extension; values 0 to 2^N-1.

#### $signed and $unsigned

Cast for one expression without changing the declaration:

```verilog
wire [7:0] u;
reg [7:0] v;
assign u = $unsigned(a) + $unsigned(b);   // Treat a, b as unsigned
assign v = $signed(x) + $signed(y);       // Treat x, y as signed
```

**Example**: `module2/examples/signed/adder_signed.v`

### 6. Multi-Dimensional Arrays (2001)

Arrays can have multiple dimensions. Common use: memory arrays.

#### Declaration and Usage

```verilog
reg [7:0] mem [0:255];      // 256 bytes: 8-bit data, 8-bit address
reg [31:0] buf [0:3][0:7];  // 4x8 array of 32-bit words

// Access
mem[addr] = data;
data_out = mem[addr];

// Initialization (in initial block)
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1)
        mem[i] = 8'b0;
end
```

- **Packed** (left): `[7:0]` — contiguous bits, can be used as a single vector.
- **Unpacked** (right): `[0:255]` — array of elements; select with one index at a time in 2001.

**Example**: `module2/examples/arrays/ram_simple.v`

### 7. localparam (2001)

**localparam** defines constants that cannot be overridden at instantiation. Useful for derived values and internal constants.

```verilog
module counter #(parameter WIDTH = 8) (
    input  wire clk, rst_n, en,
    output reg  [WIDTH-1:0] count
);
    localparam MAX = (1 << WIDTH) - 1;   // 2^WIDTH - 1

    always @(posedge clk) begin
        if (!rst_n)
            count <= 0;
        else if (en)
            count <= (count == MAX) ? 0 : count + 1;
    end
endmodule
```

- **parameter**: Can be overridden: `#(.WIDTH(16))`.
- **localparam**: Cannot be overridden; often derived from parameters or fixed.

**Example**: `module2/examples/parameters/counter_param.v`

### 8. ANSI-Style Tasks and Functions (2001)

Task and function inputs/outputs can be declared in the header, similar to module ports.

#### Function (2001 ANSI)

```verilog
function automatic [7:0] add8(input [7:0] a, input [7:0] b);
    add8 = a + b;
endfunction
```

#### Task (2001 ANSI)

```verilog
task automatic apply_reset(output reg rst_n);
    rst_n = 0;
    #100;
    rst_n = 1;
    #20;
endtask
```

- **automatic**: Optional; gives automatic storage (re-entrant). Useful for recursive or concurrent calls.
- **input/output in header**: Cleaner than 1995 style; avoids duplicate declarations.
- **Note**: In 1364-2001 use `output reg` (not `output logic`; `logic` is SystemVerilog).

**Example**: `module2/examples/tasks_functions/ansi_task_func.v`

## Examples

### Quick file reference

| Topic                | Path                                        | Key files |
|----------------------|---------------------------------------------|-----------|
| ANSI ports           | `module2/examples/ansi_ports/`              | `mux2.v` |
| always @*            | `module2/examples/procedural/`              | `always_star.v` |
| generate             | `module2/examples/generate/`                | `param_mux.v` |
| generate if/else      | `module2/examples/generate_if/`             | `gen_if.v` |
| Generate ripple adder| `module2/examples/generate_ripple_adder/`   | `ripple_adder.v` |
| Signed               | `module2/examples/signed/`                  | `adder_signed.v` |
| Signed vs unsigned   | `module2/examples/signed_compare/`          | `signed_compare.v` |
| Decoder              | `module2/examples/decoder/`                 | `decoder.v` |
| Multi-dim arrays     | `module2/examples/arrays/`                  | `ram_simple.v` |
| Multi-dim style      | `module2/examples/multi_dim_arrays/`        | `multi_dim.v` |
| Parameters/localparam| `module2/examples/parameters/`             | `counter_param.v` |
| ANSI task/function   | `module2/examples/tasks_functions/`         | `ansi_task_func.v` |
| ANSI task with output| `module2/examples/task_ansi/`               | `task_ansi.v` |

### Module 2 Examples (1364-2001)

1. **ANSI Ports** (`examples/ansi_ports/`)
   - Module and instantiation with ANSI-style ports
   - **Key Concepts**: Port direction and type in port list

2. **always @*** (`examples/procedural/`)
   - Combinational blocks with implicit sensitivity
   - **Key Concepts**: No manual sensitivity list; tool infers from RHS

3. **Generate** (`examples/generate/`)
   - Parameterized mux; generate-style parameterization
   - **Key Concepts**: genvar, elaboration-time logic

4. **Generate if/else** (`examples/generate_if/`)
   - Conditional implementation by parameter (e.g. USE_CLIP wrap vs saturate)
   - **Key Concepts**: generate if/else at elaboration

5. **Generate Ripple Adder** (`examples/generate_ripple_adder/`)
   - N-bit ripple-carry adder using generate for (full_adder instances)
   - **Key Concepts**: genvar loop, replicated hierarchy

6. **Signed** (`examples/signed/`)
   - signed reg/wire, $signed/$unsigned
   - **Key Concepts**: Two's complement arithmetic in RTL

7. **Signed vs Unsigned Comparison** (`examples/signed_compare/`)
   - $signed() in expressions; a &lt; b unsigned vs signed
   - **Key Concepts**: Cast in expressions without changing declaration

8. **Decoder** (`examples/decoder/`)
   - 2:4 decoder with ANSI ports and always @* (case)
   - **Key Concepts**: Combinational case; one-hot output

9. **Multi-Dimensional Arrays** (`examples/arrays/`)
   - Memory-style arrays (reg [7:0] mem [0:255]), indexing
   - **Key Concepts**: Packed vs unpacked; array indexing rules in 2001

10. **Multi-Dim Style** (`examples/multi_dim_arrays/`)
    - 2x4 buffer using 1D array indexed as row*4+col
    - **Key Concepts**: Emulating 2D with 1D array; index expression

11. **Parameters and localparam** (`examples/parameters/`)
    - Parameter override, localparam for derived constants
    - **Key Concepts**: When to use parameter vs localparam

12. **ANSI Task/Function** (`examples/tasks_functions/`)
    - Input/output in header, automatic functions
    - **Key Concepts**: 2001 style vs 1995 style

13. **ANSI Task with Output** (`examples/task_ansi/`)
    - task automatic apply_reset(output reg rn); begin/end body
    - **Key Concepts**: Task with output argument; testbench reset pattern

## Design Under Test (DUT)

### Parameterized and Generate-Based (`module2/dut/`)

- **mux_2to1_param.v**: Parameterized 2:1 mux (ANSI ports, parameter)
  - **Example**: ANSI ports + parameter; reusable width

- **dff.v**: D flip-flop (used by shift_reg_gen)
  - Single-bit register; instantiated inside generate in shift_reg_gen

- **shift_reg_gen.v**: Shift register using generate for
  - **Example**: generate for with genvar; scalable hierarchy

- **counter_param.v**: Counter with localparam (MAX derived from WIDTH)
  - **Example**: parameter, localparam, 2001 procedural style; wrap at MAX

## Tests

### Module 2 Tests

- **test_mux_param.v**: Parameterized mux test (1-bit and 8-bit)
  - **Key Features**: Parameter override, exhaustive patterns

- **test_shift_reg_gen.v**: Generate-based shift register test
  - **Key Features**: Multiple lengths via parameter

- **test_counter_param.v**: Counter with localparam test
  - **Key Features**: Reset, enable, wrap-around; tests `dut/counter_param.v`

## Learning Outcomes

By the end of this module, you should be able to:

- ✓ Write modules with ANSI-style port declarations (1364-2001)
- ✓ Use `always @*` for combinational logic and avoid sensitivity-list errors
- ✓ Use generate (for, if/else) for parameterized and conditional RTL
- ✓ Use signed types and $signed/$unsigned for signed arithmetic
- ✓ Declare and use multi-dimensional arrays (e.g. memories)
- ✓ Use localparam for constants that must not be overridden
- ✓ Write ANSI-style tasks and functions
- ✓ Compare 1364-1995 and 1364-2001 and list what 2001 adds

## Key Concepts

### 1995 vs 2001 Port Style

- **1995**: Port list names only; direction and type inside module body.
- **2001**: Port list can include direction and type (ANSI); single place for port definition.
- **Recommendation**: Use ANSI style for new RTL unless 1995 compatibility is required.

### always @* vs Explicit Sensitivity

- **always @***: Sensitive to every identifier read in the block; preferred for combinational.
- **Explicit @(a or b or ...)**: Required in 1995; use in 2001 only when needed for compatibility or tool quirks.

### Generate Scope

- **genvar**: Only for generate loops; not visible at simulation.
- **generate blocks**: Elaborated once; conditionals and loops are compile-time.

### signed Semantics

- **signed** on a net/reg: Arithmetic and comparisons use two's complement.
- **$signed() / $unsigned()**: One-expression cast without changing declaration.

### parameter vs localparam

- **parameter**: Configurable at instantiation; use for design configurability.
- **localparam**: Not overridable; use for derived or fixed constants.

## Exercises

1. **ANSI Ports**
   - Take a Module 1 design (e.g. 2:1 mux) and rewrite it with ANSI ports.
   - Compare line count and readability with the 1995 version.

2. **always @***
   - Convert every combinational `always @(a or b or ...)` in a small design to `always @*`.
   - Run simulation to confirm behavior is unchanged.

3. **Generate**
   - Build an N-bit ripple-carry adder using generate for (N from parameter).
   - Add a generate if to support both “full” and “reduced” width modes.

4. **Signed**
   - Implement a signed 8-bit saturating adder (clamp at -128 and 127).
   - Use $signed in one version and signed reg in another; compare.

5. **Arrays and localparam**
   - Implement a simple 256x8 RAM with one read and one write port; use localparam for depth/width.
   - Initialize the array in an initial block (optional: load from file).

## Common Pitfalls and How to Avoid Them

1. **Using always @* for Sequential Logic**
   - **Mistake**: `always @* q <= d;` intending a flip-flop.
   - **Reality**: `@*` is for combinational logic; it does not create a clock edge.
   - **Correct**: Use `always @(posedge clk)` (and `<=`) for sequential logic.
   - **Why**: Mixing the two causes simulation/synthesis mismatches and unintended latches.

2. **genvar in Normal Code**
   - **Mistake**: Using genvar in an always block or initial block.
   - **Reality**: genvar is only for generate loops; it does not exist at runtime.
   - **Correct**: Use integer or reg for runtime loops; use genvar only inside generate for.
   - **Why**: genvar is elaborated away; it is not a simulation variable.

3. **Overriding localparam**
   - **Mistake**: Trying to override localparam at instantiation (e.g. `#(.MAX(100))`).
   - **Reality**: localparam cannot be overridden.
   - **Correct**: Use parameter for values that must be overridden; use localparam for fixed or derived constants.
   - **Why**: The standard does not allow localparam in the parameter list.

4. **Signed vs Unsigned Mix**
   - **Mistake**: Mixing signed and unsigned in one expression without $signed/$unsigned and expecting a particular sign behavior.
   - **Reality**: Rules for sign extension and comparison depend on operands.
   - **Correct**: Be explicit: use signed types or $signed/$unsigned and verify with testbenches.
   - **Why**: Implicit mixing leads to wrong arithmetic and comparison results.

5. **Generate Block Scope**
   - **Mistake**: Referencing generate block names or genvar at runtime.
   - **Reality**: Generate blocks are elaborated at compile time; names are for hierarchy.
   - **Correct**: Use generate for structure; use normal variables and blocks for runtime behavior.
   - **Why**: Generate is not “runtime”; it only affects what gets instantiated.

## Next Steps

After completing this module, proceed to:

- **Module 3**: IEEE 1364-2005 — Final Verilog-only standard; clarifications and minor additions before SystemVerilog

## Additional Resources

### Module Documentation

- **Module 2 README**: [module2/README.md](../module2/README.md) — directory structure, quick start, and file map
- **Module 1**: [docs/MODULE1.md](MODULE1.md) — IEEE 1364-1995 (prerequisite)
- **Module 3**: [docs/MODULE3.md](MODULE3.md) — IEEE 1364-2005 (next)

### Reference Materials

- **IEEE Std 1364-2001**: IEEE Standard Verilog Hardware Description Language
- **IEEE Std 1364-1995**: For comparison (what 2001 adds)
- **IEEE Std 1364-2005**: For comparison (minor updates after 2001)
- **Tool Documentation**: Simulator and synthesis support for 1364-2001 (generate, signed, @*)

### Learning Path

1. **Start here**: Complete Module 2 examples using 1364-2001 features only (no SystemVerilog).
2. **Practice**: Convert Module 1 designs to 2001 style (ANSI ports, @*, generate where useful).
3. **Compare**: Keep one design in both 1995 and 2001 form and note the differences.
4. **Verify**: Run all examples; ensure no 1800-only constructs (logic, interfaces, etc.) if targeting pure 1364.

---

For questions or issues, refer to the main project documentation or the IEEE 1364-2001 standard for authoritative syntax.
