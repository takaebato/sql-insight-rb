# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

require 'rb_sys/extensiontask'

task build: :compile

GEMSPEC = Gem::Specification.load('sql_insight.gemspec')

RbSys::ExtensionTask.new('sql_insight', GEMSPEC) { |ext| ext.lib_dir = 'lib/sql_insight' }

require 'syntax_tree/rake_tasks'
STREE_CONFIG = ->(t) do
  t.source_files = FileList[%w[Gemfile Rakefile lib/**/*.rb spec/**/*.rb tasks/**/*.rb]]
  t.print_width = 120
  t.plugins = [%w[plugin/single_quotes plugin/trailing_comma plugin/disable_auto_ternary]]
end
SyntaxTree::Rake::CheckTask.new(&STREE_CONFIG)
SyntaxTree::Rake::WriteTask.new(&STREE_CONFIG)

task default: %i[compile spec]
task fix: %i[rubocop:autocorrect_all stree:write]
