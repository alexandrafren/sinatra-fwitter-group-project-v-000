class TweetsController < ApplicationController

  get '/tweet/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    @tweet.user_id = current_user
    @tweet.save
    redirect to '/tweets'
  end

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweet/:id' do
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && current_user == @tweet.user.id
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to '/tweets#{@tweet.id}'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user == @tweet.user_id
      @tweet.delete
    else
      redirect to '/login'
    end
  end

end
