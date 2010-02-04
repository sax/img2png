# For deploying Sinatra app to Heroku
# require File.dirname(__FILE__) + '/vendor/gems/environment' if File.exists?('vendor/gems/environment')
# Bundler.require_env

require 'rubygems'
require 'sinatra'
require 'erb'
require 'models/png'
require 'exceptional'

Exceptional.api_key = '8ebb510cbd6126e092625d58912121dd848e3a2e'

module Exceptional
  def self.handle_sinatra(exception, uri, request, params)
    e = Exceptional.parse(exception)

    e.framework = "sinatra"
    e.controller_name = uri
    e.occurred_at = Time.now.strftime("%Y%m%d %H:%M:%S %Z")
    e.environment = request.env.to_hash
    e.url = uri
    e.parameters = params.to_hash

    Exceptional.post e
  end
end

class Controller < Sinatra::Base

  # use Rack::Static, :urls => ['/css', '/js', '/images', '/about'], :root => 'public'
  mime 'png', 'image/png'

  error do
    Exceptional.handle_sinatra(request.env['sinatra.error'], request.env['REQUEST_URI'], request, params)
  end

  get "/" do
    erb :index
  end
  
  get "/*" do
    content_type = 'image/png'
    png = Img2Png::Png.new(:src => params[:splat].to_s.gsub!(/(http)\//, '\1://'))
    png.reformat
    send_file png.to_blob, :type => 'image/png', :disposition => 'inline'
  end
  
end