require 'rubygems'
require 'sinatra'
require 'erb'
require 'models/png'


class Controller < Sinatra::Base

  mime :png, 'image/png'

  get "/\?i=*" do
    redirect "/#{params[:splat].to_s.gsub!(/(https?):\/\//,'\1/')}/i.png"
  end

  get "/" do
    erb :index
  end
  
  get "/*/i.png" do
    content_type 'image/png'
    png = Img2Png::Png.new(:src => params[:splat].to_s.gsub!(/(https?)\//, '\1://'))
    halt 404 if png.image.nil?
    png.reformat
    png.to_blob
    ## TODO : send file doesn't pass tests
    # send_file png.to_blob, :type => 'image/png', :disposition => 'inline'
  end
  
  get %r{/(.+)/i.png} do
    content_type 'image/png'
    png = Img2Png::Png.new(:src => params[:captures].to_s.gsub!(/(https?)\//, '\1://'))
    halt 404 if png.image.nil?
    png.reformat
    png.to_blob
  end
  
  get "/*" do
    redirect "/#{params[:splat]}/i.png"
  end

end