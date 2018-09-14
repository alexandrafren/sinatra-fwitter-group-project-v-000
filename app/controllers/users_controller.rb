class UsersController < ApplicationController

    get '/signup' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :'/users/create_user'
      end
    end

    post '/signup' do
      @user = User.find_or_create_by(email: params[:email])
      @user.username = params[:username]
      @user.password = params[:password]
      if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect to '/signup'
      else
        @user.save
        session[:id] = @user.id
        redirect to '/tweets'
      end
    end

    get '/login' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :'/users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && (@user.authenticate(params[:password]))
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect '/signup'
      end
    end

    get '/logout' do
      erb :'/users/logout'
    end

    post '/logout' do
      session.clear
      redirect to '/login'
    end

    get '/tweets/:user' do
      @user = params[:user]
      @tweets = Tweet.all.collect { |tweet| tweet.user = @user}
      erb :'/users/show'
    end

end
