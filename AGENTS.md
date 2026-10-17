# AGENTS.md

Working rules for any AI agent (Codex, Gemini, Antigravity, Claude and others)
working in this repository. This file mirrors `CLAUDE.md`; keep the two in sync
whenever either changes. If they ever disagree, `CLAUDE.md` wins.

## What this is

Slide deck for the lecture *Statistical Computation: Integrating Data Analysis
Workflow and AI Assistants*, for postgraduate public health students at
Universiti Sains Malaysia. A normal Quarto revealjs slide deck,
`statistical-computation.qmd`, rendered locally to one self-contained
`statistical-computation.html`. It is not a website: no `index.html`, no
Quarto website or project output folder, no hosting.

**Audience:** minimal maths, no previous R experience, no previous GitHub
experience. Write for that reader: plain words, one idea per bullet, every
term explained the first time it appears.

**Author:** Kamarul Imran Musa, website https://myanalytics.com.my

## Learning objectives

At the end of the lecture, students will be able to:

1. Set up Positron IDE, Google Antigravity 2.0 and, optionally, Claude Desktop
   with Claude Code.
2. Understand Quarto documents and GitHub repositories.
3. Understand the RREAAAPP workflow.
4. Understand what AI assistants are and where they run.
5. Integrate an AI assistant into the RREAAAPP workflow.

## The workflow being taught

**RREAAAPP**: eight stages. Reason, Read, Explore, Assume, Apply, Assess,
Present, Publish.

- The first R, **Reason**, is new in the 2026 version. Reason means knowing
  exactly why you analyse before opening R: research question, study
  population, outcome, explanatory variables, and which data fit the question.
- Stage 5 is **Apply**, never "Analyse".
- Never write "REAAAPP", "REAPPP", or any seven or six stage version. Any
  leftover "REAAAPP" in the brief or old docs is a typo for RREAAAPP.
- Each stage is taught with its **goal**, **knowledge required** and **skill
  required**.

## Hard rules for slide content

1. Maximum **5 top-level bullets** per slide, TOTAL, including two-column
   layouts. A knowledge/skill or pros/cons slide splits 3 + 2, never 3 + 3.
   `scripts/check_slides.R` only counts flush-left `- ` bullets; it cannot see
   indented or nested ones. That is a limitation of its regex, not permission
   to hide a sixth point one level down. Do not build crowded slides around
   the linter's blind spot. Speaker notes (`::: {.notes}`) are written as
   prose, never as `- ` bullets, because the linter counts them too.
2. Slide budget is fixed: Part 0 = 2, Part 1 = 12, Part 2 = 13, Part 3 = 25,
   Part 4 = 3, appendix = 4 (59 slides plus the title slide).
3. **No figures or plots of our own making**, and no diagrams-as-images.
   Structure comes from CSS classes, Quarto columns and markdown tables.
4. **Screenshots of real software are allowed, maximum 6 in the whole deck.**
   Only of real products the lecture teaches (Google Antigravity 2.0, Claude
   Code and Claude Desktop, Positron, Quarto, GitHub). Capture them with a
   desktop screenshot tool (computer-use), save as PNG or JPEG under `images/screenshots/`, give each
   meaningful alt text, and never capture personal data, tokens, email
   addresses, private session titles or other people's information on screen.
   Part 3 must include a screenshot of Google Antigravity 2.0.
5. **Code fences must never be executable.** Write all R and shell code as
   plain ` ```r ` / ` ```bash ` fences, never ` ```{r} `. Nothing in the deck
   runs, so rendering needs only Quarto and never R. An executable chunk
   invokes the knitr engine, which needs R and the packages, and makes every
   render depend on them. To show a Quarto code cell on a slide, put it inside
   a ` ```markdown ` fence and write the cell header as ` ```{{r}} `.
6. **Do not cite sources from slides.** The deck YAML sets both
   `bibliography: references.bib` and `suppress-bibliography: true`, so an
   `[@key]` citation renders as a dead parenthetical. The two reference slides
   at the end of `_appendix.qmd` are hand-written lists ending in real URLs;
   edit those directly. `references.bib` stays as the machine-readable
   provenance record, not wired to any slide.
7. Facts about AI products (Part 3) and install steps (Part 1) go stale fast.
   Re-verify by web search before editing, and update the
   `note = {Accessed ...}` field in `references.bib`.
8. **No dataset is committed.** The Part 4 hands-on uses the MSSM fasting
   blood sugar workshop data (`datasets/mssm_fbs_workshop.xlsx`), distributed
   to students separately. `datasets/` is gitignored; the repo is public.

## Slide structure

- **Part 0, Learning Objectives (2):** the learning objectives, then today's
  plan as a table of the parts. No divider.
- **Part 1, Set Up Your Tools (12):** divider; install Positron; Quarto, what a
  `.qmd` file is; Quarto, the YAML header and document structure; install
  Google Antigravity 2.0; install Claude Desktop (optional, needs a paid
  plan); GitHub account and first repository; install and check Git; personal
  access token (classic) and when it helps; prompting an assistant to commit
  and push; an Antigravity and GitHub test push checklist; a ready to start
  checklist.
- **Part 2, The RREAAAPP Workflow (13):** divider; why a workflow; RREAAAPP at
  a glance; one slide per stage for all eight stages (goal line, knowledge 3
  and skill 2 columns, tools note, extra detail in speaker notes);
  reproducibility; recap.
- **Part 3, AI Assistants (25):** providers (Google, Anthropic, OpenAI),
  frontier and open models, the three platforms (web, IDE, CLI) with pros and
  cons, worked examples **Google Antigravity 2.0** and **Claude Code**, best
  practice for data analysis with an assistant.
- **Part 4, Hands-on (3):** a data analysis plan that integrates RREAAAPP and
  the student's own AI assistant, using the MSSM FBS data. Must be doable in
  **20 minutes**.
- **Appendix (4):** five key summaries, thank you, two reference slides.

`docs/superpowers/specs/2026-10-15-six-part-reorganisation-design.md` holds the
slide by slide layout.

## File map

- `statistical-computation.qmd`: the deck. YAML (title, author, all revealjs
  options, `embed-resources: true`) plus six includes. No slide content of its
  own. There is no `_quarto.yml` and no `index.qmd`.
- `_part0-objectives.qmd`, `_part1-setup.qmd`, `_part2-workflow.qmd`,
  `_part3-ai-assistants.qmd`, `_part4-hands-on.qmd`, `_appendix.qmd`: the
  content. The `_` prefix stops Quarto rendering them standalone.
- `styles/academic.scss`: all theme variables and classes. Keep it minimal.
- `images/screenshots/`: the only images allowed in the deck (max 6).
- `scripts/check_slides.R`: budget, five-point, screenshot and acronym linter.
- `references/`: source material (two PDFs and `02_rreaaapp_workflow.html`,
  the Topic B RREAAAPP deck that defines Reason).
- `references.bib`: provenance record only; not cited from slides.
- `implementation_plan.md`: the current plan. Plan first, then build.
- `About_This_Project.md`: the author's brief. Source of truth for intent.
- `docs/superpowers/specs/`: design specs.

## Theme classes

`.goal` lead statement · `.note` muted aside · `.ks` knowledge/skill block ·
`.takeaway` numbered emphasis · `.tight` reduced list spacing. Part dividers use
`{background-color="#1A1A1A"}`, not a class.

Palette: ink `#1A1A1A`, paper `#FDFDFB`, accent `#2C4A63`, muted `#6B7280`,
rule `#D8D4CC`.

## Working process

- Always plan first: update `implementation_plan.md` before changing slides,
  and ask the author questions until the intent is clear.
- Follow Quarto revealjs conventions (the author's `quarto-skill` where your
  tool supports skills) before creating, editing or rendering any `.qmd`.
- Update this file, `AGENTS.md` and `implementation_plan.md` whenever a rule
  or decision changes.

## Before every commit

```bash
Rscript scripts/check_slides.R   # must exit 0
quarto render statistical-computation.qmd   # must build clean
```

Never raise `MAX_BULLETS`, `MAX_SCREENSHOTS` or a budget number to make the
linter pass. Cut the content instead; the limits are the lecture's design, not
an obstacle. Only the author changes the budget.

## Publishing

Remote: https://github.com/drkamarul/Statistical-Computation.git, branch
`main`. There is no CI, no GitHub Pages and no web hosting. The author renders
locally and presents or shares `statistical-computation.html` as a file.

The older https://github.com/drkamarul/Smart_Data_Analysis repo is kept as an
archive and is never pushed to again. Do not commit the rendered `.html`, `*_files/` or `datasets/`.
