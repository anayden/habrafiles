require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'

class StoredFile
  include DataMapper::Resource

  property :id,         Integer, :serial => true    # primary serial key
  property :filename,   String,    :nullable => false # cannot be null
  property :sha,        String
  property :downloads,  Integer, :default => 0
  property :filesize,   Integer, :nullable => false
  property :created_at, DateTime
  
  default_scope(:default).update(:order => [:created_at.desc])
end