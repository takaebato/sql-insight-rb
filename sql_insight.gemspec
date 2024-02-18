# frozen_string_literal: true

require_relative 'lib/sql_insight/version'

Gem::Specification.new do |spec|
  spec.name = 'sql_insight'
  spec.version = SqlInsight::VERSION
  spec.authors = ['Takahiro Ebato']
  spec.email = ['takahiro.ebato@gmail.com']

  spec.summary = 'Ruby bindings for the sql-insight, a toolkit for SQL query analysis and transformation'
  spec.description = 'Ruby bindings for the sql-insight, a toolkit for SQL query analysis and transformation supporting various SQL dialects'
  spec.homepage = 'https://github.com/takaebato/sql-insight-rb'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.4'
  spec.required_rubygems_version = '>= 3.3.11'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/takaebato/sql-insight-rb'
  spec.metadata['changelog_uri'] = 'https://github.com/takaebato/sql-insight-rb/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions = ['ext/sql_insight/Cargo.toml']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
spec.metadata['rubygems_mfa_required'] = 'true'
end
