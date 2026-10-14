# Design: 2026 Revision, RREAAAPP + AI Assistants

**Date:** 2026-10-14
**Author:** Kamarul Imran Musa (with Claude)
**Status:** Approved in conversation, 2026-10-14
**Supersedes:** [2026-08-16-reaaapp-ai-lecture-design.md](2026-08-16-reaaapp-ai-lecture-design.md)
for everything below; sections of that spec not mentioned here (include-based
file structure, theme, CI design) still apply.

## 1. Why this revision

The author revised `About_This_Project.md`. The changes that matter:

| Area | Before (August spec) | Now |
|------|---------------------|-----|
| Workflow | REAAAPP, 7 stages | **RREAAAPP**, 8 stages: Reason added first |
| Learning objectives | 3 | 5: adds install Positron, register GitHub and create a repo |
| Audience | Medical and health researchers | Public health postgraduates, minimal maths, no R, no GitHub |
| Screenshots | Banned | Allowed, max 6; Part 2 must show Google Antigravity 2.0 |
| Dashes | No rule | No rule (dashes allowed) |
| Part 2 examples | Gemini app, Antigravity IDE, Antigravity CLI | Google Antigravity 2.0 and Claude Code |
| Part 3 | Student's own dataset, open ended | MSSM FBS workshop data, doable in 20 minutes |
| Agent docs | CLAUDE.md | CLAUDE.md + AGENTS.md (mirror) |
| YAML | `embed-resources: false` | `embed-resources: true`; author website myanalytics.com.my |
| Remote | Smart_Data_Analysis | **Statistical-Computation**; Smart_Data_Analysis kept untouched |
| Hosting | GitHub Pages via Actions | None: no CI, no web hosting |
| Output | Quarto project, `index.qmd` → `_site/index.html` | Standalone deck `statistical-computation.qmd` → `statistical-computation.html` |

## 2. Decisions taken with the author (2026-10-14)

1. RREAAAPP everywhere. Leftover "REAAAPP" in the brief is a typo.
2. Screenshots of real products allowed, maximum 6 in total, captured with
   computer-use. Own figures and plots stay banned.
3. Dashes allowed (author, 2026-10-14). An earlier reading of "No hyphen" as
   a ban on dashes was withdrawn.
4. `origin` → `https://github.com/drkamarul/Statistical-Computation.git`. No
   GitHub Pages: the author hosts the rendered slides elsewhere.
   Smart_Data_Analysis is left as is and never pushed to again.
5. Positron and GitHub setup live inside Part 1; the 25 slide budget holds.
6. AGENTS.md mirrors CLAUDE.md, written tool neutrally.
7. Part 3 reuses the MSSM FBS data from `references/02_rreaaapp_workflow.html`.
   The file is distributed separately and never committed.
8. Delete `.github/workflows/publish.yml`; there is no CI.
9. A normal Quarto slide deck, not a website: rename `index.qmd` to
   `statistical-computation.qmd`, delete `_quarto.yml`, no `index.html`.

## 3. RREAAAPP (authoritative definition)

Source: `references/02_rreaaapp_workflow.html` (Topic B deck).

| # | Letter | Stage | Goal |
|---|--------|-------|------|
| 1 | R | Reason | Know why you analyse: question, population, outcome, explanatory variables, fit of data. |
| 2 | R | Read | Get data of known provenance into R; the Reason decides `filter()` and `select()`. |
| 3 | E | Explore | Look at distributions and data quality before modelling. |
| 4 | A | Assume | State and check the assumptions the analysis depends on. |
| 5 | A | Apply | Fit the models and methods chosen. |
| 6 | A | Assess | Check diagnostics, fit and validity. |
| 7 | P | Present | Report results with a plain language interpretation. |
| 8 | P | Publish | Release code and report so others can check them; data only with ethics approval. |

Reason test, from the source deck: if you cannot write your reason in one
sentence, do not open R yet.

## 4. Slide budget

### Part 1: The RREAAAPP Workflow (25)

| Slide | Content | Screenshot |
|-------|---------|------------|
| 1 | Divider: Part 1: The RREAAAPP Workflow | |
| 2 | Why you need a workflow | |
| 3 | RREAAAPP at a glance (8 stages) | |
| 4 | How each stage is presented: goal, knowledge, skill | |
| 5 | Set up: install Positron | Positron window |
| 6 | Set up: register GitHub and create a repository | GitHub new repository page |
| 7–8 | **Reason**: goal; knowledge and skill | |
| 9–10 | **Read** | |
| 11–12 | **Explore** | |
| 13–14 | **Assume** | |
| 15–16 | **Apply** | |
| 17–18 | **Assess** | |
| 19–20 | **Present** (fold in SAMPL and the ASA p value statement) | |
| 21–22 | **Publish** (fold in Git and data sharing rules) | |
| 23 | Reproducibility runs through every stage | |
| 24 | Where workflows break down | |
| 25 | Part 1 recap | |

Cut from the August deck to make room: "Working in a Team: Git as the
Backbone", "Reporting Guidelines You Should Know", "Publishing Data: Credit and
Reuse", "Rate Yourself at Each Stage". Their key points move into the Present
and Publish knowledge slides, within the five bullet cap.

### Part 2: AI Assistants (25)

Same as August except:

- Drop slide 2 "Before AI Assistants" to free one slide.
- Web, IDE and CLI pros and cons slides use **Google Antigravity 2.0** and
  **Claude Code** as the named examples (Gemini app may remain as the web
  example only if still accurate).
- Slide 20: **Google Antigravity 2.0**, with its screenshot.
- Slide 21 (new): **Claude Code**, with its screenshot.
- "Plan Before You Prompt" code block becomes eight stages, starting with Reason.
- Every product fact re-verified by web search (October 2026), and
  `references.bib` access notes updated.

### Part 3: Hands-on, 20 minutes (3)

| Slide | Content |
|-------|---------|
| 1 | Divider and task: write a RREAAAPP plan for the MSSM FBS data with your AI assistant; timing 2 + 8 + 7 + 3 minutes |
| 2 | Set up: open the workshop folder in Positron, data at `datasets/mssm_fbs_workshop.xlsx`, create a GitHub repo, keep `datasets/` out of Git |
| 3 | `implementation_plan.md` template with eight headings, Reason first, plus one prompt to give the assistant |

The plan is the deliverable; students do not need to run the full analysis in
20 minutes.

### Appendix (4)

Five key summaries (eight stages, Reason first) · Thank you (new repo URL,
myanalytics.com.my) · References: Workflow (add the Topic B RREAAAPP
deck) · References: AI Assistants (add Antigravity 2.0 and Claude Code pages).

## 5. Screenshot budget (max 6)

| # | Where | Subject |
|---|-------|---------|
| 1 | Part 1 slide 5 | Positron with a project open |
| 2 | Part 1 slide 6 | GitHub "Create a new repository" page |
| 3 | Part 2 slide 20 | Google Antigravity 2.0 (required by the brief) |
| 4–6 | Spare | Use only if a slide clearly needs it |

Claude Code: no screenshot (author's decision, 2026-10-14). The CLI is not
installed on the author's laptop, and the desktop app shows private session
titles. The Claude Code slide stays text only.

As captured: the GitHub shot shows the new, empty `Statistical-Computation`
repository page (quick setup), not the creation form.

Files: `images/screenshots/NN-name.jpg` (PNG or JPEG), cropped to the relevant window, no
personal data, alt text on every image. `embed-resources: true` inlines them in
the rendered HTML.

## 6. Linter changes (`scripts/check_slides.R`)

Additive checks only; no existing limit changes.

- `MAX_SCREENSHOTS <- 6L`: count `![` image references across all four files.
- Acronym check: flag any `REAAAPP` that is not part of `RREAAAPP`.

## 7. Configuration changes

- `git mv index.qmd statistical-computation.qmd`; move every option from
  `_quarto.yml` (format, theme, bibliography, `suppress-bibliography`) into its
  YAML, set `embed-resources: true`, then delete `_quarto.yml`.
- `.gitignore`: add `statistical-computation.html` and `datasets/`.
- Deck YAML: author block becomes Kamarul Imran Musa with
  `url: https://myanalytics.com.my`, keeping the USM affiliation.
- `references.bib`: add the Topic B deck; refresh Part 2 access notes.
- Delete `.github/workflows/publish.yml`.
- Remote: `git remote set-url origin https://github.com/drkamarul/Statistical-Computation.git`.
  No Pages setup.
