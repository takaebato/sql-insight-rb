# frozen_string_literal: true

RSpec.describe SqlInsight::CrudTables do
  it 'works' do
    table_reference =
      SqlInsight::CrudTables.new(
        [
          SqlInsight::TableReference.new(
            SqlInsight::Ident.new('catalog', nil),
            SqlInsight::Ident.new('schema', nil),
            SqlInsight::Ident.new('create_table', nil),
            SqlInsight::Ident.new('alias', nil),
          ),
        ],
        [
          SqlInsight::TableReference.new(
            SqlInsight::Ident.new('catalog', nil),
            SqlInsight::Ident.new('schema', nil),
            SqlInsight::Ident.new('read_table', nil),
            SqlInsight::Ident.new('alias', nil),
          ),
        ],
        [
          SqlInsight::TableReference.new(
            SqlInsight::Ident.new('catalog', nil),
            SqlInsight::Ident.new('schema', nil),
            SqlInsight::Ident.new('update_table', nil),
            SqlInsight::Ident.new('alias', nil),
          ),
        ],
        [
          SqlInsight::TableReference.new(
            SqlInsight::Ident.new('catalog', nil),
            SqlInsight::Ident.new('schema', nil),
            SqlInsight::Ident.new('delete_table', nil),
            SqlInsight::Ident.new('alias', nil),
          ),
        ],
      )
    expect(table_reference).to be_a(SqlInsight::CrudTables)
  end
end
