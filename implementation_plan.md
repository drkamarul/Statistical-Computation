# Implementation Plan: Six Part Reorganisation (2026-10-15)

> **For agentic workers:** Invoke `quarto-skill` before touching any `.qmd`.
> Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reorganise the deck into Part 0 (objectives), Part 1 (setup),
Part 2 (RREAAAPP, shortened), Part 3 (AI assistants), Part 4 (hands-on) and an
appendix, as set out in the "Slide structure" section of `CLAUDE.md`. Output is
still one standalone deck, `statistical-computation.html`.

**Spec:** [docs/superpowers/specs/2026-10-15-six-part-reorganisation-design.md](docs/superpowers/specs/2026-10-15-six-part-reorganisation-design.md)
**Rules:** [CLAUDE.md](CLAUDE.md) (mirrored in [AGENTS.md](AGENTS.md))
**Brief:** [About_This_Project.md](About_This_Project.md)

The previous plan (2026-10-14 RREAAAPP revision, complete) is in git history at
commit `705c6d6`.

## Global constraints

- **RREAAAPP**, eight stages: Reason, Read, Explore, Assume, Apply, Assess,
  Present, Publish. No "REAAAPP" anywhere in slides or docs.
- Max **5 top-level bullets** per slide; budget **2 / 8 / 13 / 25 / 3 / 4**.
- Speaker notes are prose, never `- ` bullets.
- **Max 6 screenshots**, real products only, under `images/screenshots/`.
- Code fences are plain ` ```r `, never executable; a Quarto cell shown on a
  slide is written ` ```{{r}} ` inside a ` ```markdown ` fence.
- No `[@key]` citations on slides.
- No dataset committed; no CI, no Pages, no website.

## Model use

- Opus 5.5: slide writing, RREAAAPP rewrite, docs, screenshots.
- Sonnet 5.5: read-only web check of Part 1 install facts (done 2026-10-15).
- Haiku 5.5: final read-only consistency sweep.

## Status

- [x] Task 0: CLAUDE.md, AGENTS.md, new spec, this plan (2026-10-15)
- [x] Task 1: linter budget
- [x] Task 2: file renames and deck includes
- [x] Task 3: Part 0 and Part 1 slides
- [x] Task 4: Part 2 rewrite (25 → 13)
- [x] Task 5: Part 3, Part 4, appendix, `references.bib`
- [x] Task 6: three new screenshots
- [ ] Task 7: verified 2026-10-15 (lint, render, browser, sweep); commit and push await the author

---

## Task 1: Linter (`scripts/check_slides.R`)

- [x] `BUDGET`: `_part0-objectives.qmd` 2, `_part1-setup.qmd` 8,
  `_part2-workflow.qmd` 13, `_part3-ai-assistants.qmd` 25,
  `_part4-hands-on.qmd` 3, `_appendix.qmd` 4.
- [x] Build the success message from `BUDGET`, not a hard-coded string.
- [x] `MAX_BULLETS` and `MAX_SCREENSHOTS` unchanged.

## Task 2: Files

- [x] `git mv _part1-workflow.qmd _part2-workflow.qmd`
- [x] `git mv _part2-ai-assistants.qmd _part3-ai-assistants.qmd`
- [x] `git mv _part3-hands-on.qmd _part4-hands-on.qmd`
- [x] Create `_part0-objectives.qmd` and `_part1-setup.qmd`.
- [x] `statistical-computation.qmd`: six includes in order; YAML unchanged.

## Task 3: Part 0 and Part 1

- [x] Part 0: Learning Objectives; Today's Plan table.
- [x] Part 1: divider; Positron (move from old Part 1); Quarto file; Quarto
  YAML and structure; Antigravity 2.0 install; Claude Desktop (optional);
  GitHub (move from old Part 1); ready checklist.

## Task 4: Part 2 rewrite

- [x] Divider; Why (merged with "where workflows break down"); At a glance
  (absorbs "how each stage is presented").
- [x] Eight stage slides: goal, Knowledge 3 + Skill 2, Tools note; old bullets
  as prose speaker notes.
- [x] Reproducibility; recap without the setup line.

## Task 5: Part 3, Part 4, appendix

- [x] Retitle dividers to Part 3 and Part 4.
- [x] Claude Code slide: point back to the Part 1 install.
- [x] Appendix references: add Positron, Quarto, Claude Desktop URLs, still
  five bullets per slide.
- [x] `references.bib`: entries for Positron, Quarto, Claude Desktop, accessed
  2026-10-15.

## Task 6: Screenshots (computer-use)

- [x] `04-quarto-positron.jpg`: a demo `.qmd` in a scratch folder, YAML visible.
- [x] `05-antigravity-download.jpg`: the official download page.
- [x] `06-claude-desktop-code.jpg`: dropped (author, 2026-10-15). Computer-use cannot capture
  Claude Desktop, the app running the session; the slide is text only.
- [x] Alt text on each; at most 3 bullets beside a screenshot.

## Task 7: Verify

- [x] `Rscript scripts/check_slides.R` exits 0 (2 / 8 / 13 / 25 / 3 / 4, 5 of 6).
- [x] `quarto render statistical-computation.qmd` builds clean, no knitr engine.
- [x] Step through every slide in the browser pane: no overflow, 6 images,
  notes hidden, navigation reaches the end.
- [x] Consistency sweep: old file names, old part numbers, `REAAAPP`.
- [ ] Commit, then push, each only after the author says yes.

## Settled decisions

- Deck filename: `statistical-computation.qmd` → `statistical-computation.html`.
- Rendered HTML is not committed. Title slide keeps `date: today`.
- 2026-10-15: budget 2 / 8 / 13 / 25 / 3 / 4; one slide per RREAAAPP stage
  with notes; five screenshots (Claude Desktop text only); Part 0 objectives replace the old list;
  `About_This_Project.md` left as the author wrote it.
