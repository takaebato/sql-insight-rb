# frozen_string_literal: true

require_relative 'sql_insight/version'
require_relative 'sql_insight/sql_insight'
require_relative 'sql_insight/dialect'
require_relative 'sql_insight/errors'

# https://github.com/rake-compiler/rake-compiler/blob/master/README.md
# Technique to lookup the fat binaries first, and then lookup the gems compiled by the end user.
begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require_relative "sql_insight/#{Regexp.last_match(1)}/sql_insight"
rescue LoadError
  require_relative 'sql_insight/sql_insight'
end

module SqlInsight
end
