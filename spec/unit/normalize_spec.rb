# frozen_string_literal: true

RSpec.describe 'SqlInsight.normalize' do
  it 'normalizes SQL' do
    res = SqlInsight.normalize('generic', "SELECT * \n FROM t1    \n WHERE a = 1 and b in (1, 2)")
    expect(res).to eq(['SELECT * FROM t1 WHERE a = ? AND b IN (?, ?)'])
  end

  context 'when dialect is invalid' do
    it 'raises ArgumentError' do
      expect { SqlInsight.normalize('foo', '') }.to raise_error(ArgumentError, 'Unknown dialect: foo')
    end
  end

  context 'when SQL syntax is invalid' do
    it 'raises SqlInsight::ParserError' do
      expect { SqlInsight.normalize('generic', 'SELECT * FROM t1 WHERE a in (1, 2') }.to raise_error(
        SqlInsight::ParserError,
      )
    end
  end
end
