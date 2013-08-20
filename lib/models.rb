class RealPosition
  include DataMapper::Resource

  property :id,       Serial
  property :team,     String
  property :position, Integer
  property :fetched,  DateTime
end

class Prediction
  include DataMapper::Resource

  property :id,       Serial
  property :team,     String
  property :position, Integer

  belongs_to :person

  def difference
    real = RealPosition.first(team: team)
    return 0 unless real

    difference = (real.position - position).abs
    if [1, 18, 19, 20].include?(position)
      difference * 2
    else
      difference
    end
  end
end

class Person
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

  has n, :predictions

  def predictions_score
    predictions.reduce(0) { |score, p| score + p.difference }
  end
end

DataMapper.finalize
DataMapper.auto_upgrade!
