# Scripts — learn_verilog_systemverilog

## Media (slides, PDF, video)

| Script | Purpose |
|--------|---------|
| `build_all_media.sh` | Build **all** modules: pptx → pdf → video |
| `verify_all_media.sh` | Verify outlines, assets, and deliverables |
| `regenerate_media_outlines.sh` | Regenerate `media/moduleN/outline.yaml` from docs + EXAMPLES |
| `generate_examples_md.py` | Regenerate `moduleN/EXAMPLES.md` from `docs/MODULEN.md` |
| `patch_media_outlines.py` | Fix toolchain-check demo (no `moduleN.sh --check`) |

```bash
./scripts/build_all_media.sh
./scripts/build_all_media.sh --module 3
./scripts/verify_all_media.sh
```

Outputs: `media/moduleN/slides.pptx`, `slides.pdf`, `video.mp4`. See [media/README.md](../media/README.md).

## Module runners

From the **repository root** (requires [Icarus Verilog](http://iverilog.icarus.com/)):

| Script | Module |
|--------|--------|
| `module1.sh` | IEEE 1364-1995 (Verilog-95) |
| `module2.sh` | IEEE 1364-2001 |
| `module3.sh` | IEEE 1364-2005 |
| `module4.sh` | IEEE 1800-2005 (SystemVerilog design) |
| `module5.sh` | IEEE 1800-2009 / 2012 |
| `module6.sh` | IEEE 1800-2017 |
| `module7.sh` | Version comparison and migration |
| `module8.sh` | Quick reference |

```bash
chmod +x scripts/*.sh
./scripts/module1.sh
```
