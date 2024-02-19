# frozen_string_literal: true

RSpec.describe SqlInsight::Tables do
  it 'works' do
    table_reference =
      SqlInsight::Tables.new(
        [
          SqlInsight::TableReference.new(
            SqlInsight::Ident.new('catalog', nil),
            SqlInsight::Ident.new('schema', nil),
            SqlInsight::Ident.new('table', nil),
            SqlInsight::Ident.new('alias', nil),
          ),
        ],
      )
    expect(table_reference).to be_a(SqlInsight::Tables)
  end
end
