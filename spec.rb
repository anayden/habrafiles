require 'sinatra'
require 'sinatra/test/rspec'
require 'init'

describe 'TrashFiles app' do  
  it 'should render template with delay' do
    @file = StoredFile.first 
    get "/#{@file.sha}/#{@file.id}"
    @response['Content-Type'].should == "text/html"
  end
  
  it 'should give file if ?nowait=true is supplied' do
    @file = StoredFile.first 
    get "/#{@file.sha}/#{@file.id}?nowait=true"
    @response['Content-Type'].should == "Application/octet-stream"
    @response['Content-Disposition'].should == "attachment; filename=\"#{@file.filename}\""
  end
end