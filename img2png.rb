require 'rubygems'
require 'sinatra'
require 'erb'
require 'models/png'


class Controller < Sinatra::Base

  mime 'png', 'image/png'

  get "/" do
    erb :index
  end
  
  get "/*gif" do
    redirect "/#{params[:splat]}gif/i.png"
  end
  
  get "/*/i.png" do
    content_type 'image/png'
    png = Img2Png::Png.new(:src => params[:splat].to_s.gsub!(/(https?)\//, '\1://'))
    png.reformat
    png.to_blob
    # send_file png.to_blob, :type => 'image/png', :disposition => 'inline'
  end
  
end