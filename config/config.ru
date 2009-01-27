require 'init'
Rack::Handler::Thin.run Sinatra::Application, :Port => 3000, :Host => "0.0.0.0"