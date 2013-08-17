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

    (real.position - position).abs
  end
end

class Person
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

  has n, :predictions
end

DataMapper.finalize
DataMapper.auto_upgrade!
