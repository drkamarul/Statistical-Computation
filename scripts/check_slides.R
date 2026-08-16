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

    # A level-3 heading is promoted by pandoc's --section-divs into a <section>,
    # and reveal.js reads a <section> nested inside a slide as a vertical slide
    # stack. That silently breaks horizontal navigation from this slide onward:
    # the deck simply stops advancing. Use [Label]{.ks-label} instead.
    if (any(grepl("^### ", body))) {
      problems <- c(problems,
        sprintf("%s: slide %d (%s) uses a '### ' heading, which reveal.js turns into a nested vertical slide -- use [Label]{.ks-label}",
                path, i, title))
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
