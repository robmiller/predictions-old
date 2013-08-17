require 'bundler'
Bundler.setup

require 'sinatra'
require 'haml'

require 'active_support'

require 'data_mapper'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite://#{File.dirname(__FILE__)}/predictions.db")

require_relative 'lib/models'

require 'letters'

get '/' do
  @people = Person.all
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

