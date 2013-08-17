require_relative 'test_helper'

require_relative '../lib/importer.rb'

describe Importer do
  before do
    test_file = File.dirname(__FILE__) + "/../data/import_test.txt"
    @importer = Importer.new(test_file)
  end

  it "should parse the file" do
    assert @importer.parse.length > 0
  end

  it "should group predictions by person" do
    @importer.parse

    assert_equal 2, @importer.length
    assert_equal 20, @importer['nix'].length
  end
end
