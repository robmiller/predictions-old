require 'httparty'
require 'nokogiri'
require 'active_support/core_ext/date/calculations'

class BBC
  include HTTParty
  base_uri 'www.bbc.co.uk/sport/football/'

  def table
    return get_table_cache unless table_needs_updating?

    html = fetch_table
    positions = extract_positions(html)

    return get_table_cache unless positions.length > 0

    clear_table_cache

    update_table_cache(positions)
  end

  # Checks whether the league table needs to be fetched from the BBC
  # website, or whether it's been updated recently enough that we can
  # use the cached copy.
  def table_needs_updating?
    first = RealPosition.first
    last_fetched = first ? first.fetched : DateTime.new(0)
    last_fetched.since(3600).past?
  end

  # Clears any stored league table that we have
  def clear_table_cache
    RealPosition.all.destroy
  end

  # Fetches positions from the cache
  def get_table_cache
    RealPosition.all
  end

  # Returns the HTML of the league table page on the BBC website, from
  # which we can extract the teams in order of position.
  def fetch_table
    self.class.get('/premier-league/table')
  end

  # Parses the markup of the page and extracts the teams in order of
  # position.
  def extract_positions(html)
    doc = Nokogiri::HTML(html)
    doc.css('.league-table tbody[data-full-entry-count="20"] td.team-name a')
      .map { |team| team.content }

  end

  def update_table_cache(positions)
    positions.each_with_index do |team, position|
      RealPosition.create(
        :team => team,
        :position => position + 1,
        :fetched => Time.now
      )
    end
  end
end
