# frozen_string_literal: true

RSpec.describe 'SqlInsight.format' do
  it 'formats SQL' do
    res = SqlInsight.format('generic', "SELECT * \n FROM t1    \n WHERE a = 1 and b in (1, 2)")
    expect(res).to eq(['SELECT * FROM t1 WHERE a = 1 AND b IN (1, 2)'])
  end

  context 'when dialect is invalid' do
    it 'raises ArgumentError' do
      expect { SqlInsight.format('foo', '') }.to raise_error(ArgumentError, 'Unknown dialect: foo')
    end
  end

  context 'when SQL syntax is invalid' do
    it 'raises SqlInsight::ParserError' do
      expect { SqlInsight.format('generic', 'SELECT * FROM t1 WHERE a in (1, 2') }.to raise_error(
        SqlInsight::ParserError,
      )
    end
  end
end
