ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'

require_relative '../lib/controllers/controller'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Controller.new
end

describe Controller do

  describe "GET /" do
    it "renders the welcome message" do
      get'/'
      last_response.ok?.should be_true
      expect(last_response.body).to include "Magic Mirror"
    end
  end
end


