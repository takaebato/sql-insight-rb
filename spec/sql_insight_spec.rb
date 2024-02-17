# frozen_string_literal: true

RSpec.describe SqlInsight do
  it "has a version number" do
    expect(SqlInsight::VERSION).not_to be nil
  end

  it "check definitions" do
    ident = SqlInsight::Ident.new('a')
    ident.value
    expect(SqlInsight::TableReference).to be_a(Class)
    expect(SqlInsight::Tables).to be_a(Class)
    expect(SqlInsight::CrudTables).to be_a(Class)
  end
end
