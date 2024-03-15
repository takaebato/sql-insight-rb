# frozen_string_literal: true

RSpec.describe SqlInsight::Tables do
  let(:tables) do
    SqlInsight::Tables.new(
      [
        SqlInsight::TableReference.new(
          SqlInsight::Ident.new('catalog', '`'),
          SqlInsight::Ident.new('schema', '`'),
          SqlInsight::Ident.new('table', '`'),
          SqlInsight::Ident.new('alias', '`'),
        ),
      ],
    )
  end

  describe '.new' do
    it 'creates a new Tables' do
      expect(tables).to be_a(SqlInsight::Tables)
    end

    context 'when argument is not an array of TableReference' do
      it 'raises TypeError' do
        expect { SqlInsight::Tables.new(['foo']) }.to raise_error(
          TypeError,
          'No implicit conversion of String into SqlInsight::TableReference',
        )
      end
    end
  end

  describe '#tables' do
    it 'returns tables' do
      expect(tables.tables.map(&:to_s)).to eq(['`catalog`.`schema`.`table` AS `alias`'])
    end
  end

  describe '#tables=' do
    it 'sets tables' do
      tables = SqlInsight::Tables.new([])
      tables.tables = [
        SqlInsight::TableReference.new(
          SqlInsight::Ident.new('new_catalog', '`'),
          SqlInsight::Ident.new('new_schema', '`'),
          SqlInsight::Ident.new('new_table', '`'),
          SqlInsight::Ident.new('new_alias', '`'),
        ),
      ]
      expect(tables.tables.map(&:to_s)).to eq(['`new_catalog`.`new_schema`.`new_table` AS `new_alias`'])
    end

    context 'when argument is not an array of TableReference' do
      it 'raises TypeError' do
        tables = SqlInsight::Tables.new([])
        expect { tables.tables = [1] }.to raise_error(
          TypeError,
          'No implicit conversion of Integer into SqlInsight::TableReference',
        )
      end
    end
  end
end
