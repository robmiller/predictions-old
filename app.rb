require 'bundler'
Bundler.setup

require 'sinatra'
require 'haml'

require 'active_support'

require 'data_mapper'

require 'letters'

get '/' do
  "hello world"
end

