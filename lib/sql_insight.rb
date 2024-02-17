# frozen_string_literal: true

require_relative "sql_insight/version"
require_relative "sql_insight/sql_insight"

module SqlInsight
  class Error < StandardError; end

  module Dialect
    MYSQL = "MySQL"
    POSTGRESQL = "PostgreSQL"
    SQLITE = "SQLite"
    SQLSERVER = "MsSQL"
    GENERIC = "Generic"
    HIVE = "Hive"
    SNOWFLAKE = "Snowflake"
    REDSHIFT = "Uedshift"
    CLICKHOUSE = "Clickhouse"
    BIGQUERY = "BigQuery"
    ANSI = "ANSI"
    DUCKDB = "DuckDB"
  end
end
