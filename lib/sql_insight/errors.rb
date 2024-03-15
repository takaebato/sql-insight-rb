# frozen_string_literal: true

# Definitions must be synced with ext/sql_insight/src/errors.rs
module SqlInsight
  class Error < StandardError
  end

  class ParserError < Error
  end

  class AnalysisError < Error
  end
end
