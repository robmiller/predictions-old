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
  property :who,      String
  property :team,     String
  property :position, Integer
end

DataMapper.finalize
DataMapper.auto_upgrade!
