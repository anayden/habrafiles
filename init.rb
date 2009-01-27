require 'rubygems'
require 'logger'
require 'ftools'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require File.expand_path(File.dirname(__FILE__) + '/lib/stored_file')
require File.expand_path(File.dirname(__FILE__) + '/lib/sinatra/lib/sinatra')
require File.expand_path(File.dirname(__FILE__) + '/config/config')
require File.expand_path(File.dirname(__FILE__) + '/lib/authorization')

helpers do
  include Sinatra::Authorization
end

get '/' do
  require_administrative_privileges
  @files = StoredFile.all
  haml :list
end

post '/' do
  require_administrative_privileges
  tempfile = params['file'][:tempfile]
  filename = params['file'][:filename]
  digest = Digest::SHA1.hexdigest(filename)
  @file = StoredFile.create :filename => filename, :sha => digest, :filesize => File.size(tempfile.path)
  File.copy(tempfile.path, "./files/#{@file.id}.upload")
  redirect '/'
end

get '/style.css' do
  response['Content-Type'] = 'text/css; charset=utf-8'
  sass :style
end

get '/:sha/:id' do
  @file = StoredFile.first :sha => params[:sha], :id => params[:id]
  unless params[:nowait] == 'true'
    haml :download
  else
    @file.downloads += 1
    @file.save
    send_file "./files/#{@file.id}.upload", :filename => @file.filename, :type => 'Application/octet-stream'
  end
end

# delete file
get '/:sha/:id/delete' do
  require_administrative_privileges
  @file = StoredFile.first :sha => params[:sha], :id => params[:id]
  File.delete("./files/#{@file.id}.upload")
  @file.destroy
  redirect '/'
end