require 'rmagick'
require 'open-uri'

module Img2Png
  class Png
    attr_accessor :image
    
    def load(url)
      # @img = File.exists?(url) ?
      self.image = Magick::Image.read(url).first;
    end
    
    def reformat
      raise(LoadError, "no image loaded") if self.image.nil?
      self.image.format = "PNG"
      self.image
    end
    
    def to_blob
      image.to_blob
    end
  end
end