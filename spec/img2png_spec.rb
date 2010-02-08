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
  
  it "redirects direct gif request" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif'
    last_response.status.should == 302
  end
  
  it "redirects direct jpg request" do
    get '/http/www.dpreview.com/Learn/Articles/GlossaryOptical/images/123di_perspec_wide_far.png'
    last_response.status.should == 302
  end
  
  it "responds 404 to bad image" do
    get 'http://xyz.nothing.nowhere.com/xxx/test.gif/i.png'
    last_response.status.should == 404
  end
  
  it "responds to gif request" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif/i.png'
    last_response.should be_ok
  end

  it "give correct content type" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif/i.png'
    last_response.content_type.should == "image/png"
  end
  
  it "converts a gif to an png" do
    get '/http/www.google.com/intl/en_ALL/images/logo.gif/i.png'
    last_response.body.should match_png_header
  end
  
end