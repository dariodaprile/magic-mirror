require 'dm-core'
require 'dm-migrations'
require_relative './user'

  DataMapper::Logger.new($stdout, :debug)

  if ENV['RACK_ENV'] == 'production'
    connection_string = ENV['HEROKU_POSTGRESQL_GOLD_URL']
  elsif ENV['RACK_ENV'] == 'test'
    connection_string = "postgres://localhost/magic_mirror_test"
  else
    connection_string = "postgres://localhost/magic_mirror_development"
  end

DataMapper.setup(:default, connection_string)
DataMapper.finalize
DataMapper.auto_migrate!