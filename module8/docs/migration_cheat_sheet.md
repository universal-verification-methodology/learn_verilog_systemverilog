# Migration Quick Reference and One-Page Cheat Sheet (Module 8)

## Migration Quick Reference

### 1364-1995 → 1364-2001

1. Ports → ANSI.
2. Combinational → always @*.
3. Add generate/signed/localparam if needed.
4. Test.

### 1364-2001/2005 → 1800 (design subset)

1. wire/reg → logic (single driver).
2. always @* → always_comb.
3. always @(posedge clk) → always_ff.
4. Optional: interfaces, packages, unique/priority case.
5. Remove defparam.
6. Test.

### 1800-2005 → 1800-2009/2012/2017

1. Run regression (usually compatible).
2. Optionally adopt 2009/2012/2017 features where supported.
3. Set project standard (e.g. 1800-2017).

### Rules of thumb

- One block (or one feature) at a time; test after each step.
- Keep external interface (ports or interface modport) unchanged during internal migration.
- One project standard and one subset; document in style guide.

**Full checklists**: See [MODULE7.md](../../docs/MODULE7.md) (migration checklist, version-selection checklist).

---

## One-Page Cheat Sheet (Printable)

**Version timeline**: 1364-1995 → 1364-2001 → 1364-2005 → 1800-2005 → 1800-2009 → 1800-2012 → 1800-2017.

**Verilog-only (1364)**: wire/reg, always @* or @(inputs), always @(posedge clk), ANSI ports (2001+), generate, signed, localparam; no logic, no interfaces, no packages.

**SystemVerilog design (1800)**: logic, always_comb, always_ff, interface+modport, package+import, unique/priority case; single driver per logic.

**Migration 1364→1800**: wire/reg→logic, always @*→always_comb, always @(posedge clk)→always_ff, optional interface/package, remove defparam, test.

**Version selection**: Match tools and IP; state one revision (e.g. 1800-2017) and subset (e.g. design only); document in style guide.

**Full details**: Modules 1–7; IEEE 1800-2017 LRM.

**Source**: [docs/MODULE8.md](../../docs/MODULE8.md) Sections 4 and 8.
