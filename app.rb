require 'sinatra/base'

module Chat
  class App < Sinatra::Base
    get "/" do
      if session[:email] 
        erb :"index.html"
      else
        redirect '/auth/admin'
      end
    end

    post '/auth/admin/callback' do
      auth_details = request.env['omniauth.auth']
      session[:email] = auth_details.info['email']
      session[:name] = auth_details.info['first_name']
      p auth_details
      redirect '/'
    end

    get '/auth/failure' do
      params[:message]
      # landing page
    end

    get "/assets/js/application.js" do
      content_type :js
      @scheme = ENV['RACK_ENV'] == "production" ? "wss://" : "ws://"
      erb :"application.js"
    end
  end
end
