require_relative 'test_helper'

require_relative '../lib/bbc.rb'

describe BBC do
  before do
    @bbc = BBC.new
  end

  it "should fetch the latest table from the BBC" do
    assert @bbc.table
  end

  it "should parse 20 unique teams" do
    assert_equal 20, @bbc.table.length
    assert_equal 20, @bbc.table.uniq.length
  end
end

