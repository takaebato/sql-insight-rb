# frozen_string_literal: true

RSpec.describe 'SqlInsight.extract_tables' do
  it 'extracts tables from SQL' do
    res = SqlInsight.extract_tables('generic', 'SELECT * FROM t1 INNER JOIN t2 ON t1.a = t2.a')
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

  context 'when dialect is invalid' do
    it 'raises ArgumentError' do
      expect { SqlInsight.extract_tables('foo', '') }.to raise_error(ArgumentError, 'Unknown dialect: foo')
    end
  end
  context 'when SQL syntax is invalid' do
    it 'raises SqlInsight::ParserError' do
      expect { SqlInsight.extract_tables('generic', 'SELECT * FROM t1 WHERE a in (1, 2') }.to raise_error(
        SqlInsight::ParserError,
      )
    end
  end

  context 'when SQL analysis fails' do
    it 'raises SqlInsight::AnalysisError' do
      expect { SqlInsight.extract_tables('generic', 'SELECT * FROM catalog.schema.table.extra') }.to raise_error(
        SqlInsight::AnalysisError,
      )
    end
  end
end
