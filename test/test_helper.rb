require 'rubygems'
require 'bundler'

Bundler.require

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

DataMapper.setup(:default, 'sqlite3::memory:')

require_relative '../helpers/init'
require_relative '../lib/models'

