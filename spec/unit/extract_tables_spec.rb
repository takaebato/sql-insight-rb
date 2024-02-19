# frozen_string_literal: true

RSpec.describe 'SqlInsight.extract_tables' do
  it 'works' do
    res = SqlInsight.extract_tables('mysql', 'SELECT * FROM t1 INNER JOIN t2 ON t1.a = t2.a')
    expect(res.count).to eq(1)
    expect(res[0]).to be_a(SqlInsight::Tables)

    tables = res[0].tables
    expect(tables.count).to eq(2)

    expect(tables[0]).to be_a(SqlInsight::TableReference)
    expect(tables[0].catalog).to be_nil
    expect(tables[0].schema).to be_nil
    expect(tables[0].name).to be_a(SqlInsight::Ident)
    expect(tables[0].name.value).to eq('t1')
    expect(tables[0].alias).to be_nil

    expect(tables[1]).to be_a(SqlInsight::TableReference)
    expect(tables[1].catalog).to be_nil
    expect(tables[1].schema).to be_nil
    expect(tables[1].name).to be_a(SqlInsight::Ident)
    expect(tables[1].name.value).to eq('t2')
    expect(tables[1].alias).to be_nil
  end
end
