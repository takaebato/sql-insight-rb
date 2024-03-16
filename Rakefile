# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'syntax_tree/rake_tasks'
STREE_CONFIG = ->(t) do
  t.source_files = FileList[%w[Gemfile Rakefile lib/**/*.rb spec/**/*.rb tasks/**/*.rb]]
  t.print_width = 120
  t.plugins = [%w[plugin/single_quotes plugin/trailing_comma plugin/disable_auto_ternary]]
end
SyntaxTree::Rake::CheckTask.new(&STREE_CONFIG)
SyntaxTree::Rake::WriteTask.new(&STREE_CONFIG)

require 'rb_sys/extensiontask'
CROSS_PLATFORMS = %w[
  arm-linux
  aarch64-linux
  arm64-darwin
  x64-mingw-ucrt
  x64-mingw32
  x86_64-darwin
  x86_64-linux
  x86_64-linux-musl
].freeze
GEMSPEC = Gem::Specification.load('sql_insight.gemspec')
RbSys::ExtensionTask.new('sql_insight', GEMSPEC) do |ext|
  ext.lib_dir = 'lib/sql_insight'
  ext.source_pattern = '*.{rs,toml,lock,rb}'
  ext.cross_compile = true
  ext.cross_platform = CROSS_PLATFORMS
  ext.config_script = 'extconf.rb'
end

task build: :compile
task default: %i[compile spec]
task fix: %i[rubocop:autocorrect_all stree:write]
