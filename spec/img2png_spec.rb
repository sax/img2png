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
  
  it "responds to gif request" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif'
    last_response.should be_ok
  end

  it "give correct content type" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif'
    last_response.content_type.should == "image/png"
  end
  
  it "converts a gif to an png" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif'
    last_response.body.should match_png_header
  end
  
end