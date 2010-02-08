require File.dirname(__FILE__) + "/spec_helper"
require File.dirname(__FILE__) + "/../models/png"

describe "PNG converter" do
  # include Rack::Test::Methods
  describe "initialization" do
    it "should handle PNG files" do
      Magick.formats.keys.should include("PNG")
    end

  end

  describe "image formatting" do
    before(:each) do
      @png = Img2Png::Png.new
    end
    
    it "returns nil on loading bad URL" do
      @png.load("http://xyz.nothing.nowhere.com/xxx/test.gif").should be_nil
    end
    
    it "returns nil on loading html page" do
      @png.load("http://www.google.com").should be_nil
    end

    it "raises exception on reformat if no image" do
      lambda {@png.reformat}.should raise_exception(LoadError)
    end

    describe 'GIF' do
      before(:each) do
        @gif = File.dirname(__FILE__)+"/test_images/test.gif"
        @gif_url = 'http://dl.dropbox.com/u/4306917/img2png/test.gif'
      end

      it "should initialize with a gif" do
        @png = Img2Png::Png.new(:src => @gif)
        @png.image.should be_a_gif
      end

      it "should initialize with a gif URL" do
        @png = Img2Png::Png.new(:src => @gif_url)
        @png.image.should be_a_gif
      end
      
      it "should return self on load" do
        @png.load(@gif).should be_kind_of(Img2Png::Png)
      end

      it "should load a gif from a file" do
        @png.load(@gif)
        @png.image.should be_a_gif
      end

      it "should load a gif from a URL" do
        @png.load(@gif_url)
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
    describe 'JPEG' do
      before(:each) do
        @jpeg = File.dirname(__FILE__)+"/test_images/test.jpg"
        @jpeg_url = 'http://dl.dropbox.com/u/4306917/img2png/test.jpg'
      end

      it "should initialize with a jpeg" do
        @png = Img2Png::Png.new(:src => @jpeg)
        @png.image.should be_a_jpeg
      end

      it "should initialize with a jpeg URL" do
        @png = Img2Png::Png.new(:src => @jpeg_url)
        @png.image.should be_a_jpeg
      end
      
      it "should return self on load" do
        @png.load(@jpeg).should be_kind_of(Img2Png::Png)
      end

      it "should load a jpeg from a file" do
        @png.load(@jpeg)
        @png.image.should be_a_jpeg
      end

      it "should load a jpeg from a URL" do
        @png.load(@jpeg_url)
        @png.image.should be_a_jpeg
      end

      it "reformat doesn't raise exception if JPEG" do
        @png.load(@jpeg)
        lambda {@png.reformat}.should_not raise_exception
      end

      it "converts a jpeg to a png" do
        @png.load(@jpeg)
        @png.reformat.should be_a_png
      end

      it "should output a PNG blob" do
        @png.load(@jpeg).reformat
        @png.to_blob.should match_png_header
      end
    end
  end
end