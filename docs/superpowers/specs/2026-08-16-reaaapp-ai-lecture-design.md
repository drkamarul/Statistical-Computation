# Design: Statistical Computation Lecture Deck (REAAAPP + AI Assistants)

**Date:** 2026-08-16
**Author:** Kamarul Imran Musa (with Claude)
**Status:** Superseded by [2026-10-14-rreaaapp-revision-design.md](2026-10-14-rreaaapp-revision-design.md) (RREAAAPP, 8 stages)

## 1. Purpose

Build a Quarto revealjs slide deck for the lecture *Statistical Computation:
Integrating Data Analysis Workflow and AI Assistants*, delivered to postgraduate
medical and health researchers at Universiti Sains Malaysia.

By the end of the lecture students will be able to:

1. Analyse data using the REAAAPP workflow.
2. Integrate an AI assistant into the REAAAPP workflow.
3. Create an end-to-end data analysis plan, from reading data to publishing
   results and code on GitHub.

## 2. The REAAAPP workflow (authoritative definition)

Seven stages. This spelling and ordering is authoritative for the whole project.
It matches slide 7 of *Smart Data Analysis in Medical and Health Research* and
the seven-step figure in *Data Analysis Workflow*. `About_This_Project.md`
originally read "REAPPP"; this was confirmed as a typo and corrected at source
on 2026-08-16, so no variant spelling remains anywhere in the project.

| # | Letter | Stage | One-line goal |
|---|--------|-------|---------------|
| 1 | **R** | Read | Get data of known provenance into the analysis environment. |
| 2 | **E** | Explore | Understand distributions, missingness and structure before modelling. |
| 3 | **A** | Assume | State the assumptions the intended analysis depends on. |
| 4 | **A** | Apply | Fit the models and methods chosen. |
| 5 | **A** | Assess | Check assumptions, diagnostics, performance and validity. |
| 6 | **P** | Present | Report results and interpretations to the intended audience. |
| 7 | **P** | Publish | Release results, data and code so others can reuse and verify them. |

Every stage is presented with three named attributes, as required by the brief:
**goal**, **knowledge required**, **skill required**.

## 3. Deliverable structure

A single Quarto revealjs deck assembled from three part files plus an appendix.

```
Version_2026/
├─ _quarto.yml                  Project config, output to _site/
├─ index.qmd                    Master deck: YAML + title slide + includes
├─ _part1-workflow.qmd          Part 1, 25 slides
├─ _part2-ai-assistants.qmd     Part 2, 25 slides
├─ _part3-hands-on.qmd          Part 3, 3 slides
├─ _appendix.qmd                Takeaways, thank-you, references
├─ styles/academic.scss         Theme
├─ references.bib               Citations
├─ references/                  Source PDFs
├─ scripts/check_slides.R       Slide-budget and 5-point linter
├─ .github/workflows/publish.yml
├─ CLAUDE.md
├─ implementation_plan.md
├─ About_This_Project.md
└─ .gitignore
```

Part files are prefixed with `_` so Quarto never renders them as standalone
outputs. `index.qmd` pulls them in with the include shortcode:

```
{{< include _part1-workflow.qmd >}}
```

Naming the master deck `index.qmd` makes the rendered slides the root document
of the GitHub Pages site, so no separate landing page is needed.

### Why includes rather than one file or three decks

One file of ~56 slides is slow to render and awkward to edit. Three independent
decks would break the single-presentation flow the lecture needs. Includes give
independent editing with a single rendered artefact, and the part boundaries
double as the natural review checkpoints during the build.

## 4. Slide budget

Total: 56 presented slides plus 2 appendix reference slides.

### Part 1 — The REAAAPP workflow (25)

| Slide | Content |
|-------|---------|
| 1 | Part 1 divider |
| 2 | Why you need a workflow |
| 3 | REAAAPP at a glance (7 stages) |
| 4 | How each stage is presented: goal / knowledge / skill |
| 5–6 | **R — Read**: (a) goal and what happens, (b) knowledge, skill, tools |
| 7–8 | **E — Explore** |
| 9–10 | **A — Assume** |
| 11–12 | **A — Apply** |
| 13–14 | **A — Assess** |
| 15–16 | **P — Present** |
| 17–18 | **P — Publish** |
| 19 | Reproducibility runs through every stage |
| 20 | Working in a team: Git as the backbone |
| 21 | Reporting guidelines: SAMPL and the ASA statement on p-values |
| 22 | Publishing data: repositories, credit, reuse |
| 23 | Rate yourself: novice / intermediate / advanced |
| 24 | Where workflows break down |
| 25 | Part 1 recap |

Each stage gets a two-slide pair with an identical shape, so students learn the
template once and can then read any stage quickly.

### Part 2 — AI assistants (25)

| Slide | Content |
|-------|---------|
| 1 | Part 2 divider |
| 2 | Before AI assistants: the search-and-adapt loop |
| 3 | What an AI assistant actually is |
| 4 | The three major providers: Google, Anthropic, OpenAI |
| 5 | Google and the Gemini family |
| 6 | Anthropic and the Claude family |
| 7 | OpenAI and the GPT family |
| 8 | What "frontier model" means |
| 9 | Frontier models today |
| 10 | Open-weight models |
| 11 | Frontier vs open: cost, privacy, control |
| 12 | Health data: the confidentiality question |
| 13 | Three platforms: web, IDE, CLI |
| 14–15 | **Web**: how it works; pros and cons (Gemini app) |
| 16–17 | **IDE**: how it works; pros and cons (Google Antigravity IDE, Positron Assistant) |
| 18–19 | **CLI**: how it works; pros and cons (Antigravity CLI) |
| 20 | Google Antigravity 2.0 as an agent-first platform |
| 21 | Platform comparison table |
| 22 | Best practice: give context, plan before prompting |
| 23 | Best practice: verify every output |
| 24 | Best practice: protect the data, keep the code reproducible |
| 25 | Best practice: you remain the analyst — and Part 2 recap |

### Part 3 — Hands-on (3)

| Slide | Content |
|-------|---------|
| 1 | Your task: a data analysis plan integrating REAAAPP and your AI assistant |
| 2 | The project scaffold: folders and files your AI assistant reads from |
| 3 | The `implementation_plan.md` template, mapped to the seven stages |

### Appendix (+4, of which 2 are unpresented)

Five Key Takeaways · Thank you · References (2 slides, placed after the
thank-you slide so they are available but not presented).

## 5. Theme

Classic academic serif, defined in `styles/academic.scss` and applied via
`theme: [default, styles/academic.scss]`.

**Typography.** Serif headings and body: `Source Serif 4`, falling back through
Charter and Georgia to the generic serif. Monospace for code. The fallback chain
matters because lecture halls cannot be assumed to have internet, and a Google
Fonts fetch that fails must degrade to a serif already on the machine rather
than to a sans-serif default.

**Palette.**

| Token | Value | Use |
|-------|-------|-----|
| ink | `#1A1A1A` | Body text |
| paper | `#FDFDFB` | Slide background |
| accent | `#2C4A63` | Headings, rules, links |
| muted | `#6B7280` | Captions, slide numbers |
| divider background | `#1A1A1A` | Part dividers, reversed text |

**Structure.** The SCSS is split into `/*-- scss:defaults --*/` for Sass
variables Quarto consumes before compiling revealjs, and `/*-- scss:rules --*/`
for custom classes: `.stage`, `.ks-grid` (the knowledge/skill two-column
layout), `.divider`, `.takeaway`, `.compare`.

**revealjs options.** `slide-number: c/t`, `progress: true`, `smaller: true`,
`width: 1280`, `height: 720`, `link-external-newwindow: true`, `incremental:
false`.

## 6. Content integrity rules

These are constraints on what may appear on a slide, taken from the Evaluation
section of the brief and enforced by `scripts/check_slides.R` where mechanical.

1. **Maximum 5 bullet points per slide.** Enforced by the linter.
2. **No figures or plots of my own creation.** R code blocks are illustrative
   only, set `eval: false`, and produce no output. Visual structure comes from
   CSS layout classes, never from generated images.
3. **No screenshots.** Decided during brainstorming; the deck is text, tables
   and CSS layout throughout.
4. **Part 2 facts must be verified live.** Assistant knowledge ends May 2026 and
   the lecture is dated August 2026. Every factual claim in Part 2 about model
   lineups, product names, versions and capabilities is checked by web search
   before it is written, and cited in `references.bib`. Claims that cannot be
   verified are omitted rather than approximated.
5. **Slide counts are fixed**: 25 / 25 / 3. The linter fails the build if a part
   drifts.

## 7. Verification

`scripts/check_slides.R` reads the three part files and reports, per part:

- the number of `##`-level slides, compared against the budget of 25 / 25 / 3;
- any slide whose bullet count exceeds 5;
- any slide with no heading text.

It exits non-zero on violation, so it can gate a commit. `quarto render` must
also complete without error before any push.

## 8. Publishing

`git init` on `Version_2026` with `main` as the default branch, remote
`https://github.com/drkamarul/Smart_Data_Analysis.git`. The remote was confirmed
empty on 2026-08-16, so the first push is a clean import with no merge risk.

`.github/workflows/publish.yml` uses `quarto-dev/quarto-actions/setup` and
`render`, then `actions/deploy-pages`, triggered on push to `main`. The rendered
deck is served at `https://drkamarul.github.io/Smart_Data_Analysis/`.

`_site/` and `.quarto/` are gitignored; the workflow renders from source rather
than committing build output.

Publishing the deck through GitHub Actions is itself a demonstration of the
Publish stage of REAAAPP, and Part 1 slide 25 refers to it.

## 9. Source material

Both source PDFs move into `references/` and are committed:

- `Data Analysis Workflow .pdf` — the seven-stage workflow, tools and skills.
- `Smart Data Analysis in Medical And Health Research.pdf` — REAAAPP naming,
  the three integration approaches, the traps slide.

External references named in the brief, to be checked and cited: the Gemini
assistant page, the Claude product overview, the Claude data-analyst agent
cookbook, and the OpenAI page on AI for data science and analytics.

## 10. Out of scope

- Executed R analyses, real datasets, or any rendered plot.
- Speaker notes beyond brief presenter cues.
- PDF or PowerPoint export targets; revealjs HTML only.
- Translation into Malay.
