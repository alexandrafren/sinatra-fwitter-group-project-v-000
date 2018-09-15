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
      if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect to '/signup'
      else
        @user.username = params[:username]
        @user.password = params[:password]
        @user.save
        session[:user_id] = @user.id
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
      session.clear
      redirect to '/login'
    end

    get '/tweets/:username' do
      @user = User.find_by(username: params[:username])
      @tweets = Tweet.all.collect { |tweet| tweet.user_id == @user.username}
      erb :'/users/show'
    end

end
