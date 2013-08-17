require_relative 'test_helper'

require_relative '../lib/models'

describe Prediction do
  before do
    @person = Person.create(:name => "Test")

    RealPosition.create(team: "Test United", position: 1)

    @person.predictions << Prediction.new(team: "Test United", position: 11)
    @person.save
  end

  it "should calculate the difference between predictions and reality" do
    assert_equal 10, @person.predictions.first.difference
  end

  it "should calculate the user's total score" do
    assert @person.predictions_score > 0
  end
end
