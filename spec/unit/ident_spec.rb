# frozen_string_literal: true

RSpec.describe SqlInsight::Ident do
  describe '.new' do
    it 'creates a new Ident' do
      ident = SqlInsight::Ident.new('table', '`')
      expect(ident).to be_a(SqlInsight::Ident)
    end
  end

  describe '#value' do
    it 'returns value' do
      ident = SqlInsight::Ident.new('table', '`')
      expect(ident.value).to eq('table')
    end
  end

  describe '#value=' do
    it 'sets value' do
      ident = SqlInsight::Ident.new('table', '`')
      ident.value = 'new_table'
      expect(ident.value).to eq('new_table')
    end
  end

  describe '#quote_style' do
    it 'returns quoted value' do
      ident = SqlInsight::Ident.new('table', '`')
      expect(ident.quote_style).to eq('`')
    end
  end

  describe '#quote_style=' do
    it 'sets quote_style' do
      ident = SqlInsight::Ident.new('table', '`')
      ident.quote_style = '"'
      expect(ident.quote_style).to eq('"')
    end
  end

  describe '#to_s' do
    it 'returns string' do
      ident = SqlInsight::Ident.new('table', '`')
      expect(ident.to_s).to eq('`table`')
    end
  end
end
