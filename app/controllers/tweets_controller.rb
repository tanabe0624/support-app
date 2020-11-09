class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @tweets = Tweet.all.includes(:user).order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet.id)
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @tweet.user_id
      @tweet.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:title, :text, :category_id).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @tweet.user_id
      redirect_to root_path
    end
  end
end