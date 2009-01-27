require 'dm-core'
require 'logger'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/files.sqlite3")
DataMapper::Logger.new(STDOUT, :debug)
