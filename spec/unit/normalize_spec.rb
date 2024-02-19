# frozen_string_literal: true

RSpec.describe 'SqlInsight.normalize' do
  it 'works' do
    res = SqlInsight.normalize('mysql', "SELECT * \n FROM t1    \n WHERE a = 1 and b in (1, 2)")
    expect(res).to eq(['SELECT * FROM t1 WHERE a = ? AND b IN (?, ?)'])
  end
end
