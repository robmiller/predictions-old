require 'bundler'
Bundler.setup

require 'sinatra'
require 'haml'
require 'active_support'

require 'data_mapper'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite://#{File.dirname(__FILE__)}/predictions.db")

require_relative 'helpers/init'
require_relative 'lib/models'

require 'letters'

set :haml, :format => :html5, :layout => :layout

get '/' do
  @people = Person.all.sort_by { |p| p.predictions_score }
  @real = RealPosition.all

  haml :index
end

get '/import' do
  require_relative 'lib/importer'

  importer = Importer.new('predictions.txt')
  importer.parse
  "Imported #{importer.length} people's predictions"
end

get '/update-table' do
  require_relative 'lib/bbc'

  table = BBC.new.table
  table.join("<br>")
end

