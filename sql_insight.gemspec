# frozen_string_literal: true

require_relative 'lib/sql_insight/version'

Gem::Specification.new do |spec|
  spec.name = 'sql_insight'
  spec.version = SqlInsight::VERSION
  spec.authors = ['Takahiro Ebato']
  spec.email = ['takahiro.ebato@gmail.com']

  spec.summary = 'Ruby bindings for the sql-insight, a utility for SQL query analysis and transformation'
  spec.description = 'Ruby bindings for the sql-insight, a utility for SQL query analysis and transformation supporting various SQL dialects'
  spec.homepage = 'https://github.com/takaebato/sql-insight-rb'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.2'
  # https://github.com/rubygems/rubygems/pull/5852#issuecomment-1231118509
  spec.required_rubygems_version = '>= 3.3.22'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/takaebato/sql-insight-rb'
  spec.metadata['changelog_uri'] = 'https://github.com/takaebato/sql-insight-rb/blob/master/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['{lib,ext}/**/*', 'Cargo.*']
  spec.files.reject! { |f| File.directory?(f) }
  spec.files.reject! { |f| f =~ /\.(dll|so|dylib|lib|bundle)\Z/ }
  spec.require_paths = ['lib']
  spec.extensions = ['ext/sql_insight/extconf.rb']

  spec.add_dependency 'rb_sys', '~> 0.9.90'
end
