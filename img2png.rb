# For deploying Sinatra app to Heroku
# require File.dirname(__FILE__) + '/vendor/gems/environment' if File.exists?('vendor/gems/environment')
# Bundler.require_env

require 'rubygems'
require 'sinatra'
require 'erb'
require 'models/png'


class Controller < Sinatra::Base

  # use Rack::Static, :urls => ['/css', '/js', '/images', '/about'], :root => 'public'
  mime 'png', 'image/png'

  get "/" do
    erb :index
  end
  
  get "/*" do
    content_type = 'image/png'
    png = Img2Png::Png.new(:src => params[:splat].to_s.gsub!(/(http)\//, '\1://'))
    png.reformat
    png.to_blob
  end
  
end