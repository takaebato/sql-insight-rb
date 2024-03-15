# frozen_string_literal: true

RSpec.describe SqlInsight::CrudTables do
  let(:table_reference) do
    SqlInsight::TableReference.new(
      SqlInsight::Ident.new('catalog', '`'),
      SqlInsight::Ident.new('schema', '`'),
      SqlInsight::Ident.new('create_table', '`'),
      SqlInsight::Ident.new('alias', '`'),
    )
  end

  let(:new_table_reference) do
    SqlInsight::TableReference.new(
      SqlInsight::Ident.new('new_catalog', '`'),
      SqlInsight::Ident.new('new_schema', '`'),
      SqlInsight::Ident.new('new_table', '`'),
      SqlInsight::Ident.new('new_alias', '`'),
    )
  end

  describe '.new' do
    it 'creates a new CrudTables' do
      crud_tables =
        SqlInsight::CrudTables.new(
          [
            SqlInsight::TableReference.new(
              SqlInsight::Ident.new('catalog', '`'),
              SqlInsight::Ident.new('schema', '`'),
              SqlInsight::Ident.new('create_table', '`'),
              SqlInsight::Ident.new('alias', '`'),
            ),
          ],
          [
            SqlInsight::TableReference.new(
              SqlInsight::Ident.new('catalog', '`'),
              SqlInsight::Ident.new('schema', '`'),
              SqlInsight::Ident.new('read_table', '`'),
              SqlInsight::Ident.new('alias', '`'),
            ),
          ],
          [
            SqlInsight::TableReference.new(
              SqlInsight::Ident.new('catalog', '`'),
              SqlInsight::Ident.new('schema', '`'),
              SqlInsight::Ident.new('update_table', '`'),
              SqlInsight::Ident.new('alias', '`'),
            ),
          ],
          [
            SqlInsight::TableReference.new(
              SqlInsight::Ident.new('catalog', '`'),
              SqlInsight::Ident.new('schema', '`'),
              SqlInsight::Ident.new('delete_table', '`'),
              SqlInsight::Ident.new('alias', '`'),
            ),
          ],
        )
      expect(crud_tables).to be_a(SqlInsight::CrudTables)
    end

    context 'when args are not an array of TableReference' do
      it 'raises TypeError' do
        expect { SqlInsight::CrudTables.new([], ['foo'], [], []) }.to raise_error(
          TypeError,
          'No implicit conversion of String into SqlInsight::TableReference',
        )
      end
    end
  end

  describe '#create_tables' do
    it 'returns create_tables' do
      crud_tables = SqlInsight::CrudTables.new([table_reference], [], [], [])
      expect(crud_tables.create_tables.map(&:to_s)).to eq(['`catalog`.`schema`.`create_table` AS `alias`'])
    end
  end

  describe '#create_tables=' do
    it 'sets create_tables' do
      crud_tables = SqlInsight::CrudTables.new([], [], [], [])
      crud_tables.create_tables = [new_table_reference]
      expect(crud_tables.create_tables.map(&:to_s)).to eq(['`new_catalog`.`new_schema`.`new_table` AS `new_alias`'])
    end

    context 'when args are not an array of TableReference' do
      it 'raises TypeError' do
        crud_tables = SqlInsight::CrudTables.new([], [], [], [])
        expect { crud_tables.create_tables = [1] }.to raise_error(
          TypeError,
          'No implicit conversion of Integer into SqlInsight::TableReference',
        )
      end
    end
  end

  describe '#read_tables' do
    it 'returns read_tables' do
      crud_tables = SqlInsight::CrudTables.new([], [table_reference], [], [])
      expect(crud_tables.read_tables.map(&:to_s)).to eq(['`catalog`.`schema`.`create_table` AS `alias`'])
    end
  end

  describe '#read_tables=' do
    it 'sets read_tables' do
      crud_tables = SqlInsight::CrudTables.new([], [], [], [])
      crud_tables.read_tables = [new_table_reference]
      expect(crud_tables.read_tables.map(&:to_s)).to eq(['`new_catalog`.`new_schema`.`new_table` AS `new_alias`'])
    end

    context 'when args are not an array of TableReference' do
      it 'raises TypeError' do
        crud_tables = SqlInsight::CrudTables.new([], [], [], [])
        expect { crud_tables.read_tables = [1] }.to raise_error(
          TypeError,
          'No implicit conversion of Integer into SqlInsight::TableReference',
        )
      end
    end
  end

  describe '#update_tables' do
    it 'returns update_tables' do
      crud_tables = SqlInsight::CrudTables.new([], [], [table_reference], [])
      expect(crud_tables.update_tables.map(&:to_s)).to eq(['`catalog`.`schema`.`create_table` AS `alias`'])
    end
  end

  describe '#update_tables=' do
    it 'sets update_tables' do
      crud_tables = SqlInsight::CrudTables.new([], [], [], [])
      crud_tables.update_tables = [new_table_reference]
      expect(crud_tables.update_tables.map(&:to_s)).to eq(['`new_catalog`.`new_schema`.`new_table` AS `new_alias`'])
    end

    context 'when args are not an array of TableReference' do
      it 'raises TypeError' do
        crud_tables = SqlInsight::CrudTables.new([], [], [], [])
        expect { crud_tables.update_tables = [1] }.to raise_error(
          TypeError,
          'No implicit conversion of Integer into SqlInsight::TableReference',
        )
      end
    end
  end

  describe '#delete_tables' do
    it 'returns delete_tables' do
      crud_tables = SqlInsight::CrudTables.new([], [], [], [table_reference])
      expect(crud_tables.delete_tables.map(&:to_s)).to eq(['`catalog`.`schema`.`create_table` AS `alias`'])
    end
  end

  describe '#delete_tables=' do
    it 'sets delete_tables' do
      crud_tables = SqlInsight::CrudTables.new([], [], [], [])
      crud_tables.delete_tables = [new_table_reference]
      expect(crud_tables.delete_tables.map(&:to_s)).to eq(['`new_catalog`.`new_schema`.`new_table` AS `new_alias`'])
    end

    context 'when args are not an array of TableReference' do
      it 'raises TypeError' do
        crud_tables = SqlInsight::CrudTables.new([], [], [], [])
        expect { crud_tables.delete_tables = [1] }.to raise_error(
          TypeError,
          'No implicit conversion of Integer into SqlInsight::TableReference',
        )
      end
    end
  end
end
