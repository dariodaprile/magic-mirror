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

  post '/signup' do
    @new_user = User.new
    @new_user.first_name = params[:first_name]
    @new_user.email = params[:email]
    @new_user.password = params[:password]
    @new_user.save!
  end

  post '/login'do
    @user = User.first(:email => params[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect "/user/#{:id}"
    else
      redirect '/'
    end
  end

  get '/user/:id' do |id|
    @user = User.get(id)
  end
end