require 'sinatra/base'
require_relative '../models/dmconfig'

class Controller < Sinatra::Base

  configure do
    use Rack::Session::Cookie,  :key => 'rack.session',
                                :secret => 'hello my name is simon'

    set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
  end

  get '/' do
    @user = User.get(session[:user_id])
    erb :home
  end

end