#' Set Foreign Key
#'
#' @description
#' Creates a foreign key reference constraint on the specified
#' `key` column that references `foreign_table`'s `foreign_key` column using
#' the provided `constraint` argument as the constraint name.
#'
#' The SQL query utilized is as follows:
#'
#' ```sql
#' ALTER TABLE <schema>.<table>
#' ADD CONSTRAINT <constraint> FOREIGN KEY (<key>)
#' REFERENCES <foreign_table> (<foreign_key>);
#' ```
#' @param conn Database connection
#' @param table Table to add FK constraint to
#' @param key Column in `table` to act as the `key` referencing `foreign_key`
#' @param foreign_table Table to reference
#' @param foreign_key Column to reference from `foreign_table`
#' @param constraint Name of the constraint to be created.
#'
#' @return SQL query
#' @export
#' @importFrom DBI dbExecute
#' @importFrom glue glue_sql
set_foreign_key <- function(conn,
                            table,
                            key,
                            foreign_table,
                            foreign_key = key,
                            constraint = paste(table, key, "fk", sep = "_")) {

  query <- glue::glue_sql(
    "ALTER TABLE {`table`} ",
    "ADD CONSTRAINT {`constraint`} ",
    "FOREIGN KEY ({`key`}) ",
    "REFERENCES {`foreign_table`} ({`foreign_key`})",
    .con = conn
  )

  for (q in query) DBI::dbExecute(conn, q)

  return(query)

}
