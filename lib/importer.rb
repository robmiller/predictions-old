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
  end
end
