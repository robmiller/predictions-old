require_relative 'test_helper'

require_relative '../lib/importer.rb'

describe Importer do
  before do
    test_file = File.dirname(__FILE__) + "/../data/import_test.txt"
    @importer = Importer.new(test_file)
    @importer.parse
  end

  it "should parse the file" do
    assert @importer.length > 0
  end

  it "should group predictions by person" do
    assert_equal 2, @importer.length
    assert_equal 20, @importer['nix'].length
  end

  it "should add the predictions to the database" do
    assert_equal 40, Prediction.count
  end
end
