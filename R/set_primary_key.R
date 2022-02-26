#' Set Primary Key
#'
#' @description
#' Creates a `PRIMARY KEY` constraint on the specified `column`
#' for the provided `table` via the SQL query:
#' `ALTER TABLE <schema>.<table> ADD PRIMARY KEY (<column>);`.
#'
#' @param conn Database connection
#' @param table Character string representing the table (with optional schema
#'  prefix) to alter.
#' @param column Character string representing the column(s) to add as primary
#'  keys. Note that multiple columns are allowed to create a *conjugate primary
#'  key*.
#'
#' @return returns the SQL query for reference
#' @export
#'
#' @examples
#' \dontrun{
#' conn <- pg_connect()
#'
#' # set a primary key on the table 'users' for column 'user_id':
#' set_primary_key(conn, "users", "user_id")
#'
#' }
#'
#' @importFrom DBI dbIsValid dbListTables dbExecute
#' @importFrom glue glue
#' @importFrom stringr str_c
set_primary_key <- function(conn = getOption(pg.conn, pg_connect()),
                            table,
                            column) {

  # validate connection
  stopifnot(DBI::dbIsValid(conn))

  # validate table exists
  tbls <- DBI::dbListTables(conn)
  stopifnot(table %in% tbls)

  # validate column(s)
  if (length(column) > 1) {
    column <- stringr::str_c(column, sep = ", ")
  }

  query <- glue::glue('ALTER TABLE "{table}" ADD PRIMARY KEY ("{column}")')
  DBI::dbExecute(conn = conn, query)

  return(query)
}

