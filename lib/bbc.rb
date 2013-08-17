require 'httparty'
require 'nokogiri'
require 'active_support/core_ext/date/calculations'

class BBC
  include HTTParty
  base_uri 'www.bbc.co.uk/sport/football/'

  def table
    first = RealPosition.first
    last_fetched = first ? first.fetched : DateTime.new(0)

    # If we've fetched the real league table recently enough, then
    # return the one from the database.
    return RealPosition.all if last_fetched.since(3600).future?

    doc = Nokogiri::HTML(self.class.get('/premier-league/table'))
    positions = doc.css('.league-table tbody[data-full-entry-count="20"] td.team-name a')
      .map { |team| team.content }

    positions.each_with_index do |team, position|
      RealPosition.create(
        :team => team,
        :position => position + 1,
        :fetched => Time.now
      )
    end
  end
end
