# frozen_string_literal: true

RSpec.describe 'SqlInsight.format' do
  it 'works' do
    res = SqlInsight.format('mysql', "SELECT * \n FROM t1    \n WHERE a = 1")
    expect(res).to eq(['SELECT * FROM t1 WHERE a = 1'])
  end
end
