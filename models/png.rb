require 'RMagick'
require 'open-uri'

module Img2Png
  class Png
    attr_accessor :image
    
    def initialize(options = {})
      self.load options[:src] unless options[:src].nil?
      self
    end

    def load(src)
      begin
        self.image = Magick::Image.read(src).first;
        self
      rescue
        nil
      end
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