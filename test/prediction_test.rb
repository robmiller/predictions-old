require_relative 'test_helper'

require_relative '../lib/models'

describe Prediction do
  before do
    @person = Person.create(:name => "Test")
  end

  it "should calculate the difference between predictions and reality" do
    real = RealPosition.create(team: "Test United", position: 1)
    @person.predictions << Prediction.new(team: "Test United", position: 11)
    @person.save

    assert_equal 10, @person.predictions.first.difference
  end
end
