require 'httparty'
require 'nokogiri'

class BBC
  include HTTParty
  base_uri 'www.bbc.co.uk/sport/football/'

  def table
    @table || begin
      doc = Nokogiri::HTML(self.class.get('/premier-league/table'))
      @table = doc.css('.league-table tbody[data-full-entry-count="20"] td.team-name a')
        .map { |team| team.content }
    end
  end
end
