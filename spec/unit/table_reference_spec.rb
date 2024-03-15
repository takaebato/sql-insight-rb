# frozen_string_literal: true

RSpec.describe SqlInsight::TableReference do
  let(:table_reference) do
    SqlInsight::TableReference.new(
      SqlInsight::Ident.new('catalog', '`'),
      SqlInsight::Ident.new('schema', '`'),
      SqlInsight::Ident.new('table', '`'),
      SqlInsight::Ident.new('alias', '`'),
    )
  end

  describe '.new' do
    it 'creates a new TableReference' do
      expect(table_reference).to be_a(SqlInsight::TableReference)
    end
  end

  describe '#catalog' do
    it 'returns catalog' do
      expect(table_reference.catalog.value).to eq('catalog')
    end
  end

  describe '#catalog=' do
    it 'sets catalog' do
      table_reference.catalog = SqlInsight::Ident.new('new_catalog', '`')
      expect(table_reference.catalog.value).to eq('new_catalog')
    end
  end

  describe '#schema' do
    it 'returns schema' do
      expect(table_reference.schema.value).to eq('schema')
    end
  end

  describe '#schema=' do
    it 'sets schema' do
      table_reference.schema = SqlInsight::Ident.new('new_schema', '`')
      expect(table_reference.schema.value).to eq('new_schema')
    end
  end

  describe '#name' do
    it 'returns name' do
      expect(table_reference.name.value).to eq('table')
    end
  end

  describe '#name=' do
    it 'sets name' do
      table_reference.name = SqlInsight::Ident.new('new_table', '`')
      expect(table_reference.name.value).to eq('new_table')
    end
  end

  describe '#alias' do
    it 'returns alias' do
      expect(table_reference.alias.value).to eq('alias')
    end
  end

  describe '#alias=' do
    it 'sets alias' do
      table_reference.alias = SqlInsight::Ident.new('new_alias', '`')
      expect(table_reference.alias.value).to eq('new_alias')
    end
  end

  describe '#to_s' do
    it 'returns formatted string for display' do
      expect(table_reference.to_s).to eq('`catalog`.`schema`.`table` AS `alias`')
    end
  end
end
