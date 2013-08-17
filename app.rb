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
  RealPosition.all.to_json
end

