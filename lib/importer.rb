require 'forwardable'

class Importer
  extend Forwardable

  def_delegators :'@data', :'[]', :length

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

  def insert_into_db
    @data.each do |person, predictions|
      person = Person.first_or_create(:name => person)
      person.predictions.destroy

      predictions.each_with_index do |team, position|
        person.predictions << Prediction.new(
          :team => team,
          :position => position + 1
        )
      end

      person.save
    end
  end
end
