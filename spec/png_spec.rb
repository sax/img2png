require File.dirname(__FILE__) + "/spec_helper"
require File.dirname(__FILE__) + "/../models/png"

describe "PNG converter" do
  # include Rack::Test::Methods
  before(:each) do
    @png = Img2Png::Png.new
    @gif = File.dirname(__FILE__)+"/test_images/test.gif"
  end
  
  it "should handle PNG files" do
    Magick.formats.keys.should include("PNG")
  end
  
  it "should load a gif from a file" do
    @png.load(@gif).should be_true
    @png.image.should be_a_gif
  end
  
  it "should load a gif" do
    @png.load("http://www.google.com/intl/en_ALL/images/logo.gif").should be_true
    @png.image.should be_a_gif
  end
  
  it "raises exception if no image" do
    lambda {@png.reformat}.should raise_exception(LoadError)
  end
  
  it "doesn't raise exception if image" do
    @png.load(@gif)
    lambda {@png.reformat}.should_not raise_exception
  end
  
  it "converts a gif to a png" do
    @png.load(@gif)
    @png.reformat.should be_a_png
  end
  
  it "should output a PNG blob" do
    # test blob for first 8 characters
  end
end