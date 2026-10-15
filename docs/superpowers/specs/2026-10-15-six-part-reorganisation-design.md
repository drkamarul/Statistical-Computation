# Design: Six Part Reorganisation (Part 0 to Part 4 plus Appendix)

**Date:** 2026-10-15
**Author:** Kamarul Imran Musa (with Claude)
**Status:** Approved in conversation, 2026-10-15
**Supersedes:** the slide budget and slide tables (sections 4 and 5) of
[2026-10-14-rreaaapp-revision-design.md](2026-10-14-rreaaapp-revision-design.md).
Its RREAAAPP definition (section 3), configuration and linter design still apply.

## 1. Why this revision

The author rewrote the "Slide structure" section of `CLAUDE.md`. Setup moves out
of the workflow part into its own Part 1, Quarto is taught for the first time, a
Part 0 states the learning objectives, and the RREAAAPP part may be shortened.

| Area | Before (2026-10-14) | Now |
|------|---------------------|-----|
| Parts | 1 Workflow · 2 AI · 3 Hands-on · Appendix | 0 Objectives · 1 Setup · 2 RREAAAPP · 3 AI · 4 Hands-on · Appendix |
| Budget | 25 / 25 / 3 / 4 (57) | 2 / 8 / 13 / 25 / 3 / 4 (55) |
| RREAAAPP | Two slides per stage | One slide per stage; detail in speaker notes |
| Setup | Positron and GitHub inside Part 1 | Part 1: Positron, Quarto, Antigravity 2.0, Claude Desktop (optional), GitHub |
| Quarto | Not taught | Two slides: what a `.qmd` is; YAML and structure |
| Screenshots | 3 of 6 | 5 of 6 |
| Learning objectives | Install Positron; GitHub; RREAAAPP; integrate AI; end to end plan | The Part 0 list (see `CLAUDE.md`) |

## 2. Decisions taken with the author (2026-10-15)

1. Budget 2 / 8 / 13 / 25 / 3 / 4.
2. RREAAAPP: one slide per stage. Goal line, Knowledge (3) and Skill (2)
   columns, a Tools note. The bullets cut from the old stage slides move into
   speaker notes, written as prose.
3. Three new screenshots were planned: a Quarto file in Positron, the Claude Desktop Code
   tab, the Antigravity download page. Two were captured. Computer-use cannot capture Claude Desktop, the app that runs the session, so the author chose text only for that slide (5 of 6 screenshots).
4. The Part 0 learning objectives replace the old list in every doc.
   `About_This_Project.md` (the author's brief) is left as written.
5. File names follow the parts: `_part0-objectives.qmd`, `_part1-setup.qmd`,
   `_part2-workflow.qmd`, `_part3-ai-assistants.qmd`, `_part4-hands-on.qmd`.

## 3. Slide tables

### Part 0: Learning Objectives (2, no divider)

| # | Slide |
|---|-------|
| 1 | Learning Objectives (five, matching `CLAUDE.md`) |
| 2 | Today's Plan: table of the five parts and what students leave with |

### Part 1: Set Up Your Tools (8)

| # | Slide | Screenshot |
|---|-------|------------|
| 1 | Divider | |
| 2 | Install Positron (R first, then Positron) | `01-positron.jpg` |
| 3 | Quarto: code and words in one file | `04-quarto-positron.jpg` |
| 4 | Quarto: the YAML header and structure (escaped code cell) | |
| 5 | Install Google Antigravity 2.0 | `05-antigravity-download.jpg` |
| 6 | Install Claude Desktop (optional, paid plan) | none (text only) |
| 7 | GitHub account and first repository | `02-github-new-repo.jpg` |
| 8 | Ready to start: a checklist | |

### Part 2: The RREAAAPP Workflow (13)

| # | Slide |
|---|-------|
| 1 | Divider |
| 2 | Why you need a workflow (merges the old "where workflows break down") |
| 3 | RREAAAPP at a glance (absorbs "how each stage is presented") |
| 4 to 11 | One slide per stage: Reason, Read, Explore, Assume, Apply, Assess, Present, Publish |
| 12 | Reproducibility runs through every stage |
| 13 | Part 2 recap |

### Part 3: AI Assistants (25)

The 2026-10-14 set, renumbered. The Antigravity 2.0 slide keeps
`03-antigravity.jpg`; the Claude Code slide points back to the Part 1 install.

### Part 4: Hands-on, 20 minutes (3)

Unchanged apart from the part number.

### Appendix (4)

Five key takeaways · Thank you · References: Workflow (adds Positron and
Quarto) · References: AI Assistants (adds Claude Desktop).

## 4. Facts checked on 2026-10-15

- Positron: free; Windows, macOS, Linux; R installed separately (4.2 or
  newer); bundles Quarto, so no separate Quarto install.
- Quarto: open-source publishing system; HTML, Word, PDF (needs TinyTeX),
  revealjs slides, websites, books.
- Antigravity 2.0: download at antigravity.google/download; app, IDE, CLI,
  Python SDK; Windows, macOS, Linux; free tier for individuals with weekly
  limits. Sign-in method not confirmed by the web check.
- Claude Desktop: Chat, Cowork and Code tabs; Claude Code needs a Pro, Max,
  Team or Enterprise plan; Code tab → Local → Select folder. Linux is in beta.
- GitHub: email verification required before creating a repository.
