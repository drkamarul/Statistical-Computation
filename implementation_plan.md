# Implementation Plan: 2026 Revision (RREAAAPP)

> **For agentic workers:** Use superpowers:executing-plans (inline) or
> superpowers:subagent-driven-development. Invoke `quarto-skill` before touching
> any `.qmd`. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Revise the existing lecture deck to the 2026 brief: eight stage
RREAAAPP workflow with Reason first, Positron and GitHub setup, Antigravity 2.0
and Claude Code examples with real screenshots, a 20 minute hands-on on the
MSSM FBS data, and pushing source to the new Statistical-Computation
repository. Output is a normal standalone deck,
`statistical-computation.html`; not a website, no `index.html`, no hosting.

**Spec:** [docs/superpowers/specs/2026-10-14-rreaaapp-revision-design.md](docs/superpowers/specs/2026-10-14-rreaaapp-revision-design.md)
**Rules:** [CLAUDE.md](CLAUDE.md) (mirrored in [AGENTS.md](AGENTS.md))
**Brief:** [About_This_Project.md](About_This_Project.md)

The original August build plan (seven stage REAAAPP, 1,226 lines) is complete
and lives in git history at commit `25e7b74`.

## Global constraints

- **RREAAAPP**, eight stages: Reason, Read, Explore, Assume, Apply, Assess,
  Present, Publish. No "REAAAPP" anywhere in slides or docs.
- Max **5 top-level bullets** per slide; budget **25 / 25 / 3 / 4**.
- **Max 6 screenshots**, real products only, under `images/screenshots/`.
  No own figures or plots.
- Code fences are plain ` ```r `, never executable.
- No `[@key]` citations on slides; references are hand-written in the appendix.
- Audience: no R, no GitHub, minimal maths. Plain words.
- `embed-resources: true` in the deck YAML. Author: Kamarul Imran Musa, https://myanalytics.com.my.
- No dataset committed; `datasets/` gitignored.
- Remote: `https://github.com/drkamarul/Statistical-Computation.git` (empty as
  of 2026-10-14). Push only here; Smart_Data_Analysis stays untouched.
- **No CI, no GitHub Pages, no website.** One deck file,
  `statistical-computation.qmd`, rendered locally. No `_quarto.yml`, no `index.qmd`.

## Status

- [x] Task 0: Docs updated (CLAUDE.md, AGENTS.md, spec, this plan, brief
  acronym typos) on 2026-10-14
- [x] Tasks 1 to 5, 7 and 8 done on 2026-10-14 (linter, config, Part 1, Part 2
  facts and edits, Part 3, appendix). Lint passes; render clean; overflow checked
- [x] Task 6: 3 screenshots (Positron, GitHub, Antigravity); Claude Code text only
- [x] Task 9: committed 64c6610 and pushed to Statistical-Computation main on 2026-10-14

---

## Task 1: Linter first

**File:** `scripts/check_slides.R`

- [ ] Add `MAX_SCREENSHOTS <- 6L`; count `!\[` across all four files after
  `strip_code()`; fail if over.
- [ ] Add an acronym check: fail on `REAAAPP` not preceded by `R`
  (`(?<!R)REAAAPP`, `perl = TRUE`).
- [ ] Update the success message.
- [ ] Run `Rscript scripts/check_slides.R`. It **should fail** on the current
  deck (REAAAPP). That proves the new check works.

Do not touch `BUDGET` or `MAX_BULLETS`.

## Task 2: Configuration

- [ ] `git mv index.qmd statistical-computation.qmd`.
- [ ] Move all options from `_quarto.yml` into the deck YAML (revealjs format,
  theme, slide size, `bibliography`, `suppress-bibliography`), set
  `embed-resources: true`, then `git rm _quarto.yml`.
- [ ] Deck YAML: author block with name, `url: https://myanalytics.com.my`,
  USM affiliation. Keep `date: today`.
- [ ] `.gitignore`: add `datasets/`, `statistical-computation.html`; drop `_site/`.
- [ ] Delete `.github/workflows/publish.yml` (no CI, no Pages).
- [ ] `quarto render statistical-computation.qmd` and confirm the HTML is
  self-contained (no `statistical-computation_files/` folder) and no
  `index.html` or `_site/` appears. If the Google Fonts `@import` breaks embedding,
  keep the serif fallback chain and drop the import rather than fail the build.

## Task 3: Part 1 restructure (`_part1-workflow.qmd`)

Follow the slide table in spec section 4.

- [ ] Rename divider and headings to RREAAAPP, e.g.
  `## Part 1 — The RREAAAPP Workflow`, `## R — Reason: Know Why You Analyse`,
  `## R — Reason: Knowledge and Skill`. Dashes are fine.
- [ ] "RREAAAPP at a Glance": eight stages. Use a markdown table (letter,
  stage, one line) so it stays within five bullets.
- [ ] New slide 5 "Set Up: Install Positron" (download, install R first, Open
  Folder, Ctrl+Enter; Posit Cloud fallback) with screenshot 1.
- [ ] New slide 6 "Set Up: Your GitHub Account and First Repository" (sign up,
  verify email, New repository, README, public vs private) with screenshot 2.
- [ ] New Reason pair (slides 7 and 8) from `references/02_rreaaapp_workflow.html`:
  question, population, outcome, explanatory variables, data; the one sentence
  test; MSSM FBS example sentence.
- [ ] Renumber the seven existing stage pairs to slides 9 to 22. Fold SAMPL and
  the ASA statement into Present; fold Git and data sharing into Publish.
- [ ] Delete the four slides listed in spec section 4.
- [ ] Rewrite for the beginner audience.
- [ ] Linter: Part 1 shows 25 slides, no violations.

## Task 4: Re-verify Part 2 facts

- [ ] Web search (October 2026) for: current Gemini, Claude and GPT model
  families; frontier and open-weight model lineups; Google Antigravity 2.0
  surfaces, pricing and platforms; Claude Code surfaces (CLI, IDE extensions,
  desktop, web) and pricing.
- [ ] Also fetch the four brief URLs (Gemini assistant, Claude overview, Claude
  data-analyst agent cookbook, ChatGPT data science page).
- [ ] Update `references.bib` entries and `note = {Accessed 2026-10-..}`.
  Record failed fetches honestly in the notes.

## Task 5: Part 2 edits (`_part2-ai-assistants.qmd`)

- [ ] Delete "Before AI Assistants".
- [ ] Update provider and model slides from Task 4 findings.
- [ ] Pros and cons slides: name Antigravity 2.0 and Claude Code as the examples.
- [ ] "Google Antigravity 2.0" slide: verified facts plus screenshot 3.
- [ ] New "Claude Code" slide after it: what it is, where it runs, how it
  fits RREAAAPP. No screenshot (author's decision).
- [ ] "Plan Before You Prompt" code block: eight lines, Reason first.
- [ ] Linter: Part 2 shows 25 slides.

## Task 6: Screenshots (computer-use)

- [ ] Load computer-use tools; `request_access` for the needed apps only.
- [ ] Capture, in order: Positron, GitHub new repository page, Google
  Antigravity 2.0, Claude Code. Max 6 in total.
- [ ] Before each capture: close or hide anything personal (email, tokens,
  other repos, notifications). Ask the author to sign in where needed; never
  enter credentials.
- [x] Saved `images/screenshots/01-positron.jpg`, `02-github-new-repo.jpg`,
  `03-antigravity.jpg` (JPEG: no Pillow to convert). Claude Code skipped.
- [ ] Embed with alt text and a width that leaves room for at most 2 to 3 bullets.

## Task 7: Part 3 hands-on, 20 minutes (`_part3-hands-on.qmd`)

- [ ] Slide 1: divider and task, "Part 3: Your 20 Minute Plan". Timing: 2 min
  Reason, 8 min draft plan with your assistant, 7 min check and correct it,
  3 min push to GitHub.
- [ ] Slide 2: set up. Open the workshop folder in Positron; data at
  `datasets/mssm_fbs_workshop.xlsx` (given in class, never pushed); create a
  repo; keep `datasets/` in `.gitignore`.
- [ ] Slide 3: `implementation_plan.md` template with eight headings, Reason
  first, plus one starter prompt for the assistant.
- [ ] Dry run the timing: a beginner must finish in 20 minutes. Cut steps if not.

## Task 8: Appendix (`_appendix.qmd`)

- [ ] Five key summaries: eight stages, Reason first.
- [ ] Thank you slide: source repo URL (Statistical-Computation) and
  myanalytics.com.my. No Pages URL.
- [ ] References: add the Topic B RREAAAPP deck, Antigravity 2.0 and Claude
  Code sources.
- [ ] Add a `references.bib` entry for `references/02_rreaaapp_workflow.html`.

## Task 9: Verify, then publish

- [ ] `Rscript scripts/check_slides.R` exits 0.
- [ ] `quarto render statistical-computation.qmd` builds clean.
- [ ] Open `statistical-computation.html` in the browser pane; step through every slide;
  check that nothing overflows and all four screenshots show.
- [ ] `grep -rnP "(?<!R)REAAAPP" --include=*.qmd --include=*.md .` returns only
  historical notes. `Smart_Data_Analysis` may remain in historical notes.
- [ ] Commit (with `references/02_rreaaapp_workflow.html`, AGENTS.md, images).
- [ ] `git remote set-url origin https://github.com/drkamarul/Statistical-Computation.git`
  then `git push -u origin main`, **after confirming with the author**.
- [ ] Tell the author the deck is ready at `statistical-computation.html`.

## Settled decisions (2026-10-14)

- Deck filename: `statistical-computation.qmd` → `statistical-computation.html`.
- Rendered HTML is not committed.
- Title slide keeps `date: today`.
