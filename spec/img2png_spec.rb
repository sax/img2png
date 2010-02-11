require File.dirname(__FILE__) + "/spec_helper"
require File.dirname(__FILE__) + "/../img2png"

describe "Img2Png Controller" do
  include Rack::Test::Methods

  def app
    @app ||= Controller
  end

  it "serves an about page on root" do
    get '/'
    last_response.should be_ok
    last_response.body.should include("About Img2Png")
  end

  describe "404 reponses" do
    it "responds 404 to bad image" do
      get '/http://xyz.nothing.nowhere.com/xxx/test.gif/i.png'
      last_response.status.should == 404
    end

    it "responds 404 to .com html page" do
      get '/http/www.google.com/i.png'
      last_response.status.should == 404
    end

    it "responds 404 to html page" do
      get '/http/www.google.com/index.html/i.png'
      last_response.status.should == 404
    end
  end
  
  it "should redirect /?i= requests" do
    get '/?i=http://dl.dropbox.com/u/4306917/img2png/test.gif'
    last_response.status.should == 302
  end

  describe 'GIF' do
    before(:each) do
      @url = '/http/dl.dropbox.com/u/4306917/img2png/test.gif'
    end

    it "redirects direct gif request" do
      get @url
      last_response.status.should == 302
    end

    it "responds to gif request" do
      get "#{@url}/i.png"
      last_response.should be_ok
    end

    it "give correct content type converting gif" do
      get "#{@url}/i.png"
      last_response.content_type.should == "image/png"
    end

    it "converts a gif to a png" do
      get "#{@url}/i.png"
      last_response.body.should match_png_header
    end
  end

  describe "JPG" do
    before(:each) do
      @url = '/http/dl.dropbox.com/u/4306917/img2png/test.jpg'
    end

    it "redirects direct jpg request" do
      get @url
      last_response.status.should == 302
    end

    it "responds to a jpeg request" do
      get "#{@url}/i.png"
      last_response.should be_ok
    end

    it "gives correct content type converting jpg" do
      get "#{@url}/i.png"
      last_response.content_type.should == "image/png"
    end

    it "converts a jpeg to a png" do
      get "#{@url}/i.png"
      last_response.body.should match_png_header
    end
  end
end