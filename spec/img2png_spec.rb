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
  
  it "converts a gif to an png" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif'
    last_response.should be_ok
    last_response.should be_a_png
  end
  
end