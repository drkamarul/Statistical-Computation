# CLAUDE.md

Working rules for this repository.

## What this is

Slide deck for the lecture *Statistical Computation: Integrating Data Analysis
Workflow and AI Assistants*, for postgraduate medical and health researchers at
Universiti Sains Malaysia. Quarto revealjs, published to GitHub Pages.

## The workflow being taught

**REAAAPP** — seven stages: Read, Explore, Assume, Apply, Assess, Present,
Publish. Stage 4 is **Apply**, never "Analyse". Never write "REAPPP" and never
reduce it to six stages.

## Hard rules for slide content

1. Maximum **5 top-level bullets** per slide, TOTAL — including two-column
   layouts. A knowledge/skill or pros/cons slide splits 3 + 2, never 3 + 3.
   `scripts/check_slides.R` only counts flush-left `- ` bullets; it cannot see
   indented or nested ones. That is a limitation of its regex, not permission
   to hide a sixth point one level down. The cap is the lecture's design
   intent — do not build busy slides around the linter's blind spot.
2. Slide budget is fixed: Part 1 = 25, Part 2 = 25, Part 3 = 3, appendix = 4.
3. **No figures, plots, diagrams-as-images, or screenshots.** Structure comes
   from CSS classes, Quarto columns and markdown tables.
4. **Code fences must never be executable.** Write all R and shell code as
   plain ` ```r ` / ` ```bash ` fences — never ` ```{r} `. An executable chunk
   invokes the knitr engine, which needs R. `.github/workflows/publish.yml`
   installs only Quarto in CI, deliberately, because nothing in the deck
   executes; one executable chunk silently breaks publishing.
5. **Do not cite sources from slides.** `_quarto.yml` sets both
   `bibliography: references.bib` and `suppress-bibliography: true`, so an
   `[@key]` citation renders as a dead parenthetical like
   "(Google, n.d.-a)" — author restated, no date, no link. The two reference
   slides at the end of `_appendix.qmd` are hand-written lists ending in real
   URLs; edit those directly instead. `references.bib` stays as the
   machine-readable provenance record, including honest notes on source URLs
   that failed to fetch — it is not wired to any slide.
6. Part 2 facts about AI products go stale fast. Re-verify by web search
   before editing, and update the `note = {Accessed ...}` field in
   `references.bib`.

## File map

- `index.qmd` — title slide plus four includes. No slide content of its own.
- `_part1-workflow.qmd`, `_part2-ai-assistants.qmd`, `_part3-hands-on.qmd`,
  `_appendix.qmd` — the content. The `_` prefix stops Quarto rendering them
  standalone.
- `styles/academic.scss` — all theme variables and classes.
- `scripts/check_slides.R` — the budget and five-point linter.
- `references/` — source PDFs.
- `references.bib` — provenance record only; not cited from slides.
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
https://drkamarul.github.io/Smart_Data_Analysis/. CI installs only Quarto, no
R — see rule 4 above. Do not commit `_site/`.
