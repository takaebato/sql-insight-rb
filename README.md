# sql_insight

`sql-insight-rb` is Ruby bindings for [sql-insight](https://github.com/takaebato/sql-insight) which is a utility for SQL query analysis, formatting, and transformation, supporting various SQL dialects.

[![Main](https://github.com/takaebato/sql-insight-rb/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/takaebato/sql-insight-rb/actions/workflows/main.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Features

- **SQL Formatting**: Format SQL queries to standardized form, improving readability and maintainability.
- **SQL Normalization**: Convert SQL queries into a normalized form, making them easier to analyze and process.
- **Table Extraction**: Extract tables referenced in SQL queries, clarifying the data sources involved.
- **CRUD Table Extraction**: Identify the create, read, update, and delete operations, along with the tables involved in each operation within SQL queries.

## Installation

### Prerequisites

We recommend to use the precompiled gem for the best performance and compatibility.
In order to install the precompiled gem, ensure that your platform is listed in your `Gemfile.lock`.

When your platform is x86_64-linux, for instance, run the following command to add x86_64-linux to your Gemfile.lock:

```
bundle lock --add-platform x86_64-linux
```

If you face any challenges or need guidance on building on your machine, please refer to [INSTALLATION_GUIDE.md](https://github.com/takaebato/sql-insight-rb/blob/master/INSTALLATION_GUIDE.md).

### Gem Installation

Add the sql_insight gem to your Gemfile and run bundle install:

```ruby
gem 'sql_insight'
```

## Usage

### SQL Formatting

Format SQL queries according to different dialects:

```ruby
SqlInsight.format('generic', "SELECT * \n from users   WHERE id = 1")
#=> ['SELECT * FROM users WHERE id = 1']
```

### SQL Normalization

Normalize SQL queries to abstract away literals:

```ruby
SqlInsight.normalize('generic', "SELECT * \n from users   WHERE id = 1")
#=> ['SELECT * FROM users WHERE id = ?']
```

### Table Extraction

Extract table references from SQL queries:

```ruby
SqlInsight.extract_tables('generic', "SELECT * FROM catalog.schema.`users` as users_alias")
```

### CRUD Table Extraction

Identify CRUD operations and the tables involved in each operation within SQL queries:

```ruby
SqlInsight.extract_crud_tables('generic', "INSERT INTO users (name) SELECT name FROM employees")
```

## Contributing

Contributions to `sql-insight-rb` are welcome! Whether it's adding new features, fixing bugs, or improving documentation, feel free to fork the repository and submit a pull request.

## License

`sql-insight-rb` is distributed under the [MIT license](https://github.com/takaebato/sql-insight-rb/blob/master/LICENSE.txt).

## Code of Conduct

Everyone interacting in the `sql-insight-rb` project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/takaebato/sql-insight-rb/blob/master/CODE_OF_CONDUCT.md).
