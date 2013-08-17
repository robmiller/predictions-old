require 'forwardable'

class Importer
  extend Forwardable

  def_delegators :'@data', :'[]', :length

  def nicknames
    {
      "manchester city" => "Man City",
      "city" => "Man City",
      "hull city" => "Hull",
      "united" => "Man Utd",
      "man u" => "Man Utd",
      "man united" => "Man Utd",
      "manchester united" => "Man Utd",
      "spurs" => "Tottenham",
      "tottenham hotspur" => "Tottenham",
      "west bromwich albion" => "West Brom",
      "villa" => "Aston Villa",
      "palace" => "Crystal Palace",
      "stoke city" => "Stoke",
      "west ham united" => "West Ham",
      "newcastle united" => "Newcastle",
      "cardiff city" => "Cardiff"
    }
  end

  def initialize(file)
    @file = file
  end

  def parse
    lines = File.readlines(@file)
    @data = lines.each_with_object({}) do |l, data|
      person, team = l.split(/\t/)
      data[person] ||= []
      data[person] << team.strip
    end

    insert_into_db
  end

  def normalise(team)
    real = RealPosition.first(:team.like => team)
    return real.team if real
    return nicknames[team.to_s.downcase] if nicknames[team.to_s.downcase]
    return team
  end

  def insert_into_db
    @data.each do |person, predictions|
      person = Person.first_or_create(:name => person)
      person.predictions.destroy

      predictions.each_with_index do |team, position|
        person.predictions << Prediction.new(
          :team => normalise(team),
          :position => position + 1
        )
      end

      person.save
    end
  end
end
