# frozen_string_literal: true

RSpec.describe 'SqlInsight.extract_crud_tables' do
  it 'works' do
    res = SqlInsight.extract_crud_tables('mysql', 'INSERT INTO t1 SELECT * FROM t2')
    expect(res.count).to eq(1)
    expect(res[0]).to be_a(SqlInsight::CrudTables)

    create_tables = res[0].create_tables
    expect(create_tables.count).to eq(1)
    expect(create_tables[0]).to be_a(SqlInsight::TableReference)
    expect(create_tables[0].catalog).to be_nil
    expect(create_tables[0].schema).to be_nil
    expect(create_tables[0].name).to be_a(SqlInsight::Ident)
    expect(create_tables[0].name.value).to eq('t1')
    expect(create_tables[0].alias).to be_nil

    read_tables = res[0].read_tables
    expect(read_tables.count).to eq(1)
    expect(read_tables[0]).to be_a(SqlInsight::TableReference)
    expect(read_tables[0].catalog).to be_nil
    expect(read_tables[0].schema).to be_nil
    expect(read_tables[0].name).to be_a(SqlInsight::Ident)
    expect(read_tables[0].name.value).to eq('t2')
    expect(read_tables[0].alias).to be_nil

    update_tables = res[0].update_tables
    expect(update_tables.count).to eq(0)

    delete_tables = res[0].delete_tables
    expect(delete_tables.count).to eq(0)
  end
end
