
#  ------------------------------------------------------------------------
#
# Title : `pgres` R Package Development Script
#    By : Jimmy Briggs
#  Date : 2022-02-25
#
#  ------------------------------------------------------------------------

# library R packages ------------------------------------------------------

library(pkgdev)
pkgdev::library_dev_packages()

# initialize package ------------------------------------------------------

usethis::create_package("pgres")
usethis::use_namespace()
usethis::use_roxygen_md()
usethis::use_package_doc(open = FALSE)
usethis::use_git()
usethis::use_tibble() # #' @return a [tibble][tibble::tibble-package]
usethis::use_pipe()
# usethis::use_tidy_eval()
devtools::document()

pkgdev::use_feedback_helpers(open = FALSE)

# github ------------------------------------------------------------------

# set description and title first so included in GH repo
desc::desc_set(
  "Description" = "Suite of Database Utility Helpers Specific to PostgreSQL.",
  "Title" = "PostgreSQL Utility Helper Functions in R"
)

usethis::use_github(private = FALSE)

# github labels -----------------------------------------------------------
library(templateeR)
templateeR::use_gh_labels()
templateeR::use_git_cliff()
templateeR::use_git_cliff_action()

# package docs ------------------------------------------------------------

usethis::use_readme_rmd()
usethis::use_mit_license("Jimmy Briggs | 2022")
usethis::use_package_doc()
usethis::use_news_md()


# functions ---------------------------------------------------------------

c(
  # add function file names here:
  "utils",
  "set_primary_key",
  "set_foreign_key",
  "clean_sql"#,
  # "create_sql"
) |> purrr::walk(usethis::use_r, open = FALSE)


# tests -------------------------------------------------------------------

c(
  # add function test file names here:

) |> purrr::walk(usethis::use_test)

# data --------------------------------------------------------------------

c(
  # add data prep script names here:

) |> purrr::walk(usethis::use_data_raw)

# vignettes ---------------------------------------------------------------

c(
  # add vignette names here:
  "pgres"

) |> purrr::walk(usethis::use_vignette)


# pkgdown -----------------------------------------------------------------

usethis::use_pkgdown_github_pages()
remove.packages("chameleon")
pak::pak("thinkr-open/chameleon")

fs::dir_create("inst/docs")
chameleon::open_pkgdown_function()

usethis::use_coverage()
usethis::use_github_action("test-coverage")

chameleon::open_pkgdown_function()
attachment::att_amend_desc()
attachment::create_dependencies_file(to = "inst/scripts/dependencies.R")

covrpage::covrpage()

usethis::use_lifecycle_badge("experimental")
usethis::use_spell_check()

devtools::build_readme()
codemetar::write_codemeta()
