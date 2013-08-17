require 'rubygems'
require 'bundler'

Bundler.require

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

# This way, we can test database interactions without actually creating
# any data in mySQL.
DataMapper.setup(:default, 'sqlite3::memory:')

