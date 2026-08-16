# Statistical Computation Lecture Deck — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Quarto revealjs lecture deck teaching the REAAAPP data analysis
workflow and the integration of AI assistants into it, published to GitHub Pages.

**Architecture:** One master deck (`index.qmd`) assembles three part files and an
appendix through Quarto include shortcodes. Part files are `_`-prefixed so they
never render standalone. A base-R linter enforces the slide budget and the
five-point-per-slide rule before every commit. GitHub Actions renders and deploys
on push to `main`.

**Tech Stack:** Quarto 1.9.37 (installed), revealjs, Sass/SCSS, R 4.6.0 (linter,
base R only — no packages), GitHub Actions, GitHub Pages.

**Spec:** [docs/superpowers/specs/2026-08-16-reaaapp-ai-lecture-design.md](docs/superpowers/specs/2026-08-16-reaaapp-ai-lecture-design.md)

## Global Constraints

Every task's requirements implicitly include this section.

- **Workflow acronym is REAAAPP**, seven stages: Read, Explore, Assume, Apply,
  Assess, Present, Publish. Never "REAPPP", never six stages.
- **Maximum 5 top-level bullets per slide.** Enforced by `scripts/check_slides.R`.
- **Slide budget is fixed:** `_part1-workflow.qmd` = 25, `_part2-ai-assistants.qmd`
  = 25, `_part3-hands-on.qmd` = 3, `_appendix.qmd` = 4. Enforced by the linter.
- **No figures, plots, diagrams-as-images, or screenshots.** All visual structure
  comes from CSS classes, Quarto columns, and markdown tables.
- **All R code blocks are illustrative:** every chunk uses `#| eval: false`, so
  nothing executes and nothing is plotted.
- **Part 2 factual claims must be web-verified** before being written, and cited
  in `references.bib`. Assistant knowledge ends May 2026; the lecture is dated
  August 2026. Omit what cannot be verified.
- **Author block:** Kamarul Imran Musa, MD PhD — Professor of Medical
  Epidemiology and Statistics, School of Medical Sciences, Universiti Sains
  Malaysia. Title slide uses `date: today`.
- **Palette (exact hex):** ink `#1A1A1A`, paper `#FDFDFB`, accent `#2C4A63`,
  muted `#6B7280`, rule `#D8D4CC`.
- **Remote:** `https://github.com/drkamarul/Smart_Data_Analysis.git`, branch
  `main`. Confirmed empty on 2026-08-16.
- Run every command from the project root: `Version_2026/`.

---

## File Structure

| File | Responsibility |
|------|----------------|
| `_quarto.yml` | Project type, output dir, the single render target, shared revealjs format options |
| `index.qmd` | Title-slide YAML plus four include shortcodes. Holds no slide content of its own. |
| `_part1-workflow.qmd` | Part 1 content only, 25 slides |
| `_part2-ai-assistants.qmd` | Part 2 content only, 25 slides |
| `_part3-hands-on.qmd` | Part 3 content only, 3 slides |
| `_appendix.qmd` | Takeaways, thank-you, references — 4 slides |
| `styles/academic.scss` | All theme variables and custom classes. Single source of visual truth. |
| `references.bib` | Citations, chiefly the Part 2 verification sources |
| `scripts/check_slides.R` | Budget and five-point linter. Base R only, no dependencies. |
| `.github/workflows/publish.yml` | Render and deploy to Pages |
| `CLAUDE.md` | Working rules for future sessions in this repo |
| `references/` | The two source PDFs |

---

### Task 1: Quarto project skeleton that renders

**Files:**
- Create: `.gitignore`, `_quarto.yml`, `index.qmd`, `styles/academic.scss`
- Move: `Data Analysis Workflow .pdf`, `Smart Data Analysis in Medical And Health Research.pdf` → `references/`

**Interfaces:**
- Consumes: nothing (first task)
- Produces: a rendering Quarto project; `_quarto.yml` defines the format block
  every later task inherits; `styles/academic.scss` is the file Task 2 fills in.

- [ ] **Step 1: Create `.gitignore`**

```gitignore
_site/
.quarto/
*_files/
*_cache/
.Rproj.user/
.Rhistory
.RData
.Ruserdata
~$*
Thumbs.db
.DS_Store
```

- [ ] **Step 2: Move the source PDFs into `references/`**

```bash
mkdir -p references styles scripts
git mv "Data Analysis Workflow .pdf" "references/Data Analysis Workflow.pdf" 2>/dev/null \
  || mv "Data Analysis Workflow .pdf" "references/Data Analysis Workflow.pdf"
mv "Smart Data Analysis in Medical And Health Research.pdf" "references/"
ls references/
```

Expected: both PDFs listed, and the stray space before `.pdf` in the first
filename is gone.

- [ ] **Step 3: Create `_quarto.yml`**

```yaml
project:
  type: default
  output-dir: _site
  render:
    - index.qmd

bibliography: references.bib
csl: https://www.zotero.org/styles/vancouver

format:
  revealjs:
    theme: [default, styles/academic.scss]
    slide-number: c/t
    show-slide-number: all
    progress: true
    history: true
    width: 1280
    height: 720
    margin: 0.07
    center: false
    incremental: false
    link-external-newwindow: true
    code-line-numbers: false
    highlight-style: github
    embed-resources: false
```

- [ ] **Step 4: Create a minimal `index.qmd` (title slide only for now)**

```markdown
---
title: "Statistical Computation"
subtitle: "Integrating Data Analysis Workflow and AI Assistants"
author: "Kamarul Imran Musa, MD PhD"
institute: "Professor of Medical Epidemiology and Statistics<br>School of Medical Sciences, Universiti Sains Malaysia"
date: today
date-format: "D MMMM YYYY"
---
```

- [ ] **Step 5: Create a minimal `styles/academic.scss` so the theme resolves**

```scss
/*-- scss:defaults --*/
$body-bg:   #FDFDFB;
$body-color: #1A1A1A;
$link-color: #2C4A63;

/*-- scss:rules --*/
```

- [ ] **Step 6: Render and verify the skeleton builds**

Run: `quarto render`
Expected: completes without error, and `_site/index.html` exists.

```bash
test -f _site/index.html && echo "RENDER OK" || echo "RENDER FAILED"
grep -c "Integrating Data Analysis Workflow" _site/index.html
```

Expected: `RENDER OK`, and a count of at least 1.

- [ ] **Step 7: Commit**

```bash
git add .gitignore _quarto.yml index.qmd styles/academic.scss references/
git commit -m "Add Quarto project skeleton with title slide

Renders index.qmd to _site/ as revealjs. Source PDFs moved into references/."
```

---

### Task 2: The classic academic serif theme

**Files:**
- Modify: `styles/academic.scss` (replace the minimal version from Task 1)

**Interfaces:**
- Consumes: `_quarto.yml`'s `theme: [default, styles/academic.scss]` from Task 1.
- Produces: CSS classes that all content tasks use by name —
  `.goal` (lead statement under a stage heading), `.note` (muted aside),
  `.ks` (knowledge/skill block wrapper), `.takeaway` (numbered emphasis),
  `.tight` (reduced list spacing). Part dividers use the per-slide attribute
  `{background-color="#1A1A1A"}` rather than a class.

- [ ] **Step 1: Write the full theme**

Replace the entire contents of `styles/academic.scss`:

```scss
/*-- scss:defaults --*/

@import url('https://fonts.googleapis.com/css2?family=Source+Serif+4:opsz,wght@8..60,400;8..60,600;8..60,700&family=JetBrains+Mono:wght@400;500&display=swap');

// Palette
$ink:    #1A1A1A;
$paper:  #FDFDFB;
$accent: #2C4A63;
$muted:  #6B7280;
$rule:   #D8D4CC;

// Typography. The fallback chain matters: lecture halls may have no internet,
// so a failed webfont fetch must degrade to a serif already on the machine.
$font-family-sans-serif: "Source Serif 4", Charter, Georgia, "Times New Roman", serif !default;
$font-family-monospace:  "JetBrains Mono", "Source Code Pro", Consolas, monospace !default;

$body-bg:    $paper;
$body-color: $ink;
$link-color: $accent;
$link-color-hover: lighten($accent, 12%);
$selection-bg: rgba($accent, .22);

$presentation-font-size-root: 30px;
$presentation-heading-font:   $font-family-sans-serif;
$presentation-heading-color:  $accent;
$presentation-heading-font-weight: 600;
$presentation-h1-font-size: 1.90em;
$presentation-h2-font-size: 1.32em;
$presentation-h3-font-size: 1.05em;
$presentation-line-height: 1.35;

$code-block-font-size: 0.60em;
$code-block-bg: #F5F3EE;
$code-block-border-color: $rule;

/*-- scss:rules --*/

.reveal h2 {
  border-bottom: 1px solid $rule;
  padding-bottom: .22em;
  margin-bottom: .55em;
  text-align: left;
}

.reveal h1 { letter-spacing: -0.01em; }

.reveal .slide-number {
  font-family: $font-family-sans-serif;
  background: transparent;
  color: $muted;
  font-size: .5em;
}

// Dark part-divider slides use {background-color="#1A1A1A"}; these rules make
// the type on them readable without a second theme.
.reveal section[data-background-color="#1A1A1A"] {
  h1, h2, h3, p, li, strong { color: $paper; }
  h2 { border-bottom-color: rgba($paper, .28); }
}

// Lead statement: the goal of a workflow stage.
.reveal .goal {
  border-left: 4px solid $accent;
  background: rgba($accent, .06);
  padding: .40em .85em;
  margin: 0 0 .70em 0;
}

.reveal .note {
  color: $muted;
  font-style: italic;
  font-size: .82em;
}

// Knowledge / skill block, used inside Quarto .columns layouts.
.reveal .ks {
  border-top: 2px solid $accent;
  padding-top: .35em;
  h3 {
    font-size: .78em;
    text-transform: uppercase;
    letter-spacing: .07em;
    color: $muted;
    margin-bottom: .30em;
  }
}

.reveal .takeaway {
  border-left: 4px solid $accent;
  padding: .30em 0 .30em .85em;
  margin-bottom: .55em;
}

.reveal .tight ul,
.reveal ul.tight { line-height: 1.22; }

.reveal table {
  font-size: .74em;
  border-collapse: collapse;
}
.reveal table th {
  background: rgba($accent, .09);
  border-bottom: 2px solid $accent;
  text-align: left;
}
.reveal table td { border-bottom: 1px solid $rule; }

.reveal pre code { border-left: 3px solid $accent; }

.reveal blockquote {
  border-left: 3px solid $rule;
  background: transparent;
  font-style: normal;
  color: $muted;
}
```

- [ ] **Step 2: Render and verify the SCSS compiled into the output**

Run: `quarto render`
Expected: no Sass errors.

```bash
grep -rl "2C4A63\|2c4a63" _site/ | head -3
```

Expected: at least one CSS file under `_site/` contains the accent colour,
proving the custom SCSS was compiled rather than silently skipped.

- [ ] **Step 3: Commit**

```bash
git add styles/academic.scss
git commit -m "Add classic academic serif theme

Source Serif 4 with Charter/Georgia offline fallback, ink-on-paper palette,
and the .goal/.note/.ks/.takeaway classes the slide content depends on."
```

---

### Task 3: Slide linter and part-file wiring

This task deliberately ends in a failing state: the linter exists and reports
every part as under budget. Tasks 4–7 turn it green one part at a time.

**Files:**
- Create: `scripts/check_slides.R`, `_part1-workflow.qmd`, `_part2-ai-assistants.qmd`, `_part3-hands-on.qmd`, `_appendix.qmd`, `references.bib`
- Modify: `index.qmd` (add the four include shortcodes)

**Interfaces:**
- Consumes: the project layout from Task 1.
- Produces: `Rscript scripts/check_slides.R`, exit 0 when all four part files
  meet budget and no slide exceeds 5 bullets, exit 1 otherwise. Tasks 4–7 each
  use it as their acceptance test.

- [ ] **Step 1: Write the linter — this is the test that gates all content tasks**

Create `scripts/check_slides.R`:

```r
#!/usr/bin/env Rscript
# check_slides.R — enforce the slide budget and the five-point rule.
# Base R only, no package dependencies. Run from the project root.

BUDGET <- c(
  "_part1-workflow.qmd"      = 25L,
  "_part2-ai-assistants.qmd" = 25L,
  "_part3-hands-on.qmd"      =  3L,
  "_appendix.qmd"            =  4L
)
MAX_BULLETS <- 5L

# Drop fenced code blocks so that R comments (`# ...`) are never mistaken for
# slide headings and commented list items are never counted as bullets.
strip_code <- function(lines) {
  is_fence <- grepl("^\\s*```", lines)
  depth <- cumsum(is_fence)
  lines[!(depth %% 2L == 1L | is_fence)]
}

check_file <- function(path, budget) {
  if (!file.exists(path)) return(sprintf("%s: file is missing", path))
  problems <- character(0)
  lines  <- strip_code(readLines(path, warn = FALSE))
  starts <- grep("^#{1,2} ", lines)
  n <- length(starts)

  if (n != budget) {
    problems <- c(problems,
      sprintf("%s: has %d slides, budget is %d", path, n, budget))
  }
  if (n == 0L) return(problems)

  ends <- c(starts[-1] - 1L, length(lines))
  for (i in seq_along(starts)) {
    title <- trimws(sub("^#{1,2} ", "", lines[starts[i]]))
    title <- trimws(sub("\\{.*\\}$", "", title))   # drop attribute braces
    body  <- lines[starts[i]:ends[i]]

    if (!nzchar(title)) {
      problems <- c(problems, sprintf("%s: slide %d has an empty heading", path, i))
    }
    nb <- sum(grepl("^[-*] ", body))
    if (nb > MAX_BULLETS) {
      problems <- c(problems,
        sprintf("%s: slide %d (%s) has %d bullets, max is %d",
                path, i, title, nb, MAX_BULLETS))
    }
  }
  problems
}

problems <- unlist(lapply(names(BUDGET), function(f) check_file(f, BUDGET[[f]])))

if (length(problems)) {
  cat("Slide check FAILED\n")
  cat(paste0("  - ", problems, collapse = "\n"), "\n", sep = "")
  quit(status = 1L)
}

cat("Slide check passed: 25 / 25 / 3 / 4 slides, no slide over 5 bullets.\n")
quit(status = 0L)
```

- [ ] **Step 2: Create the four empty part files**

```bash
printf '%s\n' "<!-- Part 1: The REAAAPP Workflow (25 slides) -->" > _part1-workflow.qmd
printf '%s\n' "<!-- Part 2: AI Assistants (25 slides) -->"        > _part2-ai-assistants.qmd
printf '%s\n' "<!-- Part 3: Hands-On (3 slides) -->"              > _part3-hands-on.qmd
printf '%s\n' "<!-- Appendix (4 slides) -->"                      > _appendix.qmd
: > references.bib
```

- [ ] **Step 3: Run the linter to verify it fails**

Run: `Rscript scripts/check_slides.R`
Expected: exit status 1, and output naming all four files as under budget:

```
Slide check FAILED
  - _part1-workflow.qmd: has 0 slides, budget is 25
  - _part2-ai-assistants.qmd: has 0 slides, budget is 25
  - _part3-hands-on.qmd: has 0 slides, budget is 3
  - _appendix.qmd: has 0 slides, budget is 4
```

Confirm the exit code: `Rscript scripts/check_slides.R; echo "exit=$?"` → `exit=1`.

- [ ] **Step 4: Wire the includes into `index.qmd`**

Append to `index.qmd`, below the closing `---` of the YAML header:

```markdown
{{< include _part1-workflow.qmd >}}

{{< include _part2-ai-assistants.qmd >}}

{{< include _part3-hands-on.qmd >}}

{{< include _appendix.qmd >}}
```

- [ ] **Step 5: Verify the includes resolve and the deck still renders**

Run: `quarto render`
Expected: no "include file not found" error; `_site/index.html` still builds.

- [ ] **Step 6: Commit**

```bash
git add scripts/check_slides.R _part1-workflow.qmd _part2-ai-assistants.qmd \
        _part3-hands-on.qmd _appendix.qmd references.bib index.qmd
git commit -m "Add slide linter and wire part-file includes

check_slides.R enforces the 25/25/3/4 budget and the five-bullet rule.
It currently fails by design; content tasks turn it green part by part."
```

---

### Task 4: Part 1 — the REAAAPP workflow (25 slides)

**Files:**
- Modify: `_part1-workflow.qmd`

**Interfaces:**
- Consumes: `.goal`, `.note`, `.ks`, `.tight` from Task 2; the linter from Task 3.
- Produces: 25 slides. Later tasks do not depend on its content, but Part 2
  slide 1 refers back to the seven stage names exactly as spelled here.

**Source material:** `references/Data Analysis Workflow.pdf` (stage definitions
on pages 3, 8–12, 13–19, 20–22, 23–25; SAMPL and ASA references on pages 20–21;
GitHub and repositories on pages 23–24) and
`references/Smart Data Analysis in Medical And Health Research.pdf` page 7
(the authoritative REAAAPP naming) and page 8 (AI per stage).

- [ ] **Step 1: Write the four framing slides**

Replace the contents of `_part1-workflow.qmd`, starting with:

````markdown
# Part 1 — The REAAAPP Workflow {background-color="#1A1A1A"}

Read · Explore · Assume · Apply · Assess · Present · Publish

## Why You Need a Workflow

::: {.goal}
Analysis fails more often from missing process than from missing statistics.
:::

- Data arrive bigger, in more formats, and from more centres than before
- Analyses are more complex, so more places to go quietly wrong
- Without a named sequence, steps get skipped under time pressure
- A shared workflow lets a team divide work without losing the thread
- Reviewers and journals increasingly ask how, not just what

## REAAAPP at a Glance

| | Stage | What it delivers |
|---|---|---|
| **R** | Read | Data of known provenance, in your environment |
| **E** | Explore | Understanding of distribution, missingness, structure |
| **A** | Assume | An explicit list of what the analysis depends on |
| **A** | Apply | Fitted models and methods |
| **A** | Assess | Evidence the model is adequate and valid |
| **P** | Present | Results an audience can act on |
| **P** | Publish | Results, data and code others can verify |

## How Each Stage Is Presented

Every stage in this part gets the same two slides.

- **Goal** — what the stage must achieve before you move on
- **Knowledge required** — what you need to understand
- **Skill required** — what you need to be able to do
- **Tools** — what you do it with
- Learn the shape once, then read any stage quickly
````

- [ ] **Step 2: Write the seven stage pairs (slides 5–18)**

Each stage follows this exact template. The worked example below is the Read
pair; reproduce its structure for Explore, Assume, Apply, Assess, Present and
Publish, drawing substance from the PDF pages named above.

````markdown
## R — Read Data

::: {.goal}
**Goal:** get the data into R with its provenance, types and missing-value
conventions intact.
:::

- Sources are offline, cloud, or hybrid — record which
- Structured formats: CSV, Excel, SPSS, SAS, Stata
- Unstructured sources need a conversion step you must document
- Reading is where silent type coercion does its damage
- Nothing downstream is trustworthy if this step is careless

## R — Read: Knowledge and Skill

:::: {.columns}
::: {.column width="50%"}
::: {.ks}
### Knowledge required
- How your source format encodes missing values
- Variable types and what coercion costs you
- Where the data came from and who owns it
:::
:::
::: {.column width="50%"}
::: {.ks}
### Skill required
- Import with `readr`, `haven`, `readxl`
- Inspect types immediately after import
- Script the import — never edit the raw file
:::
:::
::::

::: {.note}
Tools: readr · haven · readxl · here
:::
````

Stage-specific substance to use:

| Stage | Goal line | Knowledge | Skill |
|---|---|---|---|
| **E — Explore** | Understand distributions, missingness and structure before any model | EDA purpose; graphical vs tabular summaries; what missingness patterns mean | `ggplot2`, `gtsummary`, `skimr`; reading a distribution; spotting impossible values |
| **A — Assume** | State what the intended analysis depends on, before fitting it | Population vs sample; exposure, confounder, mediator, moderator; outcome types | Draw the assumed relationship; name the outcome and its distribution; write assumptions down |
| **A — Apply** | Fit the models and methods the question actually needs | Estimation, hypothesis testing, inference, prediction; univariable vs multivariable; supervised vs unsupervised | Fit with `lm`, `glm`, `lme4`; choose between inference and prediction; keep the code reproducible |
| **A — Assess** | Show the model is adequate, and say where it applies | Residual and diagnostic logic; outliers and influential points; internal vs external validity | Read diagnostic output; compute R², accuracy, sensitivity, specificity; decide when to revise |
| **P — Present** | Report results so the audience can act on them | SAMPL guidelines; the ASA statement on p-values; what your audience already knows | Build tables with `gtsummary`/`gt`; write an interpretation, not just an estimate; simplify without distorting |
| **P — Publish** | Release results, data and code so others can verify them | Version control concepts; repository and licence choices; what makes data reusable | Use Git and GitHub; deposit data in Zenodo/OSF/Dryad; publish a Quarto site |

- [ ] **Step 3: Write the seven closing slides (19–25)**

Titles, in order, each with at most 5 bullets:

19. `## Reproducibility Runs Through Every Stage`
20. `## Working in a Team: Git as the Backbone`
21. `## Reporting Guidelines You Should Know` — SAMPL, ASA statement on p-values,
    AHA statistical recommendations
22. `## Publishing Data: Credit and Reuse` — Zenodo, OSF, Dryad, figshare;
    credit, discoverability, reusability
23. `## Rate Yourself at Each Stage` — novice / intermediate / advanced, and
    what to do about the gap
24. `## Where Workflows Break Down` — skipping Explore, unstated assumptions,
    no diagnostics, results that never get published, no version control
25. `## Part 1 — Recap`

- [ ] **Step 4: Run the linter and verify Part 1 is green**

Run: `Rscript scripts/check_slides.R`
Expected: `_part1-workflow.qmd` no longer appears in the failure list. Parts 2,
3 and the appendix still fail on count. If Part 1 reports a bullet violation,
cut bullets until it passes — do not raise the cap.

- [ ] **Step 5: Render and eyeball**

Run: `quarto render`
Expected: builds clean. Open `_site/index.html` and confirm the divider slide is
dark, the `.goal` blocks show the accent left border, and the two-column
knowledge/skill slides sit side by side rather than stacking.

- [ ] **Step 6: Commit**

```bash
git add _part1-workflow.qmd
git commit -m "Add Part 1: the REAAAPP workflow (25 slides)

Two slides per stage covering goal, knowledge required and skill required,
framed by four intro slides and seven closing slides on reproducibility,
teamwork, reporting guidelines and common failures."
```

---

### Task 5: Part 2 — AI assistants (25 slides)

**Files:**
- Modify: `_part2-ai-assistants.qmd`, `references.bib`

**Interfaces:**
- Consumes: theme classes from Task 2; the linter from Task 3.
- Produces: 25 slides plus bib entries keyed `gemini-assistant`,
  `claude-overview`, `claude-data-analyst`, `openai-data-science`,
  `antigravity`. Task 7's reference slides cite these keys.

**This task carries the project's only live-accuracy risk.** Do the research
steps before writing any slide.

- [ ] **Step 1: Load the Claude API reference skill**

The deck makes factual claims about Claude models, so the `claude-api` skill's
trigger applies. Invoke it before writing slides 6 or 9, and use it rather than
memory for any Anthropic model name, capability or pricing claim.

- [ ] **Step 2: Verify every Part 2 product claim by web search**

Fetch and read each of these, recording what you find:

| Source | What to confirm |
|---|---|
| `https://gemini.google/assistant/` | Current Gemini app naming and capabilities |
| `https://claude.com/product/overview` | Current Claude product surfaces |
| `https://platform.claude.com/cookbook/managed-agents-data-analyst-agent` | The data-analyst agent pattern |
| `https://chatgpt.com/business/ai-for-data-science-analytics/` | OpenAI's data-science positioning |
| `antigravity.google` (search for it) | Whether "Antigravity 2.0" is the current version, and whether a separate IDE and CLI exist as the brief assumes |

Also search for the current state of open-weight models (Llama, Qwen, Gemma,
Mistral, DeepSeek families) as of August 2026.

**If the brief's assumption about Antigravity's IDE/CLI split turns out to be
wrong, write what is actually true and flag the divergence in your task report
rather than reproducing the brief.** Omit anything you cannot verify.

- [ ] **Step 3: Record the sources in `references.bib`**

```bibtex
@misc{gemini-assistant,
  title        = {Gemini Assistant},
  author       = {{Google}},
  howpublished = {\url{https://gemini.google/assistant/}},
  note         = {Accessed 2026-08-16}
}

@misc{claude-overview,
  title        = {Claude: Product Overview},
  author       = {{Anthropic}},
  howpublished = {\url{https://claude.com/product/overview}},
  note         = {Accessed 2026-08-16}
}

@misc{claude-data-analyst,
  title        = {Managed Agents: Data Analyst Agent},
  author       = {{Anthropic}},
  howpublished = {\url{https://platform.claude.com/cookbook/managed-agents-data-analyst-agent}},
  note         = {Accessed 2026-08-16}
}

@misc{openai-data-science,
  title        = {AI for Data Science and Analytics},
  author       = {{OpenAI}},
  howpublished = {\url{https://chatgpt.com/business/ai-for-data-science-analytics/}},
  note         = {Accessed 2026-08-16}
}
```

Add an `@misc{antigravity, ...}` entry using whatever official URL Step 2 found.

- [ ] **Step 4: Write slides 1–13 (providers, models, platforms intro)**

Titles in order:

1. `# Part 2 — AI Assistants {background-color="#1A1A1A"}`
2. `## Before AI Assistants` — the search-and-adapt loop: Google, books,
   Stack Overflow, wait hours
3. `## What an AI Assistant Actually Is`
4. `## Three Providers That Matter` — Google, Anthropic, OpenAI
5. `## Google: the Gemini Family`
6. `## Anthropic: the Claude Family`
7. `## OpenAI: the GPT Family`
8. `## What "Frontier Model" Means`
9. `## Frontier Models Today` — a table, contents from Step 2's research
10. `## Open-Weight Models`
11. `## Frontier vs Open: the Trade-Off` — cost, privacy, control, capability
12. `## Health Data: the Confidentiality Question` — the one slide that most
    affects their practice; patient data and third-party APIs
13. `## Three Places to Use an Assistant` — web, IDE, CLI

- [ ] **Step 5: Write slides 14–21 (the three platforms)**

Use a consistent two-slide shape per platform, mirroring Part 1's stage pairs:

````markdown
## Web: How It Works

::: {.goal}
You bring the problem to a browser tab; the assistant never sees your project.
:::

- Describe the problem, paste a data sample, read the answer back
- Copy the generated code into your IDE and run it there
- Refine by conversation rather than by re-prompting from scratch
- Example: the Gemini app
- Nothing is installed, so this is where everyone should start

## Web: Pros and Cons

:::: {.columns}
::: {.column width="50%"}
::: {.ks}
### Strengths
- No setup at all
- Easy to compare assistants
- Good for learning and one-off questions
:::
:::
::: {.column width="50%"}
::: {.ks}
### Limits
- Manual copy-paste in both directions
- The assistant cannot see your files
- You manage context by hand
:::
:::
::::
````

Then: `## IDE: How It Works` / `## IDE: Pros and Cons` (Google Antigravity IDE,
Positron Assistant), `## CLI: How It Works` / `## CLI: Pros and Cons`,
`## Google Antigravity 2.0` (slide 20, contents from Step 2's research), and
`## Web, IDE, CLI Compared` (slide 21, a table with rows: setup cost, sees your
files, runs your code, best for).

- [ ] **Step 6: Write slides 22–25 (best practice)**

22. `## Best Practice: Plan Before You Prompt` — write the implementation plan
    first; give the assistant your data dictionary and reference code
23. `## Best Practice: Verify Everything` — run it, check the numbers against a
    known result, read the code you are about to publish
24. `## Best Practice: Protect the Data` — de-identify before sharing; know
    where the API sends data; check your institution's policy
25. `## Best Practice: You Remain the Analyst` — and Part 2 recap; the traps
    from `references/Smart Data Analysis in Medical And Health Research.pdf`
    page 25 (vague prompts, no resources, planning too little, not verifying,
    letting AI be your master)

- [ ] **Step 7: Run the linter and verify Part 2 is green**

Run: `Rscript scripts/check_slides.R`
Expected: only `_part3-hands-on.qmd` and `_appendix.qmd` still fail on count.

- [ ] **Step 8: Render**

Run: `quarto render`
Expected: builds clean, no broken citation warnings for the five bib keys.

- [ ] **Step 9: Commit**

```bash
git add _part2-ai-assistants.qmd references.bib
git commit -m "Add Part 2: AI assistants (25 slides)

Providers, frontier vs open-weight models, and the web/IDE/CLI platform
split with pros and cons, closing on four best-practice slides. All product
claims verified against official sources on 2026-08-16 and cited."
```

---

### Task 6: Part 3 — hands-on (3 slides)

**Files:**
- Modify: `_part3-hands-on.qmd`

**Interfaces:**
- Consumes: theme classes from Task 2; the linter from Task 3.
- Produces: 3 slides. Note there is **no separate divider slide** — slide 1
  carries the dark background and doubles as the transition, which is how the
  budget stays at exactly 3.

- [ ] **Step 1: Write all three slides**

````markdown
## Part 3 — Your Task {background-color="#1A1A1A"}

Build a data analysis plan that integrates REAAAPP with your own AI assistant.

- Pick a dataset you are actually working on
- Write the plan before you write any analysis code
- Name which assistant you will use at each stage
- The plan is the deliverable, not the results
- You will run it after this session

## The Project Scaffold

::: {.goal}
Your assistant can only help with what it can see. Structure the folder first.
:::

```
project/
├── data/raw/          untouched source data
├── data/processed/    what your script produces
├── resources/         data dictionary, reference papers, example code
├── R/                 your scripts
└── implementation_plan.md
```

- Keep raw data read-only and never edit it by hand
- `resources/` is what you point the assistant at
- The plan file is the assistant's brief

## Your `implementation_plan.md`

Seven headings, one per stage — fill each with what you will actually do.

```markdown
# Analysis Plan: <your study>
## 1. Read      — sources, formats, provenance
## 2. Explore   — summaries and checks before modelling
## 3. Assume    — outcome, exposures, confounders, assumed relationships
## 4. Apply     — models, and why those models
## 5. Assess    — diagnostics, performance, validity
## 6. Present   — tables, interpretation, target audience
## 7. Publish   — repository, licence, where the code goes
```

::: {.note}
Write it in markdown so your assistant can read it as easily as you can.
:::
````

- [ ] **Step 2: Run the linter and verify Part 3 is green**

Run: `Rscript scripts/check_slides.R`
Expected: only `_appendix.qmd` still fails.

Note the fenced code blocks on slides 2 and 3: the linter strips them, so the
`#` characters in the markdown template on slide 3 must not inflate the slide
count. If Part 3 reports more than 3 slides, `strip_code` is not working and the
linter, not the content, needs fixing.

- [ ] **Step 3: Commit**

```bash
git add _part3-hands-on.qmd
git commit -m "Add Part 3: hands-on task (3 slides)

The task brief, the project scaffold an AI assistant can read, and the
REAAAPP-mapped implementation plan template students fill in."
```

---

### Task 7: Appendix — takeaways, thank-you, references

**Files:**
- Modify: `_appendix.qmd`

**Interfaces:**
- Consumes: the `.takeaway` class from Task 2; the five bib keys from Task 5.
- Produces: the final 4 slides, taking the linter fully green.

- [ ] **Step 1: Write the four slides**

````markdown
## Five Key Takeaways

::: {.takeaway}
**1. The workflow comes first.** REAAAPP gives every analysis the same seven
named stages, so nothing gets skipped under pressure.
:::

::: {.takeaway}
**2. Explore is not optional.** Most analysis failures are visible in the data
before any model is fitted.
:::

::: {.takeaway}
**3. AI accelerates each stage; it does not replace your judgement.** You stay
accountable for every number you publish.
:::

::: {.takeaway}
**4. Verify everything the assistant gives you.** Unverified code costs more
time than it saves.
:::

::: {.takeaway}
**5. Publishing is part of the analysis.** Code and data in a repository is
what makes the work checkable.
:::

## Thank You

- **Email:** drki.musa@gmail.com
- **Web:** myanalytics.com.my
- **Slides:** https://drkamarul.github.io/Smart_Data_Analysis/
- **Source:** https://github.com/drkamarul/Smart_Data_Analysis

::: {.note}
Questions?
:::

## References — Workflow

- Musa KI. *Data Analysis Workflow.* Universiti Sains Malaysia.
- Musa KI. *Smart Data Analysis in Medical and Health Research.*
- Lang TA, Altman DG. *SAMPL Guidelines for Statistical Reporting.* EQUATOR Network.
- Wasserstein RL, Lazar NA. The ASA's statement on p-values. *Am Stat.* 2016;70(2):129–33.
- Musa KI, Wan Mansor WN, Tengku Hanis TM. *Data Analysis in Medicine and Health Using R.* CRC Press.

## References — AI Assistants

- Google. *Gemini Assistant.* [@gemini-assistant]
- Anthropic. *Claude: Product Overview.* [@claude-overview]
- Anthropic. *Managed Agents: Data Analyst Agent.* [@claude-data-analyst]
- OpenAI. *AI for Data Science and Analytics.* [@openai-data-science]
- Google. *Antigravity.* [@antigravity]
````

- [ ] **Step 2: Run the linter and verify everything is green**

Run: `Rscript scripts/check_slides.R; echo "exit=$?"`
Expected:

```
Slide check passed: 25 / 25 / 3 / 4 slides, no slide over 5 bullets.
exit=0
```

This is the first time the linter passes. Do not proceed until it does.

- [ ] **Step 3: Render and count the slides in the output**

Run: `quarto render`

```bash
grep -o '<section' _site/index.html | wc -l
```

Expected: 58 or more (57 content sections plus the title slide; revealjs may
add wrapper sections, so treat a higher count as acceptable and a lower count
as a problem).

- [ ] **Step 4: Commit**

```bash
git add _appendix.qmd
git commit -m "Add appendix: takeaways, thank-you and references

Slide linter now passes at 25/25/3/4 with no slide over five bullets."
```

---

### Task 8: CLAUDE.md

**Files:**
- Create: `CLAUDE.md`

**Interfaces:**
- Consumes: the finished project layout.
- Produces: the rules file every future session in this repo reads.

- [ ] **Step 1: Write `CLAUDE.md`**

```markdown
# CLAUDE.md

Working rules for this repository.

## What this is

Slide deck for the lecture *Statistical Computation: Integrating Data Analysis
Workflow and AI Assistants*, for postgraduate medical and health researchers at
Universiti Sains Malaysia. Quarto revealjs, published to GitHub Pages.

## The workflow being taught

**REAAAPP** — seven stages: Read, Explore, Assume, Apply, Assess, Present,
Publish. Never write "REAPPP" and never reduce it to six stages.

## Hard rules for slide content

1. Maximum **5 top-level bullets** per slide.
2. Slide budget is fixed: Part 1 = 25, Part 2 = 25, Part 3 = 3, appendix = 4.
3. **No figures, plots, diagrams-as-images, or screenshots.** Structure comes
   from CSS classes, Quarto columns and markdown tables.
4. All R chunks are illustrative: `#| eval: false`. Nothing executes.
5. Part 2 facts about AI products go stale fast. Re-verify by web search before
   editing, and update the `note = {Accessed ...}` field in `references.bib`.

## File map

- `index.qmd` — title slide plus four includes. No slide content of its own.
- `_part1-workflow.qmd`, `_part2-ai-assistants.qmd`, `_part3-hands-on.qmd`,
  `_appendix.qmd` — the content. The `_` prefix stops Quarto rendering them
  standalone.
- `styles/academic.scss` — all theme variables and classes.
- `scripts/check_slides.R` — the budget and five-point linter.
- `references/` — source PDFs.
- `docs/superpowers/specs/` — the design spec.

## Theme classes

`.goal` lead statement · `.note` muted aside · `.ks` knowledge/skill block ·
`.takeaway` numbered emphasis · `.tight` reduced list spacing. Part dividers use
`{background-color="#1A1A1A"}`, not a class.

Palette: ink `#1A1A1A`, paper `#FDFDFB`, accent `#2C4A63`, muted `#6B7280`,
rule `#D8D4CC`.

## Before every commit

```bash
Rscript scripts/check_slides.R   # must exit 0
quarto render                    # must build clean
```

Never raise `MAX_BULLETS` or a budget number to make the linter pass. Cut the
content instead — the limits are the lecture's design, not an obstacle.

## Publishing

Push to `main`; `.github/workflows/publish.yml` renders and deploys to
https://drkamarul.github.io/Smart_Data_Analysis/. Do not commit `_site/`.
```

- [ ] **Step 2: Commit**

```bash
git add CLAUDE.md
git commit -m "Add CLAUDE.md with project rules

Records the REAAAPP spelling, the slide budget, the five-point rule, the
no-figures constraint and the pre-commit checks."
```

---

### Task 9: Publish to GitHub Pages

**Files:**
- Create: `.github/workflows/publish.yml`

**Interfaces:**
- Consumes: the rendering project from Tasks 1–7.
- Produces: a live deck at `https://drkamarul.github.io/Smart_Data_Analysis/`.

- [ ] **Step 1: Write the workflow**

Create `.github/workflows/publish.yml`:

```yaml
name: Render and publish slides

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Quarto
        uses: quarto-dev/quarto-actions/setup@v2
        with:
          version: 1.9.37

      - name: Render
        run: quarto render

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: _site

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

No R is installed in CI: nothing in the deck executes, so `quarto render` needs
only Quarto itself. The linter runs locally, not in CI.

- [ ] **Step 2: Run the full local check one more time**

```bash
Rscript scripts/check_slides.R; echo "linter exit=$?"
quarto render && echo "RENDER OK"
```

Expected: `linter exit=0` and `RENDER OK`. Do not push otherwise.

- [ ] **Step 3: Commit the workflow**

```bash
git add .github/workflows/publish.yml
git commit -m "Add GitHub Actions workflow to render and publish slides

Renders with Quarto 1.9.37 and deploys _site to GitHub Pages on push to main."
```

- [ ] **Step 4: Add the remote and push**

**Confirm with the author before running this step** — it is the first outward-
facing action in the plan.

```bash
git remote add origin https://github.com/drkamarul/Smart_Data_Analysis.git
git push -u origin main
```

- [ ] **Step 5: Enable Pages with GitHub Actions as the source**

```bash
gh api -X POST repos/drkamarul/Smart_Data_Analysis/pages \
  -f "build_type=workflow" 2>/dev/null \
  || gh api -X PUT repos/drkamarul/Smart_Data_Analysis/pages -f "build_type=workflow"
```

- [ ] **Step 6: Verify the deployment succeeded**

```bash
gh run list --limit 3
gh run watch
```

Then confirm the site is live:

```bash
curl -sI https://drkamarul.github.io/Smart_Data_Analysis/ | head -1
```

Expected: `HTTP/2 200`. Pages can take a few minutes on first deploy; a 404
immediately after the run completes is worth one retry before investigating.

---

## Self-Review

**Spec coverage.** Spec §3 project structure → Tasks 1, 3. §4 slide budget →
Tasks 4, 5, 6, 7, each gated by the Task 3 linter. §5 theme → Task 2. §6 content
integrity: 5-bullet rule and budget enforced by Task 3's linter; no-figures and
`eval: false` in Global Constraints; no screenshots by omission; Part 2
verification is Task 5 Steps 1–3. §7 verification → Task 3 linter, run in every
content task. §8 publishing → Task 9. §9 source material → Task 1 Step 2, cited
in Tasks 4 and 7. §2 REAAAPP definition → Global Constraints and Task 4 Step 2.

**Placeholder scan.** No TBD or TODO. Task 5 leaves model-table *contents* to be
filled from live research — this is deliberate and specified as a research
procedure with named sources, not a vague instruction, because writing 2026
model names from memory is exactly the failure mode the constraint exists to
prevent.

**Type consistency.** Theme class names `.goal`, `.note`, `.ks`, `.takeaway`,
`.tight` are defined in Task 2 and used with those exact spellings in Tasks 4,
5, 6, 7. Part filenames match between `_quarto.yml`, `index.qmd` includes, and
the linter's `BUDGET` vector. The budget numbers 25/25/3/4 agree across the
Global Constraints, the linter, and every content task's expected output.
