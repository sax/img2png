require 'RMagick'
module CustomMatchers
  class BePng
    def matches?(actual)
      @actual = actual
      @actual.class == Magick::Image
      @actual.format == "PNG"
    end
    
    def failure_message
      "expected a PNG but got #{@actual.format}"
    end
    
    def negative_failure_message
      "expected something other than a PNG"
    end
  end
  
  def be_a_png
    BePng.new
  end
  
  class BeGif
    def matches?(actual)
      @actual = actual
      @actual.class == Magick::Image
      @actual.format == "GIF"
    end
    
    def failure_message
      "expected a GIF but got #{@actual.format}"
    end
    
    def negative_failure_message
      "expected something other than a GIF"
    end
  end
  
  def be_a_gif
    BeGif.new
  end
end