# Course media — slides, PDF, and video

Generated teaching assets for each module. Source content: `docs/MODULEN.md`, `moduleN/EXAMPLES.md`, and `moduleN/examples/` labs.

See [INDEX.md](INDEX.md) for links to every module’s PPTX, PDF, and video.

## Build (one command)

From the `learn_verilog_systemverilog` repo root:

```bash
./scripts/build_all_media.sh
```

| Flag | Purpose |
|------|---------|
| `--install-deps` | `sudo apt install` LibreOffice, ffmpeg, poppler, iverilog |
| `--pptx-only` | Skip PDF and video |
| `--module 2` | Single module |
| `--regenerate-outlines` | Refresh `outline.yaml` from docs + EXAMPLES |
| `--regenerate-examples` | Refresh `moduleN/EXAMPLES.md` from MODULE*.md |
| `--run-demos` | Run `make` captures during verify (slow; needs iverilog) |

Requires the Cursor skill: `~/.cursor/skills/module-to-slides-video` (run `bash …/scripts/setup.sh` once).

## Per-module outputs

| File | Description |
|------|-------------|
| `outline.yaml` | Slide plan (machine input for `build_slides.py`) |
| `script.md` | Narration / timing notes for video |
| `assets/manifest.yaml` | Images and demo capture commands |
| `slides.pptx` | **Primary deck** — edit in PowerPoint |
| `slides.pdf` | PDF export |
| `video.mp4` | Silent preview (~8 s/slide; add `audio/narration.wav` for voice) |

## Review all modules

```bash
ls -lh media/module*/slides.{pptx,pdf} media/module*/video.mp4
```

## Regenerate from docs

```bash
python3 scripts/generate_examples_md.py
./scripts/build_all_media.sh --regenerate-outlines
```

Edit `outline.yaml` by hand after generation to refine slides from `docs/MODULEN.md`.

## Git

Intermediate files under `frames/` and `*.log` are gitignored. Commit `slides.pptx` / `slides.pdf` / `video.mp4` if you want them in the repo (large files).
