require File.dirname(__FILE__) + "/spec_helper"
require File.dirname(__FILE__) + "/../models/png"

describe "PNG converter" do
  # include Rack::Test::Methods
  describe "initialization" do
    it "should handle PNG files" do
      Magick.formats.keys.should include("PNG")
    end

    it "should initialize with a gif" do
      @png = Img2Png::Png.new(:src => File.dirname(__FILE__)+"/test_images/test.gif")
      @png.image.should be_a_gif
    end
  end

  describe "image formatting" do
    before(:each) do
      @png = Img2Png::Png.new
    end

    it "raises exception if no image" do
      lambda {@png.reformat}.should raise_exception(LoadError)
    end

    describe 'GIF' do
      before(:each) do
        @gif = File.dirname(__FILE__)+"/test_images/test.gif"
      end
      
      it "should return self on load" do
        @png.load(@gif).should be_kind_of(Img2Png::Png)
      end

      it "should load a gif from a file" do
        @png.load(@gif)
        @png.image.should be_a_gif
      end

      it "should load a gif from a URL" do
        @png.load("http://www.google.com/intl/en_ALL/images/logo.gif")
        @png.image.should be_a_gif
      end


      it "reformat doesn't raise exception if GIF" do
        @png.load(@gif)
        lambda {@png.reformat}.should_not raise_exception
      end

      it "converts a gif to a png" do
        @png.load(@gif)
        @png.reformat.should be_a_png
      end

      it "should output a PNG blob" do
        @png.load(@gif).reformat
        @png.to_blob.should match_png_header
      end
    end
  end
end