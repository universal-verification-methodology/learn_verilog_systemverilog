# Construct-by-Standard Table (Module 8 Quick Reference)

Use this table to see **when a construct was introduced** (or clarified). “Introduced” = first standard that defines it; “Clarified” = later standard refines it.

| Construct / topic           | 1364-1995 | 1364-2001 | 1364-2005 | 1800-2005 | 1800-2009 | 1800-2012 | 1800-2017 |
|----------------------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
| Non-ANSI ports             | ✓         |           |           |           |           |           |           |
| ANSI ports                 |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| wire, reg                  | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| logic                      |           |           |           | ✓         | ✓         | ✓         | ✓         |
| always @*                  |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| always_comb, always_ff     |           |           |           | ✓         | ✓         | ✓         | ✓         |
| generate                   |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| signed                     |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| localparam                 |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| defparam                   | ✓         | ✓         | deprecated| —         | —         | —         | —         |
| Multi-dim arrays           |           | ✓         | ✓         | ✓         | ✓         | ✓         | ✓         |
| interface, modport         |           |           |           | ✓         | ✓         | ✓         | ✓         |
| package, import           |           |           |           | ✓         | ✓         | ✓         | ✓         |
| unique case, priority case |           |           |           | ✓         | ✓         | ✓         | ✓         |
| Virtual interface          |           |           |           |           | ✓         | ✓         | ✓         |
| Checker                    |           |           |           |           |           | ✓         | ✓         |
| Unified LRM (1364+1800)    |           |           |           |           |           |           | ✓         |

**Use**: To decide “minimum standard” for a construct or to check “is X in 1364-2005?”.

**Source**: [docs/MODULE8.md](../../docs/MODULE8.md) Section 2.
