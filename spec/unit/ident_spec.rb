# frozen_string_literal: true

RSpec.describe SqlInsight::Ident do
  it 'works' do
    ident = SqlInsight::Ident.new('table', nil)
    expect(ident.value).to eq('table')
    expect(ident.quote_style).to eq(nil)
    expect(ident).to be_a(SqlInsight::Ident)
  end
end
