$LOAD_PATH.unshift File.dirname(__FILE__) + '/..'
 
require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'
require 'spec/custom_matchers'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

Spec::Runner.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include CustomMatchers
end