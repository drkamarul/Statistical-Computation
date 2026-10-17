#!/usr/bin/env Rscript
# check_slides.R — enforce the slide budget, the five-point rule, the
# screenshot cap and the RREAAAPP spelling.
# Base R only, no package dependencies. Run from the project root.

BUDGET <- c(
  "_part0-objectives.qmd"    =  2L,
  "_part1-setup.qmd"         = 12L,
  "_part2-workflow.qmd"      = 13L,
  "_part3-ai-assistants.qmd" = 25L,
  "_part4-hands-on.qmd"      =  3L,
  "_appendix.qmd"            =  4L
)
MAX_BULLETS <- 5L
MAX_SCREENSHOTS <- 6L

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

  # The workflow is RREAAAPP (eight stages). A bare REAAAPP is the retired
  # seven-stage name and must not reappear on a slide.
  for (k in grep("(?<!R)REAAAPP", lines, perl = TRUE)) {
    problems <- c(problems,
      sprintf("%s: '%s' uses REAAAPP -- the workflow is RREAAAPP",
              path, trimws(lines[k])))
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

# Screenshots of real software are allowed, but only MAX_SCREENSHOTS in the
# whole deck; own figures and plots are not allowed at all.
n_img <- sum(vapply(names(BUDGET), function(f) {
  if (!file.exists(f)) return(0L)
  lines <- strip_code(readLines(f, warn = FALSE))
  sum(lengths(regmatches(lines, gregexpr("!\\[", lines))))
}, integer(1)))
if (n_img > MAX_SCREENSHOTS) {
  problems <- c(problems,
    sprintf("deck has %d images, max is %d screenshots", n_img, MAX_SCREENSHOTS))
}

if (length(problems)) {
  cat("Slide check FAILED\n")
  cat(paste0("  - ", problems, collapse = "\n"), "\n", sep = "")
  quit(status = 1L)
}

cat(sprintf(paste0("Slide check passed: %s slides, no slide over %d bullets, ",
                   "%d of %d screenshots, RREAAAPP spelling.\n"),
            paste(BUDGET, collapse = " / "), MAX_BULLETS, n_img, MAX_SCREENSHOTS))
quit(status = 0L)
