require 'rubygems'
require 'sinatra'
require 'erb'
require 'models/png'


class Controller < Sinatra::Base

  mime :png, 'image/png'

  get "/" do
    unless params['i'].nil?
      redirect "/#{params[:i].to_s.gsub!(/(https?):\/\//,'\1/')}/i.png"
    else
      erb :index
    end
  end
  
  get %r{/(.+)/i.png} do
    content_type 'image/png'
    png = Img2Png::Png.new(:src => params[:captures].to_s.format_for_png)
    halt 404 if png.image.nil?
    png.reformat
    png.to_blob
  end
  
  get %r{/(.+)} do
    redirect "/#{params[:captures].to_s.format_for_png}/i.png"
  end
end

class String
  def format_for_png
    self.gsub(/(https?)\//, '\1://').gsub(/(https?):\/[^\/]/, '\1://')
  end
end